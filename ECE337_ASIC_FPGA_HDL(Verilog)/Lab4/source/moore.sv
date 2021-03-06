// $Id: $
// File name:   moore.sv
// Created:     2/9/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: moore.sv
module moore
(
    input wire clk,
    input wire n_rst,
    input wire i,
    output reg o
);

  typedef enum {ST0, ST1, ST2, ST3, ST4} stateS;
  stateS currstate, nextstate;
	
  always@(posedge clk, negedge n_rst) begin : Reset_Logic
     if( n_rst == 0)begin
	currstate <= ST0;
     end else
       begin
	currstate <= nextstate;
       end
     end
     
  always@(currstate,i) begin: Next_State
     case(currstate)
       ST0: begin
	  if (1==i)
	    nextstate = ST1;
	  else
	    nextstate = ST0;
          end
       ST1: begin
	  if (1==i)
	    nextstate = ST2;
	  else
	    nextstate = ST0;
          end
       ST2: begin
	  if (0==i)
	    nextstate = ST3;
	  else
	    nextstate = ST2;
          end
       ST3: begin
	  if (1==i)
	    nextstate = ST4;
	  else
	    nextstate = ST0;
          end
       ST4: begin
	  if (1==i)
	    nextstate = ST1;
	  else
	    nextstate = ST0;
          end
       default: nextstate = ST0;
       endcase
       end
   assign o = (currstate == ST4) ? 1 : 0;
endmodule 


   
   
