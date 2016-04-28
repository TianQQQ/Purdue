// $Id: $
// File name:   sensor_d.sv
// Created:     1/22/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: 1.2.2

module sensor_d(
	input wire [3:0] sensors,
	output wire error
);
	
	assign error = sensors[0] | (sensors[1] & sensors[2]) | (sensors[1] & sensors[3]);

endmodule
