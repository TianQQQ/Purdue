// $Id: $
// File name:   adder_1bit.sv
// Created:     1/28/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: adder_1bit
`timescale 1ns / 100ps
module adder_1bit
(
 input wire  a,
 input wire  b,
 input wire  carry_in,
 output wire sum,
 output wire carry_out
 );

   always @ (a)
   begin
      assert((a == 1'b1) || (a == 1'b0))
	else $error("Input 'a' of component is not a digital lofic value");
   end

   assign sum = carry_in ^ (a ^ b);
   
   assign carry_out = ((~ carry_in) & b & a) | (carry_in & (b | a));



   always @ (a, b, carry_in)
   begin
      #(2) assert(((a + b +  carry_in) % 2) == sum)
	else $error("Output 's' of first 1 bit ader is not correct");
   end
   



   
   
endmodule
