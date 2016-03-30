// $Id: $
// File name:   sensor_b.sv
// Created:     1/22/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: behavioral


module sensor_b(
	input wire [3:0] sensors,
	output reg error
);

	always_comb
	begin
		error = sensors[0] | (sensors[3] & sensors[1]) | (sensors[1] & sensors[2]);
	end
endmodule
