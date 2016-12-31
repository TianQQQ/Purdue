//CPU

`ifndef FORWARD_UNIT_IF_VH
 `define FORWARD_UNIT_IF_VH
 `include "cpu_types_pkg.vh"
interface forward_unit_if;
   import cpu_types_pkg::*;


   modport fu(
              input  exmem_wsel, memwb_wsel, exmem_data_sel, memwb_wdat, exmem_aluout, exmem_immext, exmem_pc_p4, memwb_regWEN, exmem_regWEN,
              output fwd_sel1, fwd_sel2, exmem_wdat
              );
   regbits_t exmem_wsel;
   regbits_t memwb_wsel;
   regbits_t idex_rs;
   regbits_t idex_rt;

   word_t exmem_wdat;
   word_t memwb_wdat;
   word_t exmem_aluout;
   word_t exmem_immext;
   word_t  exmem_pc_p4;
   
   logic [1:0] fwd_sel1;
   logic [1:0] fwd_sel2;
   logic [1:0] exmem_data_sel;
   logic       memwb_regWEN;
   logic       exmem_regWEN;
   

endinterface

`endif
