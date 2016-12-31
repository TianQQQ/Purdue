// cpu types
`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"

`timescale 1 ns / 1 ns
import cpu_types_pkg::*;
module dcaches_tb;

  parameter PERIOD = 20;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

     caches_if cif0();
   caches_if cif1();
   cache_control_if #(.CPUS(1)) ccif (cif0, cif1);


  // test program
  test PROG (CLK, nRST, dcif, cif0);

  // DUT
  dcaches DUT(CLK, nRST,dcif, cif0);

/*
  ram RAM(CLK, nRST, ramif);
  memory_control MC (CLK, nRST, ccif);

  assign ramif.ramaddr = ccif.ramaddr;
  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramREN = ccif.ramREN;
  assign ramif.ramWEN = ccif.ramWEN;
  assign ccif.ramstate = ramif.ramstate;
  assign ccif.ramload = ramif.ramload;

*/

endmodule

program test (input logic CLK, output logic nRST, datapath_cache_if dcif, caches_if ccif);

parameter CPUID = 0;
parameter PERIOD = 10;

initial begin: TEST

int count;  // cannot initial here




count = 0;
nRST = 1'b0;
#(PERIOD*1);
@(posedge CLK);
nRST = 1'b1;
#(PERIOD*1);



///////////////////////////////////////////////////////////////////  read write
dcif.dmemaddr = 32'h11111110;
dcif.dmemstore = 32'hdeadbeef;
dcif.dmemREN = 1'b0;
dcif.dmemWEN = 1'b1;
dcif.halt = 1'b0;

ccif.dwait = 0;
ccif.dload = 1;

//ccif.dwait = 0;

@(posedge CLK);


#(PERIOD*1);
while(dcif.dhit != 1) begin  // make sure data store into memory
	//count++;
	//$display(dcif.dhit);
	@(posedge CLK);
end
@(posedge CLK);
dcif.dmemWEN = 1'b0;
#(PERIOD*1);
@(posedge CLK);
dcif.dmemREN = 1'b1;
#(PERIOD*1);
@(posedge CLK);

while(dcif.dhit != 1) begin
	//count++;
	@(posedge CLK);
end
@(posedge CLK);
$display(dcif.dmemload);
$display(dcif.dmemload == 32'hdeadbeef);

if(dcif.dmemload == 32'hdeadbeef && count == 0)
	$display(" test1 write to empty cache and read passed");
else
	$display(" test1 write to empty cache and read failed");









//////////////////////////////////////////////////////// Dirty write read
dcif.dmemaddr = 32'h11111110;
dcif.dmemstore = 32'haaaaaaaa;
dcif.dmemREN = 1'b0;
dcif.dmemWEN = 1'b1;
dcif.halt = 1'b0;

ccif.dwait = 0;
ccif.dload = 1;

//ccif.dwait = 0;

@(posedge CLK);


#(PERIOD*1);
while(dcif.dhit != 1) begin  // make sure data store into memory
	//count++;
	//$display(dcif.dhit);
	@(posedge CLK);
end
@(posedge CLK);
dcif.dmemWEN = 1'b0;
#(PERIOD*1);
@(posedge CLK);
dcif.dmemREN = 1'b1;
#(PERIOD*1);
@(posedge CLK);

while(dcif.dhit != 1) begin
	//count++;
	@(posedge CLK);
end
@(posedge CLK);
$display(dcif.dmemload);
$display(dcif.dmemload == 32'hdeadbeef);

if(dcif.dmemload == 32'haaaaaaaa && count == 0)
	$display(" test2 write to dirty cache and read passed");
else
	$display(" test2 write to dirty cache and read failed");

dcif.halt = 1;
#(PERIOD*1);
@(posedge CLK);
dcif.halt = 1'b0;
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1)



//////////////////////////////////////////////////////// consecutive read hits
dcif.dmemaddr = 32'h11111110;
dcif.dmemstore = 32'haaaaaaaa;
dcif.dmemREN = 1'b0;
dcif.dmemWEN = 1'b1;
dcif.halt = 1'b0;

ccif.dwait = 0;
ccif.dload = 32'h11111111;

//ccif.dwait = 0;

@(posedge CLK);


#(PERIOD*1);
while(dcif.dhit != 1) begin  // make sure data store into memory
	//count++;
	//$display(dcif.dhit);
	@(posedge CLK);
end
@(posedge CLK);
dcif.dmemWEN = 1'b0;
#(PERIOD*1);
@(posedge CLK);
dcif.dmemREN = 1'b1;
#(PERIOD*1);
@(posedge CLK);

while(dcif.dhit != 1) begin
	//count++;
	@(posedge CLK);
end
@(posedge CLK);
$display(dcif.dmemload);

if(dcif.dmemload == 32'haaaaaaaa && count == 0)
	$display(" test3 consecutive read hits  passed");
else
	$display(" test3 consecutive read hits failer");

dcif.halt = 1;
#(PERIOD*1);
@(posedge CLK);
dcif.halt = 1'b0;
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);


///////////////////////////////////////////////////////////////// 


dcif.dmemaddr = 32'h11111110;
dcif.dmemREN = 1'b1;
dcif.dmemWEN = 1'b0;
dcif.halt = 1'b0;

ccif.dwait = 0;
ccif.dload = 32'h11111111;


@(posedge CLK);
$display(dcif.dmemload);

if(dcif.dmemload == 32'haaaaaaaa && count == 0)
	$display(" test4 read hit way0 again passed");
else
	$display(" test4 read hit way0 again failed");

dcif.halt = 1;
#(PERIOD*1);
@(posedge CLK);
dcif.halt = 1'b0;
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);

//////////////////////////////////////////////////////// read to renew memmory
dcif.dmemaddr = 32'h00000010;
dcif.dmemstore = 32'hbbbbbbbb;
dcif.dmemREN = 1'b0;
dcif.dmemWEN = 1'b1;
dcif.halt = 1'b0;

ccif.dwait = 0;

//ccif.dwait = 0;

@(posedge CLK);
while(dcif.dhit != 1) begin
	//count++;
	@(posedge CLK);
end
@(posedge CLK);
dcif.dmemWEN = 1'b0;
#(PERIOD*1);
@(posedge CLK);
dcif.dmemREN = 1'b1;
#(PERIOD*1);
@(posedge CLK);


#(PERIOD*1);
while(dcif.dhit != 1) begin  // make sure data store into memory
	//count++;
	//$display(dcif.dhit);
	@(posedge CLK);
end
@(posedge CLK);

if(dcif.dmemload == 32'hbbbbbbbb && count == 0)
	$display(" test2 write to dirty cache and read passed");
else
	$display(" test2 write to dirty cache and read failed");

dcif.halt = 1;
#(PERIOD*1);
@(posedge CLK);
dcif.halt = 1'b0;
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1)




//////////////////////////////////////////////////////// read to renew memmory
dcif.dmemaddr = 32'h11111110;
dcif.dmemREN = 1'b1;
dcif.dmemWEN = 1'b0;
dcif.halt = 1'b0;

ccif.dwait = 0;

//ccif.dwait = 0;

#(PERIOD*1);
while(dcif.dhit != 1) begin  // make sure data store into memory
	//count++;
	//$display(dcif.dhit);
	@(posedge CLK);
end
@(posedge CLK);

if(dcif.dmemload == 32'haaaaaaaa && count == 0)
	$display(" test2 write to dirty cache and read passed");
else
	$display(" test2 write to dirty cache and read failed");

dcif.halt = 1;
#(PERIOD*1);
@(posedge CLK);
dcif.halt = 1'b0;
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1)












///////////////////////////////////////////////////////////////// read hit way0 again


dcif.dmemaddr = 32'h11111110;
dcif.dmemREN = 1'b1;
dcif.dmemWEN = 1'b0;
dcif.halt = 1'b0;

ccif.dwait = 0;
ccif.dload = 32'h11111111;


@(posedge CLK);
$display(dcif.dmemload);

if(dcif.dmemload == 32'haaaaaaaa && count == 0)
	$display(" test4 read hit way0 again passed");
else
	$display(" test4 read hit way0 again failed");

dcif.halt = 1;
#(PERIOD*1);
@(posedge CLK);
dcif.halt = 1'b0;
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);

//////////////////////////////////////////////////////// read to renew memmory
dcif.dmemaddr = 32'h10101010101010101010101010101010;
dcif.dmemstore = 32'hbbbbbbbb;
dcif.dmemREN = 1'b0;
dcif.dmemWEN = 1'b1;
dcif.halt = 1'b0;

ccif.dwait = 0;

//ccif.dwait = 0;

@(posedge CLK);
while(dcif.dhit != 1) begin
	//count++;
	@(posedge CLK);
end
@(posedge CLK);
dcif.dmemWEN = 1'b0;
#(PERIOD*1);
@(posedge CLK);
dcif.dmemREN = 1'b1;
#(PERIOD*1);
@(posedge CLK);


#(PERIOD*1);
while(dcif.dhit != 1) begin  // make sure data store into memory
	//count++;
	//$display(dcif.dhit);
	@(posedge CLK);
end
@(posedge CLK);

if(dcif.dmemload == 32'hbbbbbbbb && count == 0)
	$display(" test2 write to dirty cache and read passed");
else
	$display(" test2 write to dirty cache and read failed");

dcif.halt = 1;
#(PERIOD*1);
@(posedge CLK);
dcif.halt = 1'b0;
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1)


//////////////////////////////////////////////////////// read to renew memmory
dcif.dmemaddr = 32'h11101010101010101010101010101110;
dcif.dmemstore = 32'haaaabbbb;
dcif.dmemREN = 1'b0;
dcif.dmemWEN = 1'b1;
dcif.halt = 1'b0;

ccif.dwait = 0;

//ccif.dwait = 0;

@(posedge CLK);
while(dcif.dhit != 1) begin
	//count++;
	@(posedge CLK);
end
@(posedge CLK);
dcif.dmemWEN = 1'b0;
#(PERIOD*1);
@(posedge CLK);
dcif.dmemREN = 1'b1;
#(PERIOD*1);
@(posedge CLK);


#(PERIOD*1);
while(dcif.dhit != 1) begin  // make sure data store into memory
	//count++;
	//$display(dcif.dhit);
	@(posedge CLK);
end
@(posedge CLK);

if(dcif.dmemload == 32'haaaabbbb && count == 0)
	$display(" test2 write to dirty cache and read passed");
else
	$display(" test2 write to dirty cache and read failed");

dcif.halt = 1;
#(PERIOD*1);
@(posedge CLK);
dcif.halt = 1'b0;
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1)



//////////////////////////////////////////////////////// read to renew memmory
dcif.dmemaddr = 32'h11111110101010101010101010101110;
dcif.dmemstore = 32'haaaabbbb;
dcif.dmemREN = 1'b0;
dcif.dmemWEN = 1'b1;
dcif.halt = 1'b0;

ccif.dwait = 0;

//ccif.dwait = 0;

@(posedge CLK);
while(dcif.dhit != 1) begin
	//count++;
	@(posedge CLK);
end
@(posedge CLK);
dcif.dmemWEN = 1'b0;
#(PERIOD*1);
@(posedge CLK);
dcif.dmemREN = 1'b1;
#(PERIOD*1);
@(posedge CLK);


#(PERIOD*1);
while(dcif.dhit != 1) begin  // make sure data store into memory
	//count++;
	//$display(dcif.dhit);
	@(posedge CLK);
end
@(posedge CLK);

if(dcif.dmemload == 32'haaaabbbb && count == 0)
	$display(" test2 write to dirty cache and read passed");
else
	$display(" test2 write to dirty cache and read failed");

dcif.halt = 1;
#(PERIOD*1);
@(posedge CLK);
dcif.halt = 1'b0;
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1)


//////////////////////////////////////////////////////// read to renew memmory
dcif.dmemaddr = 32'h11111010101010101010101010101110;
dcif.dmemstore = 32'hcccccccc;
dcif.dmemREN = 1'b0;
dcif.dmemWEN = 1'b1;
dcif.halt = 1'b0;

ccif.dwait = 0;

//ccif.dwait = 0;

@(posedge CLK);
while(dcif.dhit != 1) begin
	//count++;
	@(posedge CLK);
end
@(posedge CLK);
dcif.dmemWEN = 1'b0;
#(PERIOD*1);
@(posedge CLK);
dcif.dmemREN = 1'b1;
#(PERIOD*1);
@(posedge CLK);


#(PERIOD*1);
while(dcif.dhit != 1) begin  // make sure data store into memory
	//count++;
	//$display(dcif.dhit);
	@(posedge CLK);
end
@(posedge CLK);

if(dcif.dmemload == 32'hcccccccc && count == 0)
	$display(" test2 write to dirty cache and read passed");
else
	$display(" test2 write to dirty cache and read failed");

dcif.halt = 1;
#(PERIOD*1);
@(posedge CLK);
dcif.halt = 1'b0;
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1)



///////////////////////////////////////////////////////////////////// flush write back


dcif.dmemaddr = 32'h11111110;
dcif.dmemREN = 1'b0;   // neither read or write
dcif.dmemWEN = 1'b0;
dcif.halt = 1'b1;
ccif.dwait = 0;
ccif.dload = 32'haaaaaaaa;

@(posedge CLK);
$display(dcif.dmemload);

if(dcif.dmemload == 32'h00000000 && count == 0)
	$display(" test5 flush write back passed");
else
	$display(" test5 flush write back failed");

dcif.halt = 1;
#(PERIOD*1);
@(posedge CLK);
dcif.halt = 1'b0;
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);
#(PERIOD*1);










end

endprogram
