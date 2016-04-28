// $Id: $
// File name:   edge_detect.sv
// Created:     2/25/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: edge_detect.sv

module edge_detect
  (
   input wire clk,
   input wire n_rst,
   input wire d_plus,
   output reg d_edge
   );

   reg 	      previous_state, nextState;       
   always_ff @ (posedge clk, negedge n_rst) begin
      if(n_rst == 0)begin
	 d_edge <= 0;
	 previous_state <= 1;
      end
      else begin
	 d_edge <= nextState;
	 previous_state <= d_plus;
      end
   end

   always_comb begin
      nextState = (previous_state ^ d_plus);
   end
   
endmodule
