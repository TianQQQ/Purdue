/*
  Yiyi Chen
  chen1234@purdue.edu

  alu sv file 
*/

// interface
`include "alu_file_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module alu_file(
  alu_file_if.alu aluf
);

   always_comb begin
      casez(aluf.aluop)
	ALU_SLL: begin
	   aluf.out = aluf.input_a<<aluf.input_b;
	   aluf.overflow = 0;
	end
	ALU_SRL: begin
	   aluf.out = aluf.input_a>>aluf.input_b;
	   aluf.overflow = 0;
	end
	ALU_ADD: begin
	   aluf.out = $signed(aluf.input_a) + $signed(aluf.input_b);
	   if(aluf.input_a[31] == aluf.input_b[31])begin
	      if(aluf.input_a[31] != aluf.out)begin
		 aluf.overflow = 1;
	      end
	      else begin
		 aluf.overflow = 0;
	      end
	   end
	   else begin
	      aluf.overflow = 0;
	   end // else: !if(aluf.input_a[31] == aluf_input_b[31])
	end // case: ALU_ADD
	ALU_SUB: begin
	   aluf.out = $signed(aluf.input_a) - $signed(aluf.input_b);
	   if (aluf.input_a[31] ^ aluf.input_b[31])begin
	      if(aluf.input_a[31] != aluf.out[31])begin
		 aluf.overflow = 1;
	      end
	      else begin
		 aluf.overflow = 0;
	      end
	   end
	   else begin
	      aluf.overflow = 0;
	   end // else: !if(aluf.input_a[31] ^ aluf.input_b[31])
	end // case: ALU_SUB
	ALU_AND: begin
	   aluf.out = aluf.input_a&aluf.input_b;
	   aluf.overflow = 0;
	end
	ALU_OR: begin
	   aluf.out = aluf.input_a|aluf.input_b;
	   aluf.overflow = 0;
	end
	ALU_XOR: begin
	   aluf.out = aluf.input_a^aluf.input_b;
	   aluf.overflow = 0;
	end
	ALU_NOR: begin
	   aluf.out = ~(aluf.input_a|aluf.input_b);
	   aluf.overflow = 0;
	end
	ALU_SLT: begin
	   aluf.out = $signed(aluf.input_a) < $signed(aluf.input_b);
	   aluf.overflow = 0;
	end
	ALU_SLTU: begin
	   aluf.out = aluf.input_a < aluf.input_b;
	   aluf.overflow = 0;
	end
	default: begin
	   aluf.out = '0;
	   aluf.overflow = 0;
	end
      endcase // casez (aluf.aluop)
   end // always_comb

   assign aluf.zero = aluf.out==0? 1:0;
   assign aluf.neg = aluf.out[31];

endmodule // alu_file

	  
	  
	   
	  
		     
	   
	   

		 
		
