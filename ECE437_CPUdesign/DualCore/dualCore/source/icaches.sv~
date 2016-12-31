/*
 yiyi chen
 evillase@gmail.com


 */

//CPU
 `include "datapath_cache_if.vh"
 `include "caches_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

module icaches (
  input logic CLK, nRST,
  datapath_cache_if.icache dcif,
  caches_if.icache ccif
);


  ///////////////////////////////////////////////////////////////// I_Cache 
  // 512 bits, directed mapped, one word per block
  // [tag[57:32], data[31:0], valid[58]]
  /////////////////////////////////////////////////////////////////
  logic [31:0] instruction, next_instruction;

  logic [15:0][58:0] icacheReg, next_icacheReg;
  /// tag
  logic [25:0] tag,tag_checking;
  logic [3:0]  index;

  logic        valid_checking;
  /// data
  logic [31:0] data_stored;
  logic        same_tag;

  //tag[57:32], data[31:0], valid[58]
  assign tag = dcif.imemaddr[31:6];
  assign index = dcif.imemaddr[5:2];

  assign tag_checking = icacheReg[index][57:32];
  assign valid_checking = icacheReg[index][58];
  assign data_stored = icacheReg[index][31:0];


always_comb
  begin
    ///////////// initilize
    dcif.ihit = 0;
    ccif.iREN = 0;
    ccif.iaddr = 0;
    dcif.imemload = 0;
    next_instruction = instruction;
    next_icacheReg = icacheReg;

	if(tag_checking == tag)
	     same_tag = 1;
	else
	     same_tag = 0;

     // make sure not doing things with data

	  // when we find a match in the tag, load the data from cache
	  if(valid_checking && same_tag) 
	    begin
               next_instruction = data_stored;
               dcif.imemload = data_stored;
               dcif.ihit = 1;
	    end

	  // when we do not find a match, from cache read data from RAM
	  else begin              
             ccif.iREN = dcif.imemREN;
             ccif.iaddr = dcif.imemaddr;
	     // no instruction are going into cache
             if(ccif.iwait == 0)
               begin
	          // store the data into cache
		  next_icacheReg[index][58] = 1; 
		  next_icacheReg[index][57:32] = tag; 
		  next_icacheReg[index][31:0] = ccif.iload; 
	          // read data from cache
		  dcif.ihit = 1;
		  dcif.imemload = ccif.iload;
		  next_instruction = ccif.iload;
               end
	     // iwait = 1 already have a instruction goint into cache
             else 
		dcif.imemload = instruction;
	  end 
       end 



///////////////  flipflop to get next instruction and next cache 
integer i;
always_ff @(posedge CLK)
  begin
    if (nRST)
    begin
        instruction <= next_instruction;
        icacheReg <= next_icacheReg;
    end
    else 
    begin
        for (i=0;i<16;i++)
          icacheReg[i][58] <= 0;
    end 
  end 
   

  endmodule

