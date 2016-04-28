// $Id: $
// File name:   sensor_s.sv
// Created:     1/22/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: lab22

module sensor_s(
	input wire [3:0] sensors,
	output wire error
);

	wire s1; 
	and A1 (int_andl1, sensors[1], sensors[3]); 
	and A2 (int_andl2, sensors[1], sensors[2]);
	or O1 (int_orl, int_andl1, int_andl2);
	or O2 (error, int_orl, sensors[0]); 	

endmodule












