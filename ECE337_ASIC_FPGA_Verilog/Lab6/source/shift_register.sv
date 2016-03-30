// $Id: $
// File name:   shift_register.sv
// Created:     3/1/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: shift register

module shift_register
  (
   input wire clk,
   input wire n_rst,
   input wire shift_enable,
   input wire d_orig,             // decoded input data
   output wire [7:0] rcv_data
   );
   reg [7:0] tmp;                 // temporery data to be received
   flex_stp_sr #(8,0) sr (        // most significant on the left, least on the right
      .clk(clk),
      .n_rst(n_rst),
      .shift_enable(shift_enable),
      .serial_in(d_orig),
      .parallel_out(tmp)
      );
   assign rcv_data = tmp;
endmodule
