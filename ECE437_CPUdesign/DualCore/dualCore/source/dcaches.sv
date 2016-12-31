// CPU

`include "cpu_types_pkg.vh"
module dcaches(input logic CLK, nRST,
              datapath_cache_if.dcache dcif,
              caches_if.dcache cif);
   
   import cpu_types_pkg::word_t;
   
   typedef word_t [1:0] block_t;
   typedef logic [25:0] tag_t;
   typedef enum         logic [3:0] {Idle,  Load_state0, Load_state1, Write_state0, Write_state1, Invalidate_state,
                                     Cachewrite_state0, Cachewrite_state1, FLUSHED} stateType;
   typedef logic [1:0]  MSI_state; 
   
   logic                replace, dirty, clean_next, match0, match1, Dirty_frame_next, 
                        sp_dhit, sp_match0, sp_match1,link_match,sp_lhit;
   MSI_state snoop_state, match_state;
   
   logic [2:0]          Dirty_index_next;
   logic [3:0]          writeback_block;
   
  ///////////////////////////////////////////////////////////////// D_Cache 
  // 1024 bits
  // valid[91], dirty[90], tag[89:64], data1[63:32], data2[31:0]
  /////////////////////////////////////////////////////////////////  
   
   typedef struct packed{
      tag_t [1:0] tag;

      MSI_state [1:0] state;
      logic        lru;
      block_t [1:0] blocks;
   }data_frame;

   stateType state, state_next;
   data_frame [7:0] dtable, datatable_next;
   typedef struct packed{
     logic                link_valid;
     logic [29:0]         link_addr;
   }linkreg_pack;

   linkreg_pack link_register;
   linkreg_pack link_register_next;
	




   assign dcif.dhit = (state != Invalidate_state) ? ((!cif.ccwait | !sp_dhit) & (match0 | match1) & (!dcif.dmemWEN | match_state[1]))
     : (!cif.ccwait & cif.ccinv);


   ////////// cannot be combinational logic, otherwise will be infinity loop
   assign link_match = link_register.link_addr == dcif.dmemaddr[31:2] & link_register.link_valid;
   assign match0 = ((dtable[dcif.dmemaddr[5:3]].state[0] == 2'b11 | 
                    dtable[dcif.dmemaddr[5:3]].state[0] == 2'b01) & 
                    dtable[dcif.dmemaddr[5:3]].tag[0] == dcif.dmemaddr[31:6]);
   

   assign sp_lhit = link_register.link_addr == cif.ccsnoopaddr[31:2];


   assign sp_match0 = ((dtable[cif.ccsnoopaddr[5:3]].state[0] == 2'b11 | 
                       dtable[cif.ccsnoopaddr[5:3]].state[0] == 2'b01) & 
                    dtable[cif.ccsnoopaddr[5:3]].tag[0] == cif.ccsnoopaddr[31:6]);
   
   assign sp_match1 = ((dtable[cif.ccsnoopaddr[5:3]].state[1] == 2'b11 | 
                           dtable[cif.ccsnoopaddr[5:3]].state[1] == 2'b01) & 
                          dtable[cif.ccsnoopaddr[5:3]].tag[1] == cif.ccsnoopaddr[31:6]);


   assign match1 = ((dtable[dcif.dmemaddr[5:3]].state[1] == 2'b11 | 
                    dtable[dcif.dmemaddr[5:3]].state[1] == 2'b01) & 
                    dtable[dcif.dmemaddr[5:3]].tag[1] == dcif.dmemaddr[31:6]);



   assign snoop_state = sp_match0 ? dtable[cif.ccsnoopaddr[5:3]].state[0] : 
                        dtable[cif.ccsnoopaddr[5:3]].state[1];
   assign match_state = match0 ? dtable[dcif.dmemaddr[5:3]].state[0] : 
                        dtable[dcif.dmemaddr[5:3]].state[1];
   assign dcif.dmemload = (dcif.datomic & dcif.dmemWEN& link_match ) ? 1 :(dcif.datomic & dcif.dmemWEN & !link_match)? 0:
                          match0 ? dtable[dcif.dmemaddr[5:3]].blocks[0][dcif.dmemaddr[2]] : 
                          dtable[dcif.dmemaddr[5:3]].blocks[1][dcif.dmemaddr[2]];
////////////////////////////////////////////////////////// dirty logic
   assign Dirty_frame_next = (dtable[0].state[0] == 2'b11)? 1'b0 : (dtable[0].state[1] == 2'b11)? 1'b1 : (dtable[1].state[0] == 2'b11)? 1'b0 : (dtable[1].state[1] == 2'b11) ? 1'b1 : (dtable[2].state[0] == 2'b11) ? 1'b0 :(dtable[2].state[1] == 2'b11)? 1'b1 :(dtable[3].state[0] == 2'b11)? 1'b0 :(dtable[3].state[1] == 2'b11)? 1'b1 : (dtable[4].state[0] == 2'b11)? 1'b0 :(dtable[4].state[1] == 2'b11)? 1'b1 :(dtable[5].state[0] == 2'b11)? 1'b0 : (dtable[5].state[1] == 2'b11)? 1'b1 :(dtable[6].state[0] == 2'b11)? 1'b0 : (dtable[6].state[1] == 2'b11)? 1'b1 :(dtable[7].state[0] == 2'b11)? 1'b0 : 1'b1;

   assign Dirty_index_next = (dtable[0].state[0] == 2'b11)? 3'd0 : (dtable[0].state[1] == 2'b11)? 3'd0 : (dtable[1].state[0] == 2'b11)? 3'd1 : (dtable[1].state[1] == 2'b11) ? 3'd1 : (dtable[2].state[0] == 2'b11) ? 3'd2 :(dtable[2].state[1] == 2'b11)? 3'd2 :(dtable[3].state[0] == 2'b11)? 3'd3 :(dtable[3].state[1] == 2'b11)? 3'd3 : (dtable[4].state[0] == 2'b11)? 3'd4 :(dtable[4].state[1] == 2'b11)? 3'd4 :(dtable[5].state[0] == 2'b11)? 3'd5 : (dtable[5].state[1] == 2'b11)? 3'd5 :(dtable[6].state[0] == 2'b11)? 3'd6 : (dtable[6].state[1] == 2'b11)? 3'd6 :(dtable[7].state[0] == 2'b11)? 3'd7 : 3'd7;

   always_ff @(posedge CLK, negedge nRST) begin
      if(nRST == 1'b0) begin
         dtable[0].lru <= 1'b0;
         dtable[0].state <= {2'b00, 2'b00};
         dtable[1].lru <= 1'b0;
         dtable[1].state <= {2'b00, 2'b00};
         dtable[2].lru <= 1'b0;
         dtable[2].state <= {2'b00, 2'b00};
         dtable[3].lru <= 1'b0;
         dtable[3].state <= {2'b00, 2'b00};
         dtable[4].lru <= 1'b0;
         dtable[4].state <= {2'b00, 2'b00};
         dtable[5].lru <= 1'b0;
         dtable[5].state <= {2'b00, 2'b00};
         dtable[6].lru <= 1'b0;
         dtable[6].state <= {2'b00, 2'b00};
         dtable[7].lru <= 1'b0;
         dtable[7].state <= {2'b00, 2'b00};
      end 
      else if (state == Load_state1 & !cif.dwait) begin
         dtable[dcif.dmemaddr[5:3]].state[replace] <= dcif.dmemREN ? 2'b01 : 2'b11;
         dtable[dcif.dmemaddr[5:3]].tag[replace] <= dcif.dmemaddr[31:6];
         dtable[dcif.dmemaddr[5:3]].blocks[replace][1] <= cif.dload;
      end

      else if(state == Cachewrite_state1 & !cif.dwait)
         dtable[cif.ccsnoopaddr[5:3]].state[sp_match1] <= cif.ccinv ? 2'b00 : 2'b01;
      else if(state == Idle & dcif.dhit & dcif.dmemWEN & 
              (!dcif.datomic | link_match)) begin
         dtable[dcif.dmemaddr[5:3]].blocks[match1][dcif.dmemaddr[2]] <= dcif.dmemstore;
         dtable[dcif.dmemaddr[5:3]].state[match1] <= 2'b11;
         dtable[dcif.dmemaddr[5:3]].lru <= match1;
      end
      else if(state == Idle & dcif.dhit & dcif.dmemREN)begin
         dtable[dcif.dmemaddr[5:3]].lru <= match1;
      end
      else if(state == Load_state0 & !cif.dwait) begin
         dtable[dcif.dmemaddr[5:3]].blocks[replace][0] <= cif.dload;
      end
      else if(state == Write_state1 & !cif.dwait & !dcif.halt) begin
          dtable[dcif.dmemaddr[5:3]].state[replace] <= 2'b00;
      end
      else if(state == Write_state1 & !cif.dwait & dcif.halt) begin
         dtable[Dirty_index_next].state[Dirty_frame_next] <= 2'b01;
      end

      else if(state == Invalidate_state & !cif.ccwait & cif.ccinv)
      begin
         dtable[dcif.dmemaddr[5:3]].blocks[match1][dcif.dmemaddr[2]] <= dcif.dmemstore;
         dtable[dcif.dmemaddr[5:3]].state[match1] <= 2'b11;
         dtable[dcif.dmemaddr[5:3]].lru <= match1;
       end
   end



  always_comb begin

   sp_dhit = sp_match0 | sp_match1;
   replace = ((dtable[dcif.dmemaddr[5:3]].state[0] == 2'b11 | 
                     dtable[dcif.dmemaddr[5:3]].state[0] == 2'b01) & 
                     (dtable[dcif.dmemaddr[5:3]].state[1] == 2'b11 | 
                     dtable[dcif.dmemaddr[5:3]].state[1] == 2'b01)) ?
                    !dtable[dcif.dmemaddr[5:3]].lru : 
                    (dtable[dcif.dmemaddr[5:3]].state[0] == 2'b11 | 
                     dtable[dcif.dmemaddr[5:3]].state[0] == 2'b01);
    dirty = dtable[dcif.dmemaddr[5:3]].state[replace] == 2'b11;
    clean_next = (dtable[0].state[0] == 2'b11 | dtable[0].state[1] == 2'b11 ) |
                  (dtable[1].state[0] == 2'b11 | dtable[1].state[1] == 2'b11 ) |
                  (dtable[2].state[0] == 2'b11 | dtable[2].state[1] == 2'b11 ) |
                  (dtable[3].state[0] == 2'b11 | dtable[3].state[1] == 2'b11 ) |
                  (dtable[4].state[0] == 2'b11 | dtable[4].state[1] == 2'b11 ) |
                  (dtable[5].state[0] == 2'b11 | dtable[5].state[1] == 2'b11 ) |
                  (dtable[6].state[0] == 2'b11 | dtable[6].state[1] == 2'b11 ) |
                  (dtable[7].state[0] == 2'b11 | dtable[7].state[1] == 2'b11 );
    link_register_next=link_register;
    if(cif.ccwait & sp_lhit & cif.ccinv | dcif.dmemWEN & link_match & dcif.dhit)
    begin
      link_register_next.link_valid=0;
    end
    else if(dcif.datomic & dcif.dmemREN & !cif.ccwait)
    begin
      link_register_next.link_valid=1;
      link_register_next.link_addr = dcif.dmemaddr[31:2];  
    end
  end




   always_comb begin
      state_next = state;
      cif.dREN = 1'b0;
      cif.dWEN = 1'b0;
      cif.daddr = 'x;
      cif.dstore = 'x;
      cif.cctrans = 1'b0;
      cif.ccwrite = 1'b0;
      dcif.flushed = 1'b0;
      casez(state)
        Idle: begin
          cif.cctrans = cif.ccwait & (sp_dhit & !cif.ccinv & snoop_state == 2'b11);
          cif.ccwrite = cif.ccwait & sp_dhit;
          if(dcif.halt & !clean_next)
            state_next = FLUSHED;
          else if(cif.ccwait & sp_dhit)
            state_next = Cachewrite_state0;
          else if(dcif.dmemWEN & (match1 | match0) & match_state==2'b01)
            state_next = Invalidate_state;
          else if(dcif.halt & clean_next)
            state_next = Write_state0;
          else if((dcif.dmemREN | dcif.dmemWEN) & !dcif.dhit & dirty)
            state_next = Write_state0;
          else if((dcif.dmemREN | dcif.dmemWEN) & !dcif.dhit&!cif.ccwait)
            state_next = Load_state0;
        end 

        Invalidate_state: begin
           cif.cctrans = cif.ccwait ? (sp_dhit & !cif.ccinv & snoop_state == 2'b11) : 1'b0;
           cif.ccwrite = cif.ccwait ? sp_dhit : 1'b1;
           cif.daddr = {dcif.dmemaddr[31:3], 3'b000};
           if(cif.ccwait & sp_dhit)
             state_next = Cachewrite_state0;
           else if(!cif.ccwait & cif.ccinv)
             state_next = Idle;
        end
          
        Load_state0: begin
           cif.cctrans = cif.ccwait ? (sp_dhit & !cif.ccinv & snoop_state == 2'b11) : 1'b1;
           cif.ccwrite = cif.ccwait ? sp_dhit : dcif.dmemWEN;
           cif.dREN = dcif.dmemREN;
           cif.daddr = {dcif.dmemaddr[31:3], 3'b000};
           if(cif.ccwait & sp_dhit)
             state_next = Cachewrite_state0;
           else if(!cif.dwait)
             state_next = Load_state1;
        end

        Load_state1: begin
           cif.dREN = 1'b1;
           cif.daddr = {dcif.dmemaddr[31:3], 3'b100};
           cif.ccwrite = dcif.dmemWEN;
           
           if(!cif.dwait)
             state_next = Idle;
        end

        Write_state0: begin
           cif.dWEN = 1'b1;
           cif.daddr = dcif.halt ? {dtable[writeback_block[3:1]].tag[writeback_block[0]], writeback_block[3:1], 3'b000} : 
                       {dtable[dcif.dmemaddr[5:3]].tag[replace], dcif.dmemaddr[5:3], 3'b000};
           cif.dstore = dcif.halt ? dtable[writeback_block[3:1]].blocks[writeback_block[0]][0] : 
                        dtable[dcif.dmemaddr[5:3]].blocks[replace][0];
           if(cif.ccwait & sp_dhit)
             state_next = Cachewrite_state0;
           else if(!cif.dwait)
             state_next = Write_state1;
        end

        Write_state1: begin
           cif.dWEN = 1'b1;
           cif.daddr = dcif.halt ? {dtable[writeback_block[3:1]].tag[writeback_block[0]], writeback_block[3:1], 3'b100} :
                       {dtable[dcif.dmemaddr[5:3]].tag[replace], dcif.dmemaddr[5:3], 3'b100};
           cif.dstore = dcif.halt ? dtable[writeback_block[3:1]].blocks[writeback_block[0]][1] : 
                        dtable[dcif.dmemaddr[5:3]].blocks[replace][1];
           if(!cif.dwait & !dcif.halt)
             state_next = Load_state0;
           else if(!cif.dwait & dcif.halt)
             state_next = Idle;
        end

        Cachewrite_state0: begin
           cif.cctrans = (sp_dhit & !cif.ccinv & snoop_state == 2'b11);
           cif.ccwrite = sp_dhit;
           cif.dstore = sp_match0 ? dtable[cif.ccsnoopaddr[5:3]].blocks[0][0] :
                        dtable[cif.ccsnoopaddr[5:3]].blocks[1][0];
           cif.daddr = {cif.ccsnoopaddr[31:3], 3'b000};
           
           if(!cif.dwait)
             state_next = Cachewrite_state1;
        end

        Cachewrite_state1: begin
           cif.cctrans = (sp_dhit & !cif.ccinv & snoop_state == 2'b11);
           cif.ccwrite = sp_dhit;
           cif.dstore = sp_match0 ? dtable[cif.ccsnoopaddr[5:3]].blocks[0][1] :
                        dtable[cif.ccsnoopaddr[5:3]].blocks[1][1];
           cif.daddr = {cif.ccsnoopaddr[31:3], 3'b100};
           
           if(!cif.dwait)
             state_next = Idle;
        end

        FLUSHED: begin
           dcif.flushed = 1'b1;
        end
      endcase
   end

   always_ff @(posedge CLK, negedge nRST) begin
      	if(nRST == 1'b0) 
	begin
        	state <= Idle;
		writeback_block <= '0;
		link_register.link_valid <=0;
        	link_register.link_addr <= 32'h0;
	end	
	else if(dcif.halt & state == Idle)
	begin
		state <= state_next;
        	writeback_block <= {Dirty_index_next, Dirty_frame_next};
		link_register <= link_register_next;
	end
     	else
	begin
        	state <= state_next;
		link_register <= link_register_next;
	end
   end
	
endmodule
