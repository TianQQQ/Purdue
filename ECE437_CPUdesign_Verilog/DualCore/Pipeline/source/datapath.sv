/*
 Eric Villasenor
 evillase@gmail.com

 datapath contains register file, control, hazard,
 muxes, and glue logic for processor
 */

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "pipeline_registers_if.vh"
`include "alu_file_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
		 input logic CLK, nRST,
		 datapath_cache_if.dp dpif
		 );
   // import types
   import cpu_types_pkg::*;

   // pc init
   parameter PC_INIT = 0;

   word_t signedExtImm;
   word_t zeroExtImm;
   word_t luiImm;
   word_t shamt;

   //interfaces
   alu_file_if alif();
   pipeline_registers_if plif();
   control_unit_if cuif();
   hazard_unit_if hzif();
   register_file_if rfif();

   //DUT
   alu_file ALU (alif);
   pipeline_registers PR (CLK, nRST, plif);
   control_unit CU (cuif);
   hazard_unit HZ (hzif);
   register_file RF (CLK, nRST, rfif);


   //******************************  Instruction Fetch ****************************//
   //jump options
   word_t pc; //program counter
   word_t pc_next;
   word_t pc_next_plus4;
   word_t pc_next_jump;
   word_t pc_next_reg;
   word_t pc_next_branch;
   logic [31:0] branch_offset;


   // ihit is time to load instruction and input next pc always
   assign plif.input_Instr_IF =(dpif.ihit) ? dpif.imemload : '0;
   assign plif.input_nextPC_IF = pc_next_plus4; 

   //****************************** Instruction Decode *****************************//
   
   logic real_data2; //real rdat2 from register file

   assign plif.input_ALUOP_ID = cuif.ALUOP;
	//00: not from mem, 01: from full word, 10: from half word, 11: from byte
	//choose between a result from memory and alu result
   assign plif.input_MemToReg_ID = cuif.MemToReg;
   assign plif.input_PcToReg_ID = cuif.PcToReg;
 	//data write enable
	//00: not write to mem, 01: write full word, 10: write half word, 11: write byte
   assign plif.input_Memwrite_ID = cuif.MemWrite;
   assign plif.input_care_ID = cuif.careOF;
   assign plif.input_jump_ID = cuif.jump;
	//choose dst srouce between Rd and Rt and 31
   assign plif.input_RegDst_ID = cuif.RegDst;
	//Enanle when need to write to register
	//Enanle when need to write to register
   assign plif.input_RegWen_ID = cuif.RegWen;
   assign plif.input_ALUSrc1_ID = rfif.rdat1;
   assign plif.input_RegDat2_ID = rfif.rdat2;
   assign plif.input_halt_ID = cuif.halt;
   assign plif.input_hazard_Reg_ID = cuif.input_hazard_Reg_ID;


      assign	shamt = {24'h000000, 3'b000, plif.output_Instr_IF[10:6]};
   assign	zeroExtImm = {16'h0000, plif.output_Instr_IF[15:0]};
   assign	luiImm = {plif.output_Instr_IF[15:0], 16'h0000};

   assign signedExtImm  = (plif.output_Instr_IF[15] == 0) ?  {16'h0000, plif.output_Instr_IF[15:0]}: {16'hffff, plif.output_Instr_IF[15:0]};
   always_comb
   begin
	// extension /*
/********************************************	
	not combination logic synchronize error

	if(plif.output_Instr_IF[15] == 0) 
		signedExtImm  = {16'h0000, plif.output_Instr_IF[15:0]};
	else if(cuif.ALUSrc == 3'b001)
		signedExtImm  = {16'hffff, plif.output_Instr_IF[15:0]};

*********************************************/

	//choose between a register source and an Imediation source and shamt
	//0:reg, 001: singed im 010: zero im 011:lui 100: shamt   
	if(cuif.ALUSrc == 3'b000)
		plif.input_ALUSrc2_ID = rfif.rdat2;
	else if(cuif.ALUSrc == 3'b001)
		plif.input_ALUSrc2_ID = signedExtImm;
	else if (cuif.ALUSrc == 3'b010)
	     	plif.input_ALUSrc2_ID = zeroExtImm ;
	else if (cuif.ALUSrc == 3'b011)
		plif.input_ALUSrc2_ID = luiImm;
	else
		plif.input_ALUSrc2_ID =shamt;
   end




   //******************************* Execuation ***********************************//
   // forwarding is to address RAW hazards (data hazards)
   // RAW hazard may exist on register when i in EX and j in later stage.
   // compare pending writes ( in later stage) with operand regs of current instruction
   assign pc_next_plus4 = pc + 4;
   assign pc_next_jump = {pc[31:28], plif.output_Instr_ID[25:0], 2'b00};  // jump instruction
   assign branch_offset = (plif.output_Instr_ID[15] == 0) ? {16'h0000, plif.output_Instr_ID[15:0]} : {16'hffff, plif.output_Instr_ID[15:0]};
   assign pc_next_branch = (branch_offset<<2) + plif.output_nextPC_ID;    
   assign pc_next_reg = (hzif.src1_hazard_t == 2'b00)? plif.output_ALUSrc1_ID :  (hzif.src1_hazard_t == 2'b01) ? plif.output_Result_EX : (hzif.src1_hazard_t != 2'b10)? 0 :  (plif.output_MemToReg_MEM == 1) ? plif.output_ReadData_MEM : plif.output_CalcData_MEM;
   //pc_next_reg selection  no hazard                                     // forwardA                                          //  forward B
  
   //next pc logic calculation
   // assign

   //000 for not jump, 001 for jump to addr, 010 for jump to reg, 011 for beq,  100 for bne
   always_comb
     begin

	if(plif.output_jump_ID == 3'b001)
	  	plif.input_Result_EX = plif.output_nextPC_ID;
	else
	        plif.input_Result_EX = alif.out;

	pc_next = 0;
	plif.branch = 0;
	if(plif.output_jump_ID == 3'b000)
	     pc_next = pc_next_plus4;
	else if(plif.output_jump_ID == 3'b001)begin
	     pc_next = pc_next_jump;
	     plif.branch = 1;
	end
	else if(plif.output_jump_ID == 3'b010)begin
	     pc_next = pc_next_reg;
	     plif.branch = 1;
	end
	else if (plif.output_jump_ID == 3'b011) begin
		if(alif.zero == 1)begin
			pc_next = pc_next_branch;
			plif.branch = 1;
		end else 
			pc_next = pc_next_plus4; 
	end
	else if (plif.output_jump_ID== 3'b100) begin
		if(alif.zero != 1) begin
			pc_next = pc_next_branch;
			plif.branch = 1;
		end else 
			pc_next = pc_next_plus4;
	end


	//choose the register for exectution pipeline
  	//choose dst source between Rd(0) and Rt(1) and 31[10]
	if(plif.output_RegDst_ID== 2'b00)
	     plif.input_RegDst_EX = plif.output_Instr_ID[15:11];
	else begin
		if(plif.output_RegDst_ID== 2'b01)
			plif.input_RegDst_EX = plif.output_Instr_ID[20:16];
		else
	     		plif.input_RegDst_EX = 5'b11111;
	end

	plif.input_Wdata_EX = '0;

	if (hzif.src2_hazard_t == 2'b00) 
        	plif.input_Wdata_EX = plif.output_RegDat2_ID;
	else if (hzif.src2_hazard_t == 2'b01)
        	plif.input_Wdata_EX = plif.output_Result_EX;
	else if (hzif.src2_hazard_t == 2'b10) 
		plif.input_Wdata_EX = (plif.output_MemToReg_MEM == 1) ? plif.output_ReadData_MEM : plif.output_CalcData_MEM;
     end
  //***********************  halt logic  *********************//
   logic halt_reg;
   logic halt_next;
   always_ff @(negedge CLK, negedge nRST)
     begin
	if (!nRST)
		halt_reg <= 0;
	else begin
	   if(halt_next)
		halt_reg <= 1;
	end
     end
   
   always_comb
   begin
	if (plif.output_care_ID == 1) 
        	if (alif.overflow == 1)
			halt_next = 1;
		else
			halt_next = 0;
	else
		halt_next = plif.output_halt_MEM;
   end



   always_comb
   begin
   //************************************  hazard *************************************//	
	plif.data_or_instruction_next = hzif.data_or_instruction_next;
	hzif.ihit = dpif.ihit;
	hzif.dhit = dpif.dhit;
	hzif.output_Instr_ID_RS = plif.output_Instr_ID[25:21];  //get the rs in the ID stage
	hzif.output_Instr_ID_RD = (plif.output_hazard_Reg_ID) ? plif.output_Instr_ID[20:16] : '0; //get the rd in the ID stage
	hzif.output_RegDst_MEM = (plif.output_RegWen_EX) ? plif.output_RegDst_EX: '0;  //get the output register out of EX stage
	hzif.output_RegWen_MEM = (plif.output_RegWen_MEM) ? plif.output_RegDst_MEM : '0; //get the output register out of MEM sta
	hzif.lw_instr = plif.output_MemToReg_EX;
	hzif.lw_instr_next = plif.output_MemToReg_MEM & plif.output_MemToReg_EX;

	if  (hzif.src1_hazard_t == 2'b11 || hzif.src2_hazard_t == 2'b11)
		plif.lw_hazard = 1;
	else
		plif.lw_hazard = 0;


	if  (hzif.src1_hazard_t == 3'b100)
		plif.lw_hazard_next  = 2'b01;
	else if (hzif.src2_hazard_t == 3'b100)
		plif.lw_hazard_next =  2'b10;
	else
		plif.lw_hazard_next =  2'b00;

   //************************************  Memory *************************************//
	plif.input_ReadData_MEM = dpif.dmemload;
	dpif.halt = halt_reg;
	dpif.imemREN = 1;
	dpif.imemaddr = pc;
	dpif.dmemREN = plif.output_MemToReg_EX;
	dpif.dmemWEN = plif.output_Memwrite_EX;
	dpif.dmemstore = plif.output_Wdata_EX;
	dpif.dmemaddr = plif.output_Result_EX;

  //************************************* control unit ***************************************//
      cuif.Instr = plif.output_Instr_IF;


  //************************************ register file  *************************************//  
	if  (plif.output_MemToReg_MEM)begin
		rfif.wdat = plif.output_ReadData_MEM;
		rfif.WEN = plif.output_RegWen_MEM;
	end else begin
		rfif.wdat = plif.output_CalcData_MEM;
		rfif.WEN = plif.output_RegWen_MEM;
	end

	rfif.wsel = plif.output_RegDst_MEM;
	rfif.rsel1 = plif.output_Instr_IF[25:21];
	rfif.rsel2 = plif.output_Instr_IF[20:16];
   end


   //************************************ alu *************************************//
   always_comb
     begin

        alif.aluop = plif.output_ALUOP_ID;
	alif.input_a = '0;
	alif.input_b = '0;

	if (hzif.src1_hazard_t == 2'b00) 
        	alif.input_a = plif.output_ALUSrc1_ID;
	else if (hzif.src1_hazard_t == 2'b01) 
                alif.input_a = plif.output_Result_EX;
	else if (hzif.src1_hazard_t == 2'b10) 
		alif.input_a = (plif.output_MemToReg_MEM == 1) ? plif.output_ReadData_MEM : plif.output_CalcData_MEM;

	if(plif.output_Memwrite_ID)
                alif.input_b = plif.output_ALUSrc2_ID;
	else if (hzif.src2_hazard_t == 2'b00) 
                alif.input_b = plif.output_ALUSrc2_ID;
	else if (hzif.src2_hazard_t == 2'b01) 
		alif.input_b = plif.output_Result_EX;
	else if (hzif.src2_hazard_t == 2'b10) 
		alif.input_b = (plif.output_MemToReg_MEM == 1) ? plif.output_ReadData_MEM : plif.output_CalcData_MEM;
     end
  
   
   //******************************* program counter ***************************//
   logic PC_enable;
   always_ff @(posedge CLK, negedge nRST) begin
      if (!nRST) begin
	 pc <= 32'h00000000;
      end
      else begin
	 if (PC_enable) begin
            pc <= pc_next;
	 end
      end
   end  
   assign PC_enable = (~plif.branch)? dpif.ihit & (~dpif.dhit): (dpif.ihit | dpif.dhit)? 1 : 0;



endmodule
