/*
 yiyi chen
 evillase@gmail.com

 datapath contains register file, control, hazard,
 muxes, and glue logic for processor
 */
`include "cpu_types_pkg.vh"
`include "pipeline_reg_pkg.vh"

//`include "bran_pred_if.vh"

`include "control_unit_if.vh"
`include "hazard_if.vh"
`include "forward_unit_if.vh"
`include "datapath_cache_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"
module datapath (
                 input logic CLK, nRST,
                 datapath_cache_if.dp dpif
                 );
   // pc init
   parameter PC_INIT = 0;
   
   // import types
   import cpu_types_pkg::*;
   import pipeline_reg_pkg::*;
   
   //Declare pipeline registers
   ifid_t ifid;
   idex_t idex;
   exmem_t exmem;
   memwb_t memwb;
   
   //
   j_t instrj;
   assign instrj = ifid.instr;
   i_t instri;
   assign instri = ifid.instr;
   r_t instrr;
   assign instrr = ifid.instr;

   logic [15:0]              imme16;
   word_t immeext, pc, pc_nxt, pc_p4;

   logic                     memwb_en, bran_pred_take;

   //PC & jump logic
   logic zero, ifid_flush;
   word_t jumpaddr, pc_plus4_plusimm, pc_new;
   word_t wdat;
   //Forward MUX
   word_t rdat2_sel, rdat1_sel;


   
   register_file_if rfif();
   control_unit_if cuif();

   hazard_if huif();
   bran_pred_if bpif();
   alu_if aluif();
   forward_unit_if fuif();
   

   hazard HU(huif);
   bran_pred BP(CLK, nRST, bpif);
 
   alu ALU(aluif);
   control_unit CU(cuif);
   register_file RF(CLK, nRST, rfif);
   forward_unit FU(fuif);

   always_comb begin
      if(exmem.dmemREN | exmem.dmemWEN) 
   	memwb_en = dpif.dhit;
      else
        memwb_en = 1'b1;

      if(cuif.shamt_sel) 
   	 imme16 = {11'd0, instrr.shamt};
      else
         imme16 = instri.imm;
      
      dpif.halt = memwb.halt;




//////////////////////////////////////////////////   jump logic
      if((idex.pcsrc == 1)) 
   	 jumpaddr = {idex.pc_p4[31:28],idex.instr[25:0],2'b0};
      else
         jumpaddr =  rdat1_sel;

   end




///////////////////////////////////////////////////   program counter 



   assign pc_plus4_plusimm = idex.pc_p4 + {idex.immext[29:0],2'b0};
   assign zero = rdat1_sel == rdat2_sel;
   assign pc_nxt = ((idex.pcsrc == 3 &  ((idex.bran == !zero) == idex.take)) | idex.pcsrc != 3) ?  pc_p4 : 
                   ((idex.bran == !zero) ? pc_plus4_plusimm : idex.pc_p4);
   assign pc_new = (idex.pcsrc != 3 & idex.pcsrc != 0) ? jumpaddr : pc_nxt;
   assign pc_p4 = pc + 4;
   assign ifid_flush = (idex.pcsrc == 1 | idex.pcsrc == 2 | (idex.pcsrc == 3 & ((idex.bran == !zero) != idex.take)));

   assign  immeext = (cuif.extop == 2) ? {instri.imm, 16'h0} : ((cuif.extop == 1) ? {{16{imme16[15]}}, imme16} : {16'd0, imme16});
   always_ff @(posedge CLK, negedge nRST) begin
      if(nRST == 1'b0) begin
         pc <= PC_INIT;
      end
      else if(ifid_flush)
        pc <= pc_new;
      else if(!huif.idex_flush & memwb_en & dpif.ihit) begin
        pc <= bran_pred_take ? {bpif.branaddr_out, 2'b00} : pc_new;
      end
   end 
   assign dpif.imemaddr = pc;



   
   //****************************** Instruction Fetch --> Instruction Decode *****************************//
   always_ff @(posedge CLK, negedge nRST) begin:IFID_REG
      if(nRST == 1'b0) begin
         ifid.instr <= '0;
         ifid.pc_p4 <= PC_INIT + 4;
         ifid.take <= 0;
         ifid.addr <= 0;
      end
      else if(ifid_flush)
        ifid.instr <= '0;
      else if(huif.ifid_EN & (memwb_en & dpif.ihit)) begin//ifid enable
         ifid.instr <= dpif.imemload;
         ifid.pc_p4 <= pc_p4;
         ifid.take <= bran_pred_take;
         ifid.addr <= pc[31:2];
      end
      else if(!huif.ifid_EN | !memwb_en)
        ifid <= ifid;
      else
        ifid.instr <= '0;
      
   end

   //******************************* Instruction Decode --> Execuation ***********************************//
   // forwarding is to address RAW hazards (data hazards)
   // RAW hazard may exist on register when i in EX and j in later stage.
   // compare pending writes ( in later stage) with operand regs of current instruction
   always_ff @(posedge CLK, negedge nRST) begin: IDEX_REG
     if(nRST == 1'b0) begin
        idex <= '0;
     end
     else if((huif.idex_flush | ifid_flush) & memwb_en)
       idex <= '0;
     else if(memwb_en) begin
        idex.rdat1 <= rfif.rdat1;
        idex.rdat2 <= rfif.rdat2;

        idex.immext <= immeext;
        idex.aluop <= aluop_t'(cuif.aluop);
        idex.wsel <= cuif.wsel_sel;
        idex.pcsrc <= cuif.pcsrc;
        idex.data_sel <= cuif.wdat_sel;
        idex.bran <= cuif.bran;
        idex.alusrc <= cuif.aluin_sel;
        idex.pc_p4 <= ifid.pc_p4;
        idex.regWEN <= cuif.rWEN;

        idex.dmemWEN <= cuif.dWEN;
        idex.halt <= cuif.halt;
        idex.instr <= ifid.instr;
        idex.take <= ifid.take;
        idex.dmemREN <= cuif.dREN;
        idex.datomic <= cuif.datomic;
        idex.addr <= ifid.addr;
     end // if ()
   end // always_ff @

   //******************************* Execuation --> Memory ***********************************//
   always_ff @(posedge CLK, negedge nRST) begin
     if(nRST == 1'b0) begin 
        exmem <= '0;     
     end
     else if(memwb_en)begin
        exmem.pc_p4 <= idex.pc_p4;
        exmem.rdat2 <= rdat2_sel;
        exmem.aluout <= aluif.alu_out;

        exmem.data_sel <= idex.data_sel;
        exmem.immext <= idex.immext;
        exmem.dmemREN <= idex.dmemREN;
        exmem.dmemWEN <= idex.dmemWEN;
        exmem.regWEN <= idex.regWEN;
        exmem.datomic <= idex.datomic;
        exmem.wsel <= idex.wsel;
        exmem.instr <= idex.instr;
        
        // exmem.instr <= idex.instr;
        exmem.halt <= idex.halt;
        
     end // if ()

   end // always_ff @


   //******************************* Memory --> WB ***********************************//
   always_ff @(posedge CLK, negedge nRST) begin:MEMWB_REG
      if(nRST == 1'b0) begin
         memwb <= '0;
      end
      else if(memwb.halt) begin
         memwb.halt <= 1'b1;
         
      end
      else if(memwb_en)begin

         memwb.wsel <= exmem.wsel;
         memwb.regWEN <= exmem.regWEN;
         memwb.halt <= exmem.halt;
         memwb.wdat <= wdat;
         memwb.instr<=exmem.instr;
         
      end
   end // block: MEMWB_REG
   
   //**************************************************** hazard unit ****************************************//

always_comb begin


   huif.dmemREN = idex.dmemREN;
   huif.ifid_rt = instrr.rt;
   huif.idex_rt = idex.instr[20:16];
   huif.ifid_rs = instrr.rs;
   huif.pcsrc = cuif.pcsrc;
    //////////////////////////datapath 
   dpif.imemREN = !dpif.halt;
   dpif.dmemREN = exmem.dmemREN;
   dpif.dmemWEN = exmem.dmemWEN;
   dpif.dmemstore = exmem.rdat2;
   dpif.datomic = exmem.datomic;
   dpif.dmemaddr = exmem.aluout;
   /////////////////////////////////////////////////////// Forward Unit IF
   fuif.exmem_wsel = exmem.wsel;

   fuif.idex_rs = idex.instr[25:21];
   fuif.idex_rt = idex.instr[20:16];
   fuif.memwb_regWEN = memwb.regWEN;
   fuif.exmem_regWEN = exmem.regWEN;

   fuif.memwb_wsel = memwb.wsel;
   fuif.exmem_data_sel = exmem.data_sel;
   fuif.memwb_wdat = memwb.wdat;
   fuif.exmem_aluout = exmem.aluout;
   fuif.exmem_immext = exmem.immext;
   fuif.exmem_pc_p4 = exmem.pc_p4;
   //


   bran_pred_take = !ifid_flush & bpif.pc_bran_pred & bpif.hit;
   bpif.branaddr_in = pc_plus4_plusimm[31:2];
   bpif.addr1 = dpif.imemaddr;
   bpif.addr2 = idex.addr;
   bpif.take = idex.bran == !zero;
   bpif.branEN = idex.pcsrc == 3;
   cuif.instr = ifid.instr;

   
   //reg
   rfif.WEN = memwb.regWEN;
   rfif.rsel1 = instri.rs;
   rfif.rsel2 = instri.rt;
   rfif.wsel = memwb.wsel;
   rfif.wdat = memwb.wdat;
   
      casez(exmem.data_sel)
        2'b00: wdat = exmem.immext;
        2'b01: wdat = dpif.dmemload;
        2'b10: wdat = exmem.aluout;
        2'b11: wdat = exmem.pc_p4;
      endcase 

   ////////////////////////////////////////////////// Forward multiplexer 

   if (fuif.fwd_sel2 == 2)
	rdat2_sel = fuif.exmem_wdat;
   else if (fuif.fwd_sel2 == 1) 
	rdat2_sel = memwb.wdat;
   else
  	rdat2_sel = idex.rdat2;


   if (fuif.fwd_sel1 == 2)
	rdat1_sel = fuif.exmem_wdat;
   else if (fuif.fwd_sel1 == 1) 
	rdat1_sel = memwb.wdat;
   else
  	rdat1_sel = idex.rdat1;



   //********************************************  alu 
   aluif.alu_in1 = rdat1_sel;
   aluif.aluop = idex.aluop;

   if (idex.alusrc)
	aluif.alu_in2  =idex.immext;
   else
  	aluif.alu_in2  = rdat2_sel;



end

   



   
   
  
endmodule
