// $Id: $
// File name:   counter.sv
// Created:     2/17/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: counter
module counter
(
	input wire clk,
	input wire n_reset,
	input wire cnt_up,
	input wire clear,
	output wire one_k_samples
);
	flex_counter #(10) CT(.clk(clk), .n_rst(n_reset), .clear(clear), .count_enable(cnt_up), .rollover_val(10'd999), .count_out(), .rollover_flag(one_k_samples));
// dont need count out and rollover at 10'd1000
endmodule
