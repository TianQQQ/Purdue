/*
  Yiyi Chen
  chen1234@purdue.edu

  alu file test bench
*/

// mapped needs this
`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;


// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  parameter PERIOD = 10;

  // interface
  hazard_unit_if hzif();
  // test program
  test PROG (hzif);
  // DUT

  hazard_unit DUT(hzif);


endmodule // hazard_unit_tb

program test (hazard_unit_if.tb alu_tb);

   int testcae = 1;

   initial begin
      //TEST 1


      #(5)
	hzif.dhit = 0;
	hzif.ihit = 0;
	hzif.output_Instr_ID_RS = 00001;
	hzif.output_Instr_ID_RD = 00001;
	hzif.output_RegDst_MEM = 00001;
	hzif.output_RegWen_MEM = 00001;


      #(5)
	hzif.dhit = 1;
	hzif.ihit = 1;
	hzif.output_Instr_ID_RS = 00001;
	hzif.output_Instr_ID_RD = 00001;
	hzif.output_RegDst_MEM = 00001;
	hzif.output_RegWen_MEM = 00001;

   end // initial begin
endprogram // test
   
