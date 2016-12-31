/*
  Eric Villasenor
  evillase@gmail.com

*/
// interface
`include "pipeline_registers_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module pipeline_registers (
  input CLK,nRST,
  pipeline_registers_if plif
  );
  
  ///////////////////////////////////////////////////////////// instrcution fetch
  logic [31:0] Instr_IF;
  logic [31:0] nextPC_IF;

  ////////////////////////////////////////////////////////////  instruction decode
  logic [31:0] nextPC_ID;
  logic [31:0] Instr_ID;
  aluop_t     ALUOP_ID;
  logic       MemToReg_ID;
  logic       PcToReg_ID;
  logic       Memwrite_ID;
  logic       care_ID;
  logic       halt_ID;
  logic       hazard_Reg_ID;
  logic [2:0] jump_ID;
  logic [1:0] RegDst_ID;
  logic       RegWen_ID;
  logic [31:0] ALUSrc1_ID;
  logic [31:0] ALUSrc2_ID;
  logic [31:0] RegDat2_ID;


  //////////////////////////////////////////////////////////////  executaion

  logic [4:0]  RegDst_EX;
  logic        MemToReg_EX;
  logic        Memwrite_EX;
  logic        PcToReg_EX;
  logic [31:0] nextPC_EX;
  logic [2:0]  jump_EX;
  logic [31:0] Result_EX;
  logic [31:0] Wdata_EX;
  logic        RegWen_EX;
  logic        halt_EX;

  ///////////////////////////////////////////////////////////////// Memory
  logic [4:0]  RegDst_MEM;
  logic        RegWen_MEM;
  logic        MemToReg_MEM;
  logic        halt_MEM;
  logic        PcToReg_MEM;
  logic [31:0] nextPC_MEM;
  logic [31:0] ReadData_MEM;
  logic [31:0] CalcData_MEM;

   always_comb
   begin
	plif.output_Instr_IF = Instr_IF;

	plif.output_nextPC_ID = nextPC_ID;
	plif.output_Instr_ID = Instr_ID;
	plif.output_ALUSrc1_ID = ALUSrc1_ID;
	plif.output_ALUSrc2_ID = ALUSrc2_ID;
	plif.output_ALUOP_ID = ALUOP_ID;
	plif.output_jump_ID = jump_ID;
	plif.output_RegDst_ID = RegDst_ID;
	plif.output_care_ID = care_ID;
	plif.output_halt_ID = halt_ID;
	plif.output_hazard_Reg_ID = hazard_Reg_ID;
	plif.output_RegDat2_ID = RegDat2_ID;
	plif.output_MemToReg_ID = MemToReg_ID;
	plif.output_Memwrite_ID = Memwrite_ID;

	plif.output_Result_EX = Result_EX;
	plif.output_Wdata_EX =Wdata_EX;
	plif.output_RegDst_EX = RegDst_EX;
	plif.output_RegWen_EX = RegWen_EX;
	plif.output_MemToReg_EX = MemToReg_EX;
	plif.output_Memwrite_EX = Memwrite_EX;

	plif.output_PcToReg_MEM = PcToReg_MEM;
	plif.output_nextPC_MEM = nextPC_MEM;
	plif.output_MemToReg_MEM = MemToReg_MEM;
	plif.output_RegDst_MEM = RegDst_MEM;
	plif.output_RegWen_MEM = RegWen_MEM;
	plif.output_ReadData_MEM = ReadData_MEM;
	plif.output_CalcData_MEM = CalcData_MEM;
	plif.output_halt_MEM = halt_MEM;
   end
  
  always_ff @(posedge CLK or negedge nRST)
  begin

    if(!nRST)
    begin

	Instr_IF <= '0;
	nextPC_IF <= '0;
	nextPC_ID = '0;
	Instr_ID <= '0;
	jump_ID <= '0;
	RegDst_ID <= '0;
	RegWen_ID <= '0;
	ALUSrc1_ID <= '0;
	ALUSrc2_ID <= '0;
	RegDat2_ID <= '0;
	ALUOP_ID <= ALU_SLL;
	MemToReg_ID <= '0;
	PcToReg_ID <= '0;
	Memwrite_ID <= '0;
	care_ID <= '0;
	halt_ID <= '0;
	hazard_Reg_ID <= 0;
	PcToReg_EX <= '0;
	nextPC_EX <= '0;
	jump_EX <= '0;
	Result_EX <= '0;
	Wdata_EX <= '0;
	RegDst_EX <= '0;
	RegWen_EX <= '0;
	MemToReg_EX <= '0;
	Memwrite_EX <= '0;
	halt_EX <= 0;
	PcToReg_MEM <= '0;
	nextPC_MEM <= '0;
	ReadData_MEM <= '0;
	CalcData_MEM <= '0;
	RegDst_MEM <= '0;
	MemToReg_MEM <= '0;
	RegWen_MEM<= '0;
	halt_MEM <= 0;

    end else begin
      
    if (plif.data_or_instruction_next == 1) 
    begin

	if (plif.lw_hazard == 0 && plif.lw_hazard_next == 0) begin

		if (plif.branch == 1) begin 
			// if instruction is beq, add NOP to skip the next instruction; no hazard, but has beq
			//IF and ID signals set to zero
			//////////////////////////////////////////////////////////////////////////////// IF
			Instr_IF <= '0;
			nextPC_IF <= '0;

			//////////////////////////////////////////////////////////////////////////////// ID
			nextPC_ID <= '0;
			Instr_ID <= '0;
			jump_ID <= '0;
			RegDst_ID <= '0;
			RegWen_ID <= '0;
			ALUSrc1_ID <= '0;
			ALUSrc2_ID <= '0;
			RegDat2_ID <= '0;
			ALUOP_ID <= ALU_SLL;
			MemToReg_ID <= '0;
			PcToReg_ID <= '0;
			Memwrite_ID <= '0;
			care_ID <= '0;
			halt_ID <= '0;
			hazard_Reg_ID <= 0;
		end else begin
	
			Instr_IF <= plif.input_Instr_IF;
			nextPC_IF <= plif.input_nextPC_IF;

			nextPC_ID <= nextPC_IF;
			Instr_ID <= Instr_IF;

			jump_ID <= plif.input_jump_ID;
			RegDst_ID <= plif.input_RegDst_ID;
			RegWen_ID <= plif.input_RegWen_ID;
			ALUSrc1_ID <= plif.input_ALUSrc1_ID;
			ALUSrc2_ID <= plif.input_ALUSrc2_ID;
			RegDat2_ID <= plif.input_RegDat2_ID;
			ALUOP_ID <= plif.input_ALUOP_ID;
			MemToReg_ID <= plif.input_MemToReg_ID;
			PcToReg_ID <= plif.input_PcToReg_ID;
			Memwrite_ID <= plif.input_Memwrite_ID;
			care_ID <= plif.input_care_ID;
			halt_ID <= plif.input_halt_ID;
			hazard_Reg_ID <= plif.input_hazard_Reg_ID;
		end
	end 

        if (plif.lw_hazard == 1 || plif.lw_hazard_next == 1)
        begin
		//////////////////////////////////////////////////////////////////////////////// execuation
		RegWen_EX <= '0;
		MemToReg_EX <= '0;
		Memwrite_EX <= '0;
		halt_EX <= 0;
		PcToReg_EX <= '0;
		nextPC_EX <= '0;
		jump_EX <= '0;
		Result_EX <= '0;
		Wdata_EX <= '0;
		RegDst_EX <= '0;
        end else 
        begin
		PcToReg_EX <= PcToReg_ID;
		nextPC_EX <= nextPC_ID;
		Result_EX <= plif.input_Result_EX;
		Wdata_EX <= plif.input_Wdata_EX;
		RegWen_EX <= RegWen_ID;
		RegDst_EX <= plif.input_RegDst_EX;
		MemToReg_EX <= MemToReg_ID;
		Memwrite_EX <= Memwrite_ID;
		halt_EX <= halt_ID;          
        end

        if(plif.lw_hazard_next == 2'b01) // forwarding unit, ForwardA/ForwardB: 01->Mem, 10->EX
        begin
		ALUSrc1_ID <= ReadData_MEM;  // Memory mux
        end else if (plif.lw_hazard_next == 2'b10) begin
		ALUSrc2_ID <= ReadData_MEM;  // Execuation mux
        end

        ///////////////////////////////////////////////////////////////////////////////////////// Memory
        nextPC_MEM <= nextPC_EX;
        ReadData_MEM <= plif.input_ReadData_MEM;
        PcToReg_MEM <= PcToReg_EX;
        CalcData_MEM <= Result_EX;
        RegDst_MEM <= RegDst_EX;
        RegWen_MEM <= RegWen_EX;
        MemToReg_MEM <= MemToReg_EX;
        halt_MEM <= halt_EX;

      end 
    end
  end
endmodule
