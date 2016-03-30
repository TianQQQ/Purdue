// $Id: $
// File name:   magnitude.sv
// Created:     2/17/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: magnitude

module magnitude
(
	input reg [16:0] in,
	output reg [15:0] out
);
	assign out[15:0] = (in[16] == 0)?in[15:0]:(~in[15:0]+1); // 2's compliment
endmodule
