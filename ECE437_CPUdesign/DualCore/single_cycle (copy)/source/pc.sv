/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
 */

// interface include
`include "pc_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module pc(
	  input logic CLK, nRST,
	  pc_if.pc pcif
	  );

   import cpu_types_pkg::*;
   word_t PCreg, PCregN, PCadd4;

   always_ff @ (posedge CLK, negedge nRST) begin
      if(!nRST)
	PCreg <= '0;
      else 
	PCreg <= PCregN;
   end

   assign PCadd4 = PCreg + 4;
   assign pcif.imemaddr = PCreg;
   assign pcif.returnaddr = PCadd4;

   assign PCregN = pcif.ramfull ? PCreg : pcif.source1 ? pcif.immediate[15] ? PCadd4 + {14'b11111111111111, pcif.immediate, 2'b00} : PCadd4 + {14'b00000000000000, pcif.immediate, 2'b00} : pcif.source2 ? {PCadd4[31:28], pcif.j_addr, 2'b00} : pcif.source3 ? pcif.jregaddr : PCadd4;
   

endmodule // pc


