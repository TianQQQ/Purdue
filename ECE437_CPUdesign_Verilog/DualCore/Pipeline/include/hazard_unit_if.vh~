`ifndef HARZ_IF_VH
`define HARZ_IF_VH

// typedefs
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  import cpu_types_pkg::*;

  ////////////////////////////////////////////   structural hazard
  // Two isntructions need the same hardware at the same time
  //inputs
  logic dhit;
  logic ihit;

  //outputs
  logic data_or_instruction_next;

  ///////////////////////////////////////////   data hazard
  // data not ready
  logic lw_instr;
  logic lw_instr_next;
  logic [4:0] output_Instr_ID_RS;
  logic [4:0] output_Instr_ID_RD;
  logic [4:0] output_RegDst_MEM;
  logic [4:0] output_RegWen_MEM;

  logic [2:0] src1_hazard_t; 
  logic [2:0] src2_hazard_t; //0:no hazard 01:forwardA 10:forwardB
  logic stall_for_load;

endinterface


`endif
