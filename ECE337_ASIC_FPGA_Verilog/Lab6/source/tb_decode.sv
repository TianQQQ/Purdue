// $Id: $
// File name:   tb_decode.sv
// Created:     2/25/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: tbdecode
`timescale 1ns / 10ps

module tb_decode
  ();

   localparam CLK_PERIOD = 2.5;
   localparam CHECK_DELAY = 1;

   reg clk;
   reg n_rst;
   reg d_plus;
   reg shift_enable;
   reg eop;
   reg d_orig;

   decode DUT (.clk(clk), .n_rst(n_rst), .d_plus(d_plus), .shift_enable(shift_enable), .eop(eop), .d_orig(d_orig));
      
   always
     begin
	clk = 1'b0;
	#(CLK_PERIOD/2.0);
	clk = 1'b1;
	#(CLK_PERIOD/2.0);
     end

   initial
     begin
	d_plus = 0;
	shift_enable = 0;
	eop =0;

	n_rst = 1;
	@(posedge clk);
	n_rst = 0;
	@(posedge clk);
	n_rst = 1;

	d_plus = 1;
	@(posedge clk);
	@(negedge clk);
	assert(d_orig == 0) begin
	   $info("PASS TEST CASE  1");
	end else begin
	   $info("FAIL TEST CASE  1");
	end

	@(posedge clk);
	shift_enable = 1;
	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	shift_enable = 0;
	@(posedge clk);
	@(negedge clk);
	assert(d_orig == 1) begin
	   $info("PASS TEST CASE  2");
	end else begin
	   $info("FAIL TEST CASE  2");
	end


	@(posedge clk);
	d_plus = 0;
	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	shift_enable = 1;
	eop = 1;
	@(posedge clk);
	shift_enable = 0;
	eop = 0;
	@(posedge clk);
	@(negedge clk);
	assert(d_orig == 0) begin
	   $info("PASS TEST CASE  4");
	end else begin
	   $info("FAIL TEST CASE  4");
	end


	@(posedge clk);
	d_plus = 1;
	@(posedge clk);
	shift_enable = 1;
	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	shift_enable = 0;
	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	@(negedge clk);
	assert(d_orig == 1) begin
	   $info("PASS TEST CASE  5");
	end else begin
	   $info("FAIL TEST CASE  5");
	end

	@(posedge clk);
	d_plus = 0;
	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	shift_enable = 1;
	eop = 1;
	@(posedge clk);
	shift_enable = 0;
	eop = 0;
	@(posedge clk);
	@(negedge clk);
	assert(d_orig == 0) begin
	   $info("PASS TEST CASE  6");
	end else begin
	   $info("FAIL TEST CASE  6");
	end

	@(posedge clk);
	d_plus = 1;
	@(posedge clk);
	@(negedge clk);
	assert(d_orig == 1) begin
	   $info("PASS TEST CASE  7");
	end else begin
	   $info("FAIL TEST CASE  7");
	end
	
	@(posedge clk);
	shift_enable = 1;
	@(posedge clk);
	shift_enable = 0;
	@(posedge clk);
	@(negedge clk);
	assert(d_orig == 1) begin
	   $info("PASS TEST CASE  8");
	end else begin
	   $info("FAIL TEST CASE  8");
	end
	
	@(posedge clk);
	d_plus = 0;
	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	shift_enable = 1;
	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	shift_enable = 0;
	@(posedge clk);
	@(negedge clk);
	assert(d_orig == 1) begin
	   $info("PASS TEST CASE  9");
	end else begin
	   $info("FAIL TEST CASE  9");
	end

     end
   
endmodule // tb_decode
