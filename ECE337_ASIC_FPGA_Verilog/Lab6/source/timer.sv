// $Id: $
// File name:   timer.sv
// Created:     3/1/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: timer.sv

module timer (
	      input 	  n_rst,
	      input 	  clk,
	      input 	  d_edge,
	      input 	  rcving,
	      output wire shift_enable,
	      output wire byte_received);

   reg [3:0] 		  cnt1;
   reg [3:0] 		  cnt2;
   // using already working flex_counter
   flex_counter #(4) CNT1 (
			   .clk(clk),
			   .n_rst(n_rst),
			   .clear(~rcving||d_edge),
			   .count_enable(rcving),
			   .rollover_val(4'b1000),
			   .count_out(cnt1),
			   .rollover_flag());

   assign shift_enable=(cnt1==2'b10);

   flex_counter #(4) CNT2 (
			   .clk(clk),
			   .n_rst(n_rst),
			   .clear(~rcving||byte_received),
			   .count_enable(shift_enable),
			   .rollover_val(4'b1000),
			   .count_out(cnt2),
			   .rollover_flag(byte_received));
endmodule

