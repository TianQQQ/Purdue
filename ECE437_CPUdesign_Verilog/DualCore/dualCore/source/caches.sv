/*
  Eric Villasenor
  evillase@gmail.com

  this block holds the i and d cache
*/


module caches (
  input logic CLK, nRST,
  datapath_cache_if dcif,
  caches_if ccif
);
   
  icaches ICACHES(CLK, nRST, dcif, ccif);
  dcaches DCACHES(CLK, nRST, dcif, ccif);

endmodule
