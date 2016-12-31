/*
  Yiyi Chen
  chen1234@purdue.edu

  hazard_unit file 
*/
`include "hazard_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"
 import cpu_types_pkg::*;

module hazard_unit (
  //	input logic CLK, nRST,
  	hazard_unit_if hzif
);

//////////////////////////////////////////////////////////////////////////////////source 1
   always_comb
     begin
	
	// determine conflict between rs and rt
	// EX/MEM.registerRD == ID/EX.RegisterRS && EX/MEM.regusterRD != 0 && EX/MEM.REGWRITE
	if(hzif.output_Instr_ID_RS == hzif.output_RegDst_MEM && hzif.output_RegDst_MEM != 5'b00000) begin  
	   if(hzif.lw_instr) begin
	      hzif.src1_hazard_t = 2'b11;    //0:no hazard 01:fowardA 10:forwardB 100:
	   end
	   else begin
	      hzif.src1_hazard_t = 2'b01;
	   end
	end
	else if(hzif.output_Instr_ID_RS == hzif.output_RegWen_MEM && hzif.output_RegWen_MEM!=5'b00000) begin
	   if(hzif.lw_instr_next) begin
	      hzif.src1_hazard_t = 3'b100;
	   end
	   else begin
	      hzif.src1_hazard_t = 2'b10;
	   end
	end
	else begin
	   hzif.src1_hazard_t = 2'b00;
	end // else: !if(hzif.output_Instr_ID_RS == hzif.output_RegWen_MEM && hzif.output_RegWen_MEM!=5'b00000)

/////////////////////////////////////////////////////////////////////////////////// source2

	if(hzif.output_Instr_ID_RD == hzif.output_RegDst_MEM && hzif.output_RegDst_MEM != 5'b00000) begin
	   if(hzif.lw_instr) begin
	      hzif.src2_hazard_t = 2'b11;
	   end
	   else begin
	      hzif.src2_hazard_t = 2'b01;
	   end
	end
	else if(hzif.output_Instr_ID_RD == hzif.output_RegWen_MEM && hzif.output_RegWen_MEM!=5'b00000) begin
	   if(hzif.lw_instr_next) begin
	      hzif.src2_hazard_t = 3'b100;
	   end
	   else begin
	      hzif.src2_hazard_t = 2'b10;
	   end
	end
	else begin
	   hzif.src2_hazard_t = 2'b00;
	end // else: !if(hzif.output_Instr_ID_RS == hzif.output_RegWen_MEM && hzif.output_RegWen_MEM!=5'b00000)

	hzif.data_or_instruction_next = hzif.ihit | hzif.dhit;
     end // always_comb
   
  


endmodule
