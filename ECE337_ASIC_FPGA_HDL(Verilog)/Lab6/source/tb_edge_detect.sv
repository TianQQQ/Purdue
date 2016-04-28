// $Id: $
// File name:   tb_edge_detect.sv
// Created:     2/25/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: tbdegedetect


`timescale 1ns / 10ps

module tb_edge_detect
  ();

   localparam CLK_PERIOD = 2.5;
   localparam CHECK_DELAY = 1;

   reg clk;
   reg n_rst;
   reg d_plus;
   reg d_edge;

   edge_detect DUT (
		    .clk(clk),
		    .n_rst(n_rst),
		    .d_plus(d_plus),
		    .d_edge(d_edge)
		    );
   
   always
     begin
	clk = 1'b0;
	#(CLK_PERIOD/2.0);
	clk = 1'b1;
	#(CLK_PERIOD/2.0);
     end

   initial
     begin
	d_plus = 1'b1;
	n_rst = 1;
	@(posedge clk);
	n_rst = 0;
	@(posedge clk);
	n_rst = 1;
	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
		
	@(posedge clk);
	@(negedge clk);
	@(posedge clk);	
	d_plus = 1'b1;
	@(negedge clk);
	assert(d_edge == 0) begin
	   $info("PASS TEST CASE  1");
	end else begin
	   $info("FAIL TEST CASE  1");
	end


	@(posedge clk);
	d_plus = 1'b0;
	@(posedge clk);
	@(negedge clk);
	assert(d_edge == 1) begin
	   $info("PASS TEST CASE  2");
	end else begin
	   $info("FAIL TEST CASE  2");
	end


	@(posedge clk);
	d_plus = 1'b0;
	@(posedge clk);
	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	@(negedge clk);
	assert(d_edge == 0) begin
	   $info("PASS TEST CASE  3");
	end else begin
	   $info("FAIL TEST CASE  3");
	end

	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	@(posedge clk);
	d_plus = 1'b0;
	@(posedge clk);
	@(negedge clk);
	assert(d_edge == 0) begin
	   $info("PASS TEST CASE  4");
	end else begin
	   $info("FAIL TEST CASE  4");
	end

	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	d_plus = 1'b0;
	@(negedge clk);
	assert(d_edge == 0) begin
	   $info("PASS TEST CASE  5");
	end else begin
	   $info("FAIL TEST CASE  5");
	end

	d_plus = 1'b1;
	@(negedge clk);
	assert(d_edge == 1) begin
	   $info("PASS TEST CASE  6");
	end else begin
	   $info("FAIL TEST CASE  6");
	end


	d_plus = 1'b0;
	@(negedge clk);
	assert(d_edge == 1) begin
	   $info("PASS TEST CASE  7");
	end else begin
	   $info("FAIL TEST CASE  7");
	end


	d_plus = 1'b0;
	@(negedge clk);
	assert(d_edge == 0) begin
	   $info("PASS TEST CASE  8");
	end else begin
	   $info("FAIL TEST CASE  8");
	end


	d_plus = 1'b1;
	@(negedge clk);
	assert(d_edge == 1) begin
	   $info("PASS TEST CASE  9");
	end else begin
	   $info("FAIL TEST CASE  9");
	end


	d_plus = 1'b0;
	@(negedge clk);
	assert(d_edge == 1) begin
	   $info("PASS TEST CASE  10");
	end else begin
	   $info("FAIL TEST CASE  10");
	end

	d_plus = 1'b1;
	@(negedge clk);
	assert(d_edge == 1) begin
	   $info("PASS TEST CASE  11");
	end else begin
	   $info("FAIL TEST CASE  11");
	end

	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	@(posedge clk);
	d_plus = 1'b1;
	@(negedge clk);
	assert(d_edge == 0) begin
	   $info("PASS TEST CASE  12");
	end else begin
	   $info("FAIL TEST CASE  12");
	end

	@(posedge clk);
	@(negedge clk);
	@(posedge clk);
	@(posedge clk);
	d_plus = 1'b1;
	@(posedge clk);
	@(posedge clk);
	@(negedge clk);
	assert(d_edge == 0) begin
	   $info("PASS TEST CASE  13");
	end else begin
	   $info("FAIL TEST CASE  13");
	end

     end
   
endmodule
