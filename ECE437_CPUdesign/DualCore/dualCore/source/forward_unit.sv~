// CPU
`include "forward_unit_if.vh"
`include "cpu_types_pkg.vh"


module forward_unit(
  forward_unit_if fuif
);

   always_comb begin

      fuif.fwd_sel1 = 0;
      fuif.fwd_sel2 = 0;
      	

	// determine conflict between rs and rt
	// EX/MEM.registerRD == ID/EX.RegisterRS && EX/MEM.regusterRD != 0 && EX/MEM.REGWRITE

      if( fuif.exmem_regWEN & fuif.idex_rs == fuif.exmem_wsel & fuif.idex_rs != 0) begin
         fuif.fwd_sel1 = 2'b10;
      end
      else if(fuif.idex_rs != 0 & fuif.memwb_regWEN & fuif.idex_rs == fuif.memwb_wsel) begin
         fuif.fwd_sel1 = 2'b01;
      end

      if(fuif.idex_rt == fuif.memwb_wsel & fuif.idex_rt != 0 & fuif.memwb_regWEN) begin
         fuif.fwd_sel2 = 2'b01;
      end
      else if (fuif.idex_rt == fuif.exmem_wsel & fuif.idex_rt != 0 & fuif.exmem_regWEN)begin
         fuif.fwd_sel2 = 2'b10;
      end




      casez(fuif.exmem_data_sel)
        2'b00: fuif.exmem_wdat = fuif.exmem_immext;
        2'b11: fuif.exmem_wdat = fuif.exmem_pc_p4;


        default: fuif.exmem_wdat = fuif.exmem_aluout;
      endcase // casez (exmem_data_sel)
   end
   
     
endmodule
