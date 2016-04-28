// $Id: $
// File name:   tb_eop_detect.sv
// Created:     2/25/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: tb_eop_dectect


`timescale 1ns / 100ps

module tb_eop_detect
  ();

   reg d_plus;
   reg d_minus;
   reg eop;
   
   eop_detect DUT(.d_plus(d_plus), .d_minus(d_minus), .eop(eop));
   
   initial
     begin	

	d_plus = 0;
	d_minus = 0;
	#(1)
	assert(eop == 1) begin
	   $info("PASS TEST CASE");
	end else begin
	   $info("FAIL TEST CASE");
	end


	d_plus = 1;
	d_minus = 1;
	#(1)
	assert(eop == 0) begin
	   $info("PASS TEST CASE");
	end else begin
	   $info("FAIL TEST CASE");
	end

	d_plus = 0;
	d_minus = 0;
	#(1)
	assert(eop == 1) begin
	   $info("PASS TEST CASE");
	end else begin
	   $info("FAIL TEST CASE");
	end


	d_plus = 0;
	d_minus = 1;
	#(1)
	assert(eop == 0) begin
	   $info("PASS TEST CASE");
	end else begin
	   $info("FAIL TEST CASE");
	end


	d_plus = 1;
	d_minus = 0;
	#(1)
	assert(eop == 0) begin
	   $info("PASS TEST CASE");
	end else begin
	   $info("FAIL TEST CASE");
	end

	d_plus = 0;
	d_minus = 0;
	#(1)
	assert(eop == 1) begin
	   $info("PASS TEST CASE");
	end else begin
	   $info("FAIL TEST CASE");
	end


	d_plus = 0;
	d_minus = 1;
	#(1)
	assert(eop == 0) begin
	   $info("PASS TEST CASE");
	end else begin
	   $info("FAIL TEST CASE");
	end


	d_plus = 0;
	d_minus = 0;
	#(1)
	assert(eop == 1) begin
	   $info("PASS TEST CASE");
	end else begin
	   $info("FAIL TEST CASE");
	end


	d_plus = 1;
	d_minus = 1;
	#(1)
	assert(eop == 0) begin
	   $info("PASS TEST CASE");
	end else begin
	   $info("FAIL TEST CASE");
	end


	d_plus = 0;
	d_minus = 0;
	#(1)
	assert(eop == 1) begin
	   $info("PASS TEST CASE");
	end else begin
	   $info("FAIL TEST CASE");
	end

     end
   
endmodule
