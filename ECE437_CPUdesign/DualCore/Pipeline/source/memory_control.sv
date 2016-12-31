/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

   //assign operation
   assign ccif.iload[0] = ccif.ramload;
   assign ccif.dload[0] = ccif.ramload;

   assign ccif.ramstore = ccif.dstore[0];

   //decide ramaddr
   assign ccif.ramaddr = (ccif.dREN[0] || ccif.dWEN[0]) ? ccif.daddr[0] : ccif.iaddr[0];
   assign ccif.ramWEN = ccif.dWEN[0];
   assign ccif.ramREN = (ccif.dREN[0]) ? ccif.dREN[0] : ccif.iREN[0];

   //iwait, dwait
   always_comb begin
      ccif.iwait[0] = 1'b1;
      ccif.dwait[0] = 1'b1;
      casez(ccif.ramstate)
	FREE: begin
	   ccif.iwait[0] = 1'b1;
	   ccif.dwait[0] = 1'b1;
	end
	BUSY: begin
	   ccif.iwait[0] = 1'b1;
	   ccif.dwait[0] = 1'b1;
	end
	ACCESS: begin
	   if(ccif.dREN[0] || ccif.dWEN[0])begin
	      ccif.iwait[0] = 1'b1;
	      ccif.dwait[0] = 1'b0;
	   end
	   else if(ccif.iREN[0])begin
	      ccif.iwait[0] = 1'b0;
	      ccif.dwait[0] = 1'b1;
	   end	      
	end
	ERROR: begin
	   ccif.iwait[0] = 1'b1;
	   ccif.dwait[0] = 1'b1;
	end
      endcase
   end
		       
   
endmodule
