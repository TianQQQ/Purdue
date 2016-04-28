// $Id: $
// File name:   sr_9bit.sv
// Created:     2/11/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: sr_9bits.sv
module sr_9bit 
(
	input wire clk,
	input wire n_rst,
	input wire shift_strobe,
	input wire serial_in,
	output wire [7:0] packet_data,
	output wire stop_bit
);
	reg [8:0]packet_out;
	flex_stp_sr #(9,0) SHIFT_REGISTER_9bit
	(
		.clk         (clk),
		.n_rst       (n_rst),
		.shift_enable(shift_strobe),
		.serial_in   (serial_in),
		.parallel_out(packet_out)
	);
	assign packet_data = packet_out[7:0];
	assign stop_bit = packet_out[8];
endmodule
