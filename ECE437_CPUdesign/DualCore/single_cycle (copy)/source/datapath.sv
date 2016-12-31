/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

// different unit interface
`include "register_file_if.vh"
`include "alu_file_if.vh"
`include "pc_if.vh"
`include "control_unit_if.vh"  
`include "request_unit_if.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  // interfces
   register_file_if rfif();
   alu_file_if aluif();
   control_unit_if cuif();
   request_unit_if ruif(); 
   pc_if pcif();

   //portmaps
   alu_file       ALU(aluif);
   register_file  RF(CLK, nRST, rfif);
   control_unit   CU(cuif);
   request_unit   RU(CLK, nRST, ruif);
   pc             PC(CLK, nRST, pcif);

   word_t wdat, extimm;
   word_t aluoperand;

   assign rfif.WEN = dpif.imemload[31:26]==6'b100011 ? dpif.dhit ? cuif.WEN : 0 : dpif.ihit ? cuif.WEN : 0;

   //ALU connection
   assign aluif.input_a = rfif.rdat1;
   assign aluif.input_b = aluoperand;  //the other input from mux into alu, need to be create
   assign aluif.aluop = cuif.aluop;  //the aluop will be sent out from control unit

   //Register
   assign rfif.wsel  = cuif.wsel; //the rd will also come from control unit
   assign rfif.rsel1 = cuif.rsel1;
   assign rfif.rsel2 = cuif.rsel2;
   assign rfif.wdat = wdat; //write data will be selected from various source !!!
   
   //Program Counter
   assign pcif.source1 = cuif.source1;  //branch address
   assign pcif.source2 = cuif.source2;  //jTYPE instruction
   assign pcif.source3 = cuif.source3;  //jump top register value
   assign pcif.j_addr  = cuif.j_addr;
   assign pcif.jregaddr = cuif.jregaddr;
   assign pcif.immediate  = cuif.immediate;
   assign pcif.ramfull = ruif.ramfull; //from request unit

   //Control Unit
   assign cuif.porto = aluif.out; 
   assign cuif.zeroflag = aluif.zero;
   assign cuif.instr = dpif.imemload;
   assign cuif.rdat2 = rfif.rdat2;

   //Request Unit
   assign ruif.ihit = dpif.ihit;
   assign ruif.dhit = dpif.dhit;
   assign ruif.dWEN = cuif.dWEN;
   assign ruif.dREN = cuif.dREN;
   assign ruif.cuhlt = cuif.halt;

   //DataPath
   assign dpif.imemaddr = pcif.imemaddr;
   assign dpif.dmemaddr = cuif.datamemaddr;
   assign dpif.dmemstore = cuif.datamemstore;
   assign dpif.imemREN = ruif.imemREN;
   assign dpif.dmemREN = ruif.dmemREN;
   assign dpif.dmemWEN = ruif.dmemWEN;
   assign dpif.halt = ruif.halt;
   assign dpif.datomic = '0; 
   

   assign extimm = cuif.extop==2 ? {cuif.immediate, 16'b0000000000000000} : cuif.extop==0 ? {16'b0000000000000000, cuif.immediate} : cuif.immediate[15] ? {16'b1111111111111111, cuif.immediate} :  {16'b0000000000000000, cuif.immediate};

   assign aluoperand = cuif.irsel ? extimm : rfif.rdat2;

   assign wdat = cuif.memtoreg ? dpif.dmemload : cuif.memtoreg == 0 ? cuif.wdat : pcif.returnaddr;
   
   
endmodule
