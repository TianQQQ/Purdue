// $Id: $
// File name:   fir_filter.sv
// Created:     2/17/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: fir_filter.sv
module fir_filter
(
	input wire clk,
	input wire n_reset,
	input wire [15:0] sample_data,
	input wire [15:0] fir_coefficient,
	input wire load_coeff,
	input wire data_ready,
	output wire one_k_samples,
	output wire modwait,
	output wire [15:0] fir_out,
	output wire err
);
	wire dr,lc,cnt_up,clear,overflow;
	wire [16:0] outreg_data;
	wire [2:0] op;
	wire [3:0] src1;
	wire [3:0] src2;
	wire [3:0] dest;

	sync SYN0(.clk(clk), .n_reset(n_reset), .data_ready(data_ready),.out(dr));
	sync SYN1(.clk(clk), .n_reset(n_reset), .data_ready(load_coeff),.out(lc));
	controller CTL(.clk(clk), .n_reset(n_reset), .dr(dr), .lc(lc), .op(op), .src1(src1), .src2(src2), .dest(dest), .clear(clear), .cnt_up(cnt_up), .overflow(overflow), .modwait(modwait), .err(err));
	datapath DPT(.clk(clk), .ext_data1(sample_data), .ext_data2(fir_coefficient), .op(op), .src1(src1), .src2(src2), .dest(dest), .overflow(overflow), .outreg_data(outreg_data), .n_reset(n_reset));
	counter CTR(.clk(clk), .n_reset(n_reset), .one_k_samples(one_k_samples), .cnt_up(cnt_up), .clear(clear));
	magnitude MAG(.in(outreg_data), .out(fir_out));

endmodule
