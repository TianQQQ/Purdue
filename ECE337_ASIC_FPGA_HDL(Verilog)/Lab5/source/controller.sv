// $Id: $
// File name:   controller.sv
// Created:     2/17/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: controller.sv
module controller
  (
   input wire 	    clk,
   input wire 	    n_reset,
   input wire 	    dr,
   input wire 	    lc,
   input wire 	    overflow,

   output reg 	    cnt_up,
   output reg 	    clear,
   output reg 	    modwait,
   output reg [2:0] op,
   output reg [3:0] src1,
   output reg [3:0] src2,
   output reg [3:0] dest,
   output reg 	    err
   );

   typedef enum     {idle, eidle, store, zero, sort1, sort2, sort3, sort4, mul1, add1, mul2, sub1, mul3, add2, mul4, sub2,loading_1,waiting_1,loading_2,waiting_2,loading_3,waiting_3,loading_4} states;
   reg 		    mod;   
   reg [4:0] 	    currentState;
   reg [4:0] 	    nextState;
   always_comb begin
      // INITIALIZATION
      cnt_up = 0; clear = 0; mod = 0; op = 3'd0; src1 = 4'd0; src2 = 4'd0; dest = 4'd0; err = 0; nextState = idle;
      case(currentState)
	store: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b010; src1 = 4'd0; src2 = 4'd0; dest = 4'd5; err = 1'd0;
	   if(dr==1)begin nextState = zero; cnt_up = 1'b1; end else nextState = eidle; end
	zero:  begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b101; src1 = 4'd0; src2 = 4'd0; dest = 4'd0; err = 1'd0; nextState = sort1; end
	sort1: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b001; src1 = 4'd2; src2 = 4'd0; dest = 4'd1; err = 1'd0; nextState = sort2; end
	sort2: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b001; src1 = 4'd3; src2 = 4'd0; dest = 4'd2; err = 1'd0; nextState = sort3; end
	sort3: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b001; src1 = 4'd4; src2 = 4'd0; dest = 4'd3; err = 1'd0; nextState = sort4; end
	sort4: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b001; src1 = 4'd5; src2 = 4'd0; dest = 4'd4; err = 1'd0; nextState = mul1; end
	
	mul1:  begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b110; src1 = 4'd1; src2 = 4'd6; dest = 4'd10; err = 1'd0; nextState = sub1; end
	mul2:  begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b110; src1 = 4'd2; src2 = 4'd7; dest = 4'd10; err = 1'd0; nextState = add1; end
	mul3:  begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b110; src1 = 4'd3; src2 = 4'd8; dest = 4'd10; err = 1'd0; nextState = sub2; end
	mul4:  begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b110; src1 = 4'd4; src2 = 4'd9; dest = 4'd10; err = 1'd0; nextState = add2; end	
	sub1:  begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b101; src1 = 4'd0; src2 = 4'd10; dest = 4'd0; err = 1'd0; 
	   if (overflow == 0) nextState = mul2; else nextState = eidle; end
	sub2:  begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b101; src1 = 4'd0; src2 = 4'd10; dest = 4'd0; err = 1'd0; 
	   if (overflow == 0) nextState = mul4; else nextState = eidle; end
	add1:  begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b100; src1 = 4'd0; src2 = 4'd10; dest = 4'd0; err = 1'd0; 
	   if (overflow == 0) nextState = mul3; else nextState = eidle; end
	add2:  begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b100; src1 = 4'd0; src2 = 4'd10; dest = 4'd0; err = 1'd0; 
	   if (overflow == 0) nextState = idle; else nextState = eidle; end
	loading_1: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b011; src1 = 4'd0; src2 = 4'd0; dest = 4'd6; err = 1'd0; nextState = waiting_1; end
	waiting_1: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b0; op = 3'b000; src1 = 4'd0; src2 = 4'd0; dest = 4'd0; err = 1'd0; 
	   if (lc==1)nextState = loading_2; else nextState = waiting_1; end
	loading_2: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b011; src1 = 4'd0; src2 = 4'd0; dest = 4'd7; err = 1'd0; nextState = waiting_2; end
	waiting_2: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b0; op = 3'b000; src1 = 4'd0; src2 = 4'd0; dest = 4'd0; err = 1'd0; 
	   if (lc==1)nextState = loading_3; else nextState = waiting_2; end
	loading_3: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b011; src1 = 4'd0; src2 = 4'd0; dest = 4'd8; err = 1'd0; nextState = waiting_3; end
	waiting_3: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b0; op = 3'b000; src1 = 4'd0; src2 = 4'd0; dest = 4'd0; err = 1'd0; 
	   if (lc==1)nextState = loading_4; else nextState = waiting_3; end
	loading_4: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b1; op = 3'b011; src1 = 4'd0; src2 = 4'd0; dest = 4'd9; err = 1'd0; nextState = idle; end



	idle:  begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b0; op = 3'b000; src1 = 4'd0; src2 = 4'd0; dest = 4'd0; err = 1'd0;
	   if(lc==1)begin nextState = loading_1;clear = 1;end else if (dr==1)	nextState = store; else nextState = idle; end
	eidle: begin cnt_up = 1'b0; clear = 1'b0; mod = 1'b0; op = 3'b000; src1 = 4'd0; src2 = 4'd0; dest = 4'd0; err = 1'd1; 
	   if (lc==1)nextState = loading_1; else if (dr==1) nextState = store; else nextState = eidle; end
	default: nextState = idle;
      endcase
   end
   always_ff@(posedge clk, negedge n_reset) begin
      if(n_reset==0) begin
	 currentState<= idle;
	 modwait <= 0;
      end else begin
	 currentState<= nextState;
	 modwait <= mod;
      end
   end
endmodule
