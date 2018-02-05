/*
  Yiyi Chen
  chen1234@purdue.edu

*/
`ifndef CONTR_UNIT_IF_VH
`define CONTR_UNIT_IF_VH

// typedefs
`include "cpu_types_pkg.vh"

interface control_unit_if;
  import cpu_types_pkg::*;

  //input
  logic [31:0] Instr;

  //for hazard detection
  logic input_hazard_Reg_ID;

  aluop_t ALUOP;
  logic MemToReg;
  logic PcToReg;
  logic MemWrite;
  logic careOF;
  logic halt;
  logic [2:0] jump;
  logic [1:0] RegDst; 
  logic RegWen; 
  logic [2:0] ALUSrc; 


endinterface


`endif
