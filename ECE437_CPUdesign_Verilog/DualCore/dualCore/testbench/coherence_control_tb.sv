// cpu types
`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"

`timescale 1 ns / 1 ns
import cpu_types_pkg::*;
module coherence_control_tb;

  parameter PERIOD = 20;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

 /*    caches_if cif0();
   caches_if cif1();
   cache_control_if #(.CPUS(1)) ccif (cif0, cif1);
*/
   bus_if 

  always #(PERIOD/2) CLK++;
  logic [31:0] daddr [1:0];
  logic [1:0] cctrans;
  logic [1:0] ccwrite;
  logic [1:0] dwait;
  logic [31:0] ccsnoopaddr [1:0];
  logic [1:0] ccwait;
  logic [1:0] ccinv;

  // test program
  test PROG (CLK, nRST, daddr, cctrans, ccwrite, dwait, ccsnoopaddr, ccwait, ccinv);

  // DUT
  coherence_control DUT(CLK, nRST, daddr, cctrans, ccwrite, dwait, ccsnoopaddr, ccwait, ccinv);

/*
  ram RAM(CLK, nRST, ramif);
  memory_control MC (CLK, nRST, ccif);

  assign ramif.ramaddr = ccif.ramaddr;
  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramREN = ccif.ramREN;
  assign ramif.ramWEN = ccif.ramWEN;
  assign ccif.ramstate = ramif.ramstate;
  assign ccif.ramload = ramif.ramload;

*/

endmodule

program test (
  input logic CLK, 
  output logic nRST,
  output logic fifo_empty, 
  coherence_control_if.snoopy_bus bus_if
);

parameter CPUID = 0;
parameter PERIOD = 10;

initial begin: TEST


nRST = 1'b0;
@(posedge CLK);


nRST = 1'b1;

#(PERIOD*1);

daddr[0] = 0;
daddr[1] = 0;
cctrans = 0;
ccwrite = 0;
dwait = 0;

@(posedge CLK);











end

endprogram

























