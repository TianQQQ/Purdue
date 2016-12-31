//CPU
`include "cpu_types_pkg.vh"
`include "bran_pred_if.vh"
`include "pipeline_reg_pkg.vh"
module bran_pred(input logic CLK, nRST,
                 bran_pred_if bpif);

   import pipeline_reg_pkg::*;

   bran_t [3:0] branchTable;


   always_comb begin

   	bpif.hit = (bpif.addr1[31:2] == {branchTable[0].tag, 2'b00}) & branchTable[0].valid | 
                     (bpif.addr1[31:2] == {branchTable[1].tag, 2'b01}) & branchTable[1].valid |
                     (bpif.addr1[31:2] == {branchTable[2].tag, 2'b10}) & branchTable[2].valid |
                     (bpif.addr1[31:2] == {branchTable[3].tag, 2'b11}) & branchTable[3].valid ;

  	 bpif.pc_bran_pred = (branchTable[bpif.addr1[3:2]].predict_state == TW) | 
                              (branchTable[bpif.addr1[3:2]].predict_state == TS);
	      casez(bpif.addr1[3:2])
		0:bpif.branaddr_out = branchTable[0].addr;
		1:bpif.branaddr_out = branchTable[1].addr;
		2:bpif.branaddr_out = branchTable[2].addr;
		3:bpif.branaddr_out = branchTable[3].addr;
	      endcase 
   end



   always_ff @(posedge CLK, negedge nRST) begin
      if(nRST == 1'b0) begin
         branchTable[0].valid <= 0;
         branchTable[1].valid <= 0;
         branchTable[2].valid <= 0;
         branchTable[3].valid <= 0;
         branchTable[0].predict_state <= NS;
         branchTable[1].predict_state <= NS;
         branchTable[2].predict_state <= NS;
         branchTable[3].predict_state <= NS;
      end
      else if(bpif.branEN) begin
         casez(bpif.addr2[1:0])
           0:begin
              branchTable[0].tag <= bpif.addr2[29:2];
              branchTable[0].valid <= 1;
              branchTable[0].addr <= bpif.branaddr_in;
              casez(branchTable[0].predict_state)

                TW: branchTable[0].predict_state <= bpif.take ? TS : NS;
                TS: branchTable[0].predict_state <= bpif.take ? TS : TW;
                NW: branchTable[0].predict_state <= bpif.take ? TS : NS;
                NS: branchTable[0].predict_state <= bpif.take ? NW : NS;
              endcase
           end
           1:begin
              branchTable[1].tag <= bpif.addr2[29:2];
              branchTable[1].valid <= 1;
              branchTable[1].addr <= bpif.branaddr_in;
              casez(branchTable[1].predict_state)

                NS: branchTable[1].predict_state <= bpif.take ? NW : NS;
                TW: branchTable[1].predict_state <= bpif.take ? TS : NS;
                TS: branchTable[1].predict_state <= bpif.take ? TS : TW;
                NW: branchTable[1].predict_state <= bpif.take ? TS : NS;
              endcase 
           end
           2:begin
              branchTable[2].tag <= bpif.addr2[29:2];
              branchTable[2].valid <= 1;
              branchTable[2].addr <= bpif.branaddr_in;
              casez(branchTable[2].predict_state)
                NW: branchTable[2].predict_state <= bpif.take ? TS : NS;
                NS: branchTable[2].predict_state <= bpif.take ? NW : NS;
                TW: branchTable[2].predict_state <= bpif.take ? TS : NS;
                TS: branchTable[2].predict_state <= bpif.take ? TS : TW;
              endcase 
           end
           3:begin
              branchTable[3].tag <= bpif.addr2[29:2];
              branchTable[3].valid <= 1;
              branchTable[3].addr <= bpif.branaddr_in;
              casez(branchTable[3].predict_state)
                NW: branchTable[3].predict_state <= bpif.take ? TS : NS;
                NS: branchTable[3].predict_state <= bpif.take ? NW : NS;
                TW: branchTable[3].predict_state <= bpif.take ? TS : NS;
                TS: branchTable[3].predict_state <= bpif.take ? TS : TW;
              endcase
           end
         endcase
      end
   end


   
   
endmodule
