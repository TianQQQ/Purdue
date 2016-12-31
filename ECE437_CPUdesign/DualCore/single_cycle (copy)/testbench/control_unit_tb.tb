/*
  Yiyi Chen
  chen1234@purdue.edu

  alu file test bench
*/

// mapped needs this
`include "cpu_types_pkg.vh"
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "caches_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

   parameter PERIOD = 20;

   logic CLK = 1, nRST;

   always #(PERIOD/2) CLK++;

   caches_if cif0();
   caches_if cif1();
   cache_control_if #(.CPUS(1)) ccif (cif0, cif1);
   cpu_ram_if cprf();

   test PROG (CLK, nRST, cif0);

`ifndef MAPPED
   memory_control MEM (CLK, nRST, ccif);
   ram RAM(CLK, nRST, cprf);
`endif

   assign cprf.ramaddr = ccif.ramaddr;
   assign cprf.ramstore = ccif.ramstore;
   assign cprf.ramREN = ccif.ramREN;
   assign cprf.ramWEN = ccif.ramWEN;

   assign ccif.ramload = cprf.ramload;
   assign ccif.ramstate = cprf.ramstate;
   
endmodule // memory_control_tb



program test(input logic CLK,
	     output logic nRST, 
	     caches_if cif0);
   
   import cpu_types_pkg::*;
   parameter PERIOD2 = 40;

   int 	 testcase = 0;

   initial begin
      nRST = 0;
      cif0.dWEN = 0;
      cif0.dREN = 0;
      cif0.iREN = 0;
      cif0.dstore = '0;
      cif0.iaddr = '0;
      cif0.daddr = '0;
      
      testcase = 1;
      #(PERIOD2);
      nRST = 1;

      cif0.daddr = 32'h00000008;
      cif0.dstore = 32'hFA98AEF;
      cif0.dWEN = 1;
      #(PERIOD2);
      cif0.dWEN = 0;
      #(PERIOD2);
      cif0.dREN = 1;
      #(PERIOD2);
      cif0.dREN = 0;
      #(PERIOD2);

      cif0.daddr = 32'h0000000E;
      cif0.dstore = 32'hEAC8A8F;
      cif0.dWEN = 1;
      #(PERIOD2);
      cif0.dWEN = 0;
      #(PERIOD2);
      cif0.dREN = 1;
      #(PERIOD2);
      cif0.dREN = 0;
      #(PERIOD2);

      testcase = 2;
      cif0.dREN = 1;
      cif0.iREN = 1;
      #(PERIOD2);
      cif0.dREN = 0;
      #(PERIOD2);

      dump_memory();

   end // initial begin

   task automatic dump_memory();
      string filename = "memcpu.hex";
      int    memfd;

      //syif.tbCTRL = 1;
      cif0.daddr = 0;
      cif0.dWEN = 0;
      cif0.dREN = 0;

      memfd = $fopen(filename,"w");
      if (memfd)
	$display("Starting memory dump.");
      else
	begin $display("Failed to open %s.",filename); $finish; end

      for (int unsigned i = 0; memfd && i < 16384; i++)
	begin
	   int chksum = 0;
	   bit [7:0][7:0] values;
	   string 	  ihex;

	   cif0.daddr = i << 2;
	   cif0.dREN = 1;
	   repeat (4) @(posedge CLK);
	   if (cif0.dload === 0)
             continue;
	   values = {8'h04,16'(i),8'h00,cif0.dload};
	   foreach (values[j])
             chksum += values[j];
	   chksum = 16'h100 - chksum;
	   ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
	   $fdisplay(memfd,"%s",ihex.toupper());
	end //for
      if (memfd)
	begin
	   //syif.tbCTRL = 0;
	   cif0.dREN = 0;
	   $fdisplay(memfd,":00000001FF");
	   $fclose(memfd);
	   $display("Finished memory dump.");
	end
   endtask
endprogram


