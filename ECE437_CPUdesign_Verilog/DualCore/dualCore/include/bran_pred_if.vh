// CPU

`ifndef BRAN_PRED_IF_VH
 `define BRAN_PRED_IF_VH
 `include "cpu_types_pkg.vh"



interface bran_pred_if;
   import cpu_types_pkg::*;

   logic take;
   logic branEN;
   logic  hit;
   logic  pc_bran_pred;

   logic [29:0] branaddr_in, branaddr_out, addr2;

   modport bp(input take, 
	      input branaddr_in, 
	      input addr1, 
	      input branEN, 

	      input addr2,
              output branaddr_out, 
              output hit, 
              output pc_bran_pred);

   word_t addr1;
endinterface // bran_pred_if
`endif
