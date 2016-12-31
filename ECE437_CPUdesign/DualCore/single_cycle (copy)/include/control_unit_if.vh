/*
  Yiyi Chen
  chen1234@purdue.edu

*/
`ifndef CONTROL_UNIT_IF
`define CONTROL_UNIT_IF

`include "cpu_types_pkg.vh"

interface control_unit_if;

	  import cpu_types_pkg::*;

       	  //PC signals
	  logic		source1, source2, source3; 
	  word_t	jregaddr;
	  logic [ADDR_W-1:0] j_addr;

	  //ALU
	  aluop_t	aluop;
	  logic 	zeroflag;  //used to determine branch or not 
	  word_t 	porto;

	  //Register
	  logic		WEN;
	  regbits_t	wsel, rsel1, rsel2;
	  word_t 	wdat, rdat2;

	  //Request Unit
	  word_t	instr;
	  word_t 	datamemaddr, datamemstore;

	  //DATAPATH
	  logic [1:0]	extop;  //used for extender
	  logic 	irsel;
	  logic [1:0] 	memtoreg; 
	  logic [IMM_W-1:0] immediate;  //IMM_W equal to 16
	  logic 	    dWEN, dREN; 
	  logic 	    halt;

	  //modport
	  modport cu (
	  //------------------INPUT-----------------
	  input 
	  //from ALU
	  zeroflag, porto,
	  //from Register
	  rdat2, 
	  //from Request Unit
	  instr,

	  //-----------------OUPUT----------------
	  output
	  //to PC 
	  source1, source2, source3, immediate, j_addr, jregaddr,
	  //to ALU
	  aluop,
	  //to Register 
	  WEN, wsel, rsel1, rsel2, wdat,  //Write Enable and rs, rt, rd
	  //to Datapath
	  extop, irsel, memtoreg,
	  //to Request Unit
	  datamemaddr, datamemstore, halt, dWEN, dREN
	  
	  );

endinterface

`endif
