/*
  Yiyi Chen
  chen1234@purdue.edu

  alu file interface
*/
`ifndef ALU_FILE_IF_VH
`define ALU_FILE_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_file_if;
  // import types
  import cpu_types_pkg::*;

   word_t  input_a, input_b, out;
   logic neg, overflow, zero;
   aluop_t aluop;
   

  // alu file ports
  modport alu (
    input   input_a, input_b, aluop,
    output  neg, overflow, zero, out
  );
  // alu file tb
  modport tb (
    input   neg, overflow, zero, out,
    output  input_a, input_b, aluop
  );
endinterface

`endif //ALU_FILE_IF_VH

