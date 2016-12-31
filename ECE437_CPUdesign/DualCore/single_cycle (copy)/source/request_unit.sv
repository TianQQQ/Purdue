/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "request_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module request_unit(
		    input logic CLK, nRST,
		    request_unit_if.ru ruif
		    );

   import cpu_types_pkg::*;

   always_comb begin
      if(!ruif.ihit)
	ruif.ramfull = 1;
      else
	ruif.ramfull = 0;
   end
   

   assign ruif.imemREN = 1;
      
   always_ff @ (posedge CLK, negedge nRST) begin
      if(!nRST) begin
	 ruif.dmemREN <= 1'b0;
	 ruif.dmemWEN <= 1'b0;
      end
      else begin
	 if(ruif.ihit && !ruif.dhit) begin  //instruction is ready then could be write 
	    ruif.dmemWEN <= ruif.dWEN;
	    ruif.dmemREN <= ruif.dREN;
	 end
	 else if(ruif.dhit) begin //will avoid read and write conflict
	    ruif.dmemREN <= 0;
	    ruif.dmemWEN <= 0;
	 end
      end // else: !if(!nRST)
   end // always_ff @

   always_ff @ (posedge CLK, negedge nRST) begin
      if(!nRST) begin
	 ruif.halt <= 0;
      end
      else begin
	 if(ruif.cuhlt) begin
	    ruif.halt <= 1;
	 end
      end
   end // always_ff @ (posedge CLK, negedge nRST)
   
endmodule // request_unit

   
