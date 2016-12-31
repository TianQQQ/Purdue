// CPU

`include "cpu_types_pkg.vh"
`include "hazard_if.vh"
module hazard (
   hazard_if huif
);


   always_comb begin
      huif.ifid_EN = 1;
      huif.pc_EN = 1;
      huif.idex_flush = 0;


	if((huif.dmemREN) && (huif.ifid_rt == huif.idex_rt | huif.ifid_rs == huif.idex_rt))
	   begin
		huif.pc_EN = 0;     // program count is 0
		huif.ifid_EN = 0;
		huif.idex_flush = 1; //  flush instruction decode to execuation
	   end
   end


endmodule // hazard
