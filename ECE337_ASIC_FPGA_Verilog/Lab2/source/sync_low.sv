// $Id: $
// File name:   sync_low.sv
// Created:     1/28/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: sync_low


module sync_low
(
 input wire clk,
 input wire n_rst,
 input wire async_in,
 output reg sync_out
 );

   reg Q;
   
   always_ff @ (posedge clk, negedge n_rst) begin
      if (n_rst == 0) begin
	 Q <= 0;
	 sync_out <= 0;
      end
      else begin
	 Q <= async_in;  //input to Q,  Q to output when reset != 0
	 sync_out <= Q;
      end
   end
	 
endmodule
