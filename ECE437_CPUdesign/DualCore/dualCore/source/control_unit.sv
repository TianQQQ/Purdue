// CPU

`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"
//Note iren = 1 when halt?
module control_unit(
  control_unit_if cuif
);



	/***************************************************************
	---------------------<Pseudo Instructions>-----------------------
	PUSH   $rs           $29 <= $29 - 4; Mem[$29+0] <= R[rs] (sub+sw)
	POP    $rt           R[rt] <= Mem[$29+0]; $29 <= $29 + 4 (add+lw)
	NOP                  Nop
	-----------------------------------------------------------------
	-----------------------------------------------------------------
	org  Addr         Set the base address for the code to follow 
	chw  #            Assign value to half word memory
	cfw  #            Assign value to word of memory
	**************************************************************/



   import cpu_types_pkg::*;
   j_t instrj;
   assign instrj = cuif.instr;
   i_t instri;
   assign instri = cuif.instr;
   r_t instrr;
   assign instrr = cuif.instr;
   
   always_comb begin:DECODE

      cuif.pcsrc = 2'd0;cuif.extop = 1'b0;cuif.aluin_sel = 1'b0;cuif.aluop = 6'b000000;cuif.wdat_sel = 2'd0;cuif.jal = 0;cuif.shamt_sel = 1'b0; cuif.wsel_sel = instri.rt;  cuif.bran = 1'b0;  cuif.datomic=0;
      cuif.rWEN = 1'b0;cuif.dREN = 1'b0;cuif.dWEN = 1'b0;
      casez(instri.opcode)

		/****************************************************************
		---------------------<R-type Instructions>-----------------------
		ADDU   $rd,$rs,$rt   R[rd] <= R[rs] + R[rt] (unchecked overflow)
		ADD    $rd,$rs,$rt   R[rd] <= R[rs] + R[rt]
		AND    $rd,$rs,$rt   R[rd] <= R[rs] AND R[rt]
		JR     $rs           PC <= R[rs]
		NOR    $rd,$rs,$rt   R[rd] <= ~(R[rs] OR R[rt])
		OR     $rd,$rs,$rt   R[rd] <= R[rs] OR R[rt]
		SLT    $rd,$rs,$rt   R[rd] <= (R[rs] < R[rt]) ? 1 : 0
		SLTU   $rd,$rs,$rt   R[rd] <= (R[rs] < R[rt]) ? 1 : 0
		SLL    $rd,$rs,shamt R[rd] <= R[rs] << shamt
		SRL    $rd,$rs,shamt R[rd] <= R[rs] >> shamt
		SUBU   $rd,$rs,$rt   R[rd] <= R[rs] - R[rt] (unchecked overflow)
		SUB    $rd,$rs,$rt   R[rd] <= R[rs] - R[rt]
		XOR    $rd,$rs,$rt   R[rd] <= R[rs] XOR R[rt]
		*****************************************************************/

        RTYPE:begin
           cuif.wdat_sel = 2;
           cuif.rWEN = 1'b1;
           cuif.wsel_sel = instrr.rd;
           cuif.aluin_sel = 1'b0;
           casez(instrr.funct)
             SLL:begin
                cuif.aluin_sel = 1'b1;
                cuif.shamt_sel = 1'b1;
                cuif.extop = 1'b0;
                cuif.aluop = ALU_SLL;
                
             end
             SRL:begin
                cuif.aluin_sel = 1'b1;
                cuif.shamt_sel = 1'b1;
                cuif.extop = 1'b0;
                cuif.aluop = ALU_SRL;
                
             end
             JR:begin//rsel2 don't care?
                cuif.pcsrc = 2;
                cuif.rWEN = 1'b0;
             end
             ADDU:begin
                cuif.aluop = ALU_ADD;
             end
             SUBU:begin
                cuif.aluop = ALU_SUB;
             end
             NOR:begin
                cuif.aluop = ALU_NOR;
             end
             SLT:begin
                cuif.aluop = ALU_SLT;
             end
             SLTU:begin
                cuif.aluop = ALU_SLTU;
             end
             AND:begin
                cuif.aluop = ALU_AND;
             end
             OR:begin
                cuif.aluop = ALU_OR;
             end
             ADD:begin
                cuif.aluop = ALU_ADD;
             end
             SUB:begin
                cuif.aluop = ALU_SUB;
             end
             XOR:begin
                cuif.aluop = ALU_XOR;
             end

           endcase // casez (instrr.funct)
        end



	/*******************************************************************
	---------------------<J-type Instructions>-----------------------
	J      label         PC <= JumpAddr
	JAL    label         R[31] <= npc; PC <= JumpAddr
	********************************************************************/
 
        J:begin
           cuif.pcsrc = 1;
        end
        JAL:begin
           cuif.pcsrc = 1;
           cuif.wdat_sel = 3;
           cuif.rWEN = 1;
           cuif.wsel_sel = 31;
           cuif.jal = 1;
        end



	/****************************************************************************************
	---------------------<I-type Instructions>-----------------------
	ADDIU  $rt,$rs,imm   R[rt] <= R[rs] + SignExtImm (unchecked overflow)
	ADDI   $rt,$rs,imm   R[rt] <= R[rs] + SignExtImm
	ANDI   $rt,$rs,imm   R[rt] <= R[rs] & ZeroExtImm
	BEQ    $rs,$rt,label PC <= (R[rs] == R[rt]) ? npc+BranchAddr : npc
	BNE    $rs,$rt,label PC <= (R[rs] != R[rt]) ? npc+BranchAddr : npc
	LUI    $rt,imm       R[rt] <= {imm,16b'0}
	LW     $rt,imm($rs)  R[rt] <= M[R[rs] + SignExtImm]
	ORI    $rt,$rs,imm   R[rt] <= R[rs] OR ZeroExtImm
	SLTI   $rt,$rs,imm   R[rt] <= (R[rs] < SignExtImm) ? 1 : 0
	SLTIU  $rt,$rs,imm   R[rt] <= (R[rs] < SignExtImm) ? 1 : 0
	SW     $rt,imm($rs)  M[R[rs] + SignExtImm] <= R[rt]
	LL     $rt,imm($rs)  R[rt] <= M[R[rs] + SignExtImm]; rmwstate <= addr
	SC     $rt,imm($rs)  if (rmw) M[R[rs] + SignExtImm] <= R[rt], R[rt] <= 1 else R[rt] <= 0
	XORI   $rt,$rs,imm   R[rt] <= R[rs] XOR ZeroExtImm
	****************************************************************************************/
        ADDI, ADDIU:begin
           cuif.aluop = ALU_ADD;
           cuif.shamt_sel = 1'b0;
           cuif.extop = 1'b1;
           cuif.aluin_sel = 1'b1;
           cuif.rWEN = 1'b1;
           cuif.wdat_sel = 2'd2;
        end
        ANDI:begin

           cuif.extop = 1'b0;
           cuif.wdat_sel = 2'd2;
           cuif.rWEN = 1'b1;
           cuif.aluin_sel = 1'b1;
           cuif.aluop = ALU_AND;
           cuif.shamt_sel = 1'b0;
        end
        BEQ:begin
           cuif.aluop = ALU_SUB;
           cuif.aluin_sel = 1'b0;
           cuif.shamt_sel = 1'b0;
           cuif.extop = 1;
           cuif.pcsrc = 3;
           cuif.bran = 1'b0;
           
        end

        XORI:begin
           cuif.aluop = ALU_XOR;
           cuif.shamt_sel = 1'b0;
           cuif.extop = 1'b0;
           cuif.aluin_sel = 1'b1;
           cuif.wdat_sel = 2'd2;
           cuif.rWEN = 1'b1;
        end

        BNE:begin
           cuif.aluop = ALU_SUB;
           cuif.aluin_sel = 1'b0;
           cuif.shamt_sel = 1'b0;
           cuif.extop = 1;
           cuif.pcsrc = 3;
           cuif.bran = 1'b1;
        end

        LL:begin
           cuif.dREN = 1;
           cuif.datomic = 1;
           cuif.rWEN = 1;
           cuif.shamt_sel = 0;
           cuif.extop = 1;
           cuif.aluin_sel = 1;
           cuif.aluop = ALU_ADD;
           cuif.wdat_sel = 1;

        end
        SC:begin
           cuif.rWEN = 1'b1;
           cuif.wdat_sel = 2'b01;
           cuif.datomic = 1;
           cuif.shamt_sel = 0;
           cuif.extop = 1;
           cuif.aluin_sel = 1;
           cuif.aluop = ALU_ADD;
           cuif.dWEN = 1'b1;
           
        end
        LUI:begin
           cuif.wdat_sel = 2'd0;
           cuif.rWEN = 1'b1;
           cuif.extop = 2;
        end
        ORI:begin
           cuif.rWEN = 1'b1;
           cuif.shamt_sel = 1'b0;
           cuif.extop = 1'b0;
           cuif.aluin_sel = 1'b1;
           cuif.aluop = ALU_OR;
           cuif.wdat_sel = 2'd2;
        end
        SLTI:begin
           cuif.aluop = ALU_SLT;
           cuif.shamt_sel = 1'b0;
           cuif.extop = 1'b1;
           cuif.aluin_sel = 1'b1;
           cuif.wdat_sel = 2'd2;
           cuif.rWEN = 1'b1;
        end
        SLTIU:begin
           cuif.wdat_sel = 2'd2;
           cuif.rWEN = 1'b1;
           cuif.aluop = ALU_SLTU;
           cuif.shamt_sel = 1'b0;
           cuif.extop = 1'b1;
           cuif.aluin_sel = 1'b1;
        end
        SW:begin
           cuif.shamt_sel = 0;
           cuif.extop = 1;
           cuif.aluin_sel = 1;
           cuif.aluop = ALU_ADD;
           cuif.dWEN = 1'b1;           
        end
        LW:begin
           cuif.shamt_sel = 0;
           cuif.extop = 1;
           cuif.aluin_sel = 1;
           cuif.aluop = ALU_ADD;
           cuif.dREN = 1'b1;
           cuif.rWEN = 1'b1;
           cuif.wdat_sel = 1;
        end

      endcase
      
   end 





   assign cuif.halt = instri.opcode == HALT;




endmodule 
