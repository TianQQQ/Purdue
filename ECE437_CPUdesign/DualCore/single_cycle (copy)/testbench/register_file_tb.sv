/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK,nRST,rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test (input logic CLK, output logic nRST, register_file_if.tb rfif_tb);
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

   initial begin
      @(posedge CLK);
      nRST = 0;
      @(posedge CLK);
      @(posedge CLK);
      //TEST write to register 0
      nRST = 1;
      rfif.wdat = v1;
      rfif.wsel = 0;
      rfif.WEN = 1;
      @(posedge CLK);
      @(posedge CLK);
      rfif.WEN = 0;
      rfif.rsel1 = 0;
      rfif.rsel2 = 1;
      @(posedge CLK);
      assert (rfif.rdat1 == v1)
	$display("Test case 1 passed!");
      else
	$display("Test case 1 failed!");
      assert (rfif.rdat2 == v1)
	$display("Test case 2 failed!");
      else
	$display("Test case 2 passed!");
      
      //Test read and write to register
      rfif.wdat = v2;
      rfif.wsel = 5;
      rfif.WEN = 1;
      @(posedge CLK);
      @(posedge CLK);
      rfif.WEN = 0;
      rfif.rsel1 = 0;
      rfif.rsel2 = 5;
      @(posedge CLK);
      @(posedge CLK);
      assert (rfif.rdat2 == v2)
	$display("Test case 3 passed!");
      else
	$display("Test case 3 failed!");
      assert (rfif.rdat1 == v1)
	$display("Test case 4 passed!");
      else
	$display("Test case 4 failed!");

      @(posedge CLK);
      nRST = 0;
      @(posedge CLK);
      assert (rfif.rdat1 == 0)
	$display("Test case 5 passed!");
      else
	$display("Test case 5 failed!");
      assert (rfif.rdat2 == 0)
	$display("Test case 6 passed!");
      else
	$display("Test case 6 failed!");
   end // initial begin
   
endprogram
