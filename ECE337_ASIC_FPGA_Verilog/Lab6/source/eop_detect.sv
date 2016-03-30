// $Id: $
// File name:   eop_detect.sv
// Created:     2/25/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: eod_detect

module eop_detect
  (
   input wire  d_plus,
   input wire  d_minus,
   output wire eop
   );
   assign eop = ~(d_plus | d_minus);  // when both d_plus and d_muinus are low
endmodule
