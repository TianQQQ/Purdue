// $Id: $
// File name:   decode.sv
// Created:     2/25/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: decode.sv
module decode(input wire clk,
	      input wire  n_rst,
	      input wire  d_plus,
	      input wire  shift_enable,
	      input wire  eop,
	      output wire d_orig);
   reg 			  dorig;
   reg 			  stored;
   reg 			  STORED;
   reg 			  DORIG;
   always_ff @(posedge clk, negedge n_rst)
     begin
	if (n_rst == 1'b0)
	  begin
	     stored<=1'b1;
	     dorig<=1'b1;
	  end
	else
	  begin
	     dorig<=DORIG;
	     stored<=STORED;
	  end
     end // always_ff @
   assign d_orig=(stored==dorig);
   assign DORIG=(shift_enable  == 1 && eop == 1)?1'b1:d_plus;
   assign STORED= (shift_enable  == 1 && eop == 1) ? 1: ((shift_enable == 1) ? d_plus : stored);
endmodule
