// File name:   sync_low.sv
// Created:     1/19/2015
// Author:      Tim Pritchett
// Version:     1.0  Initial Design Entry
// Description: sync_low

module sync
(
	input wire clk,
	input wire n_reset,
	input wire data_ready,
	output reg out
);

	reg tmp;
	always_ff @ (posedge clk, negedge n_reset)
	begin
		if (1'b0 == n_reset)
		begin
			out <= 0;
			tmp <= 0;
		end
		else
		begin
			tmp <= data_ready;
			out <= tmp;
		end
	end		
endmodule

