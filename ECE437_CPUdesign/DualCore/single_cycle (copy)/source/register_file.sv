/*
  Yiyi Chen
  chen1234@purdue.edu

  register sv file 
*/

// interface
`include "register_file_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module register_file(
  input logic CLK, 
  input logic nRST,
  register_file_if.rf rfif
);

word_t [31:0] register_arr;

always_ff @ (posedge CLK, negedge nRST) begin
   if (!nRST) begin
      register_arr <= '{default:0};
   end
   
   else begin
      if(rfif.WEN)
	register_arr[rfif.wsel] <= rfif.wdat;
   end
end
       
   assign rfif.rdat1 = register_arr[rfif.rsel1];
   assign rfif.rdat2 = register_arr[rfif.rsel2];
       
       
endmodule   
