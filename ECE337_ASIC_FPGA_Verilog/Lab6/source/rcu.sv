// $Id: $
// File name:   rcu.sv
// Created:     3/1/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: rcu.sv

module rcu (
	    input       clk,
	    input 	n_rst,
	    input 	d_edge,
	    input [7:0] rcv_data,
	    input 	eop,
	    input 	shift_enable,
	    input 	byte_received,
	    output reg 	rcving,
	    output reg 	w_enable,
	    output reg 	r_error);

   typedef enum 	bit[3:0]{IDLE, SYNC_CHECK, DATA_RCV, BIT_RCV, BYTE_RCV, EOP_WT1, EOP_WT2, EOP_WT3, EOP_WT4, EIDLE} state_type;
   state_type state,nextState;

   always @(posedge clk,negedge n_rst) // state changing
     begin
	if(n_rst==1'b0)
	  state<=IDLE;
	else
	  state<=nextState;
     end

   always_comb
     begin
	nextState=state;
        r_error=0;
	rcving=0;
	w_enable=0;

	case(state)
	  IDLE:
	    begin
	       if(d_edge==1'b1)
		 nextState=DATA_RCV;
	       else
		 nextState=IDLE;
	    end
	  
	  SYNC_CHECK:
	    begin
	       rcving=1'b1;
	       if(rcv_data==8'b10000000)
		 nextState=BIT_RCV;
	       else
		 nextState=EOP_WT1;
	    end 
	  
	  DATA_RCV:
	    begin
	       rcving=1'b1;
	       w_enable=0;
	       r_error=0;
	       if(byte_received==1'b1)
		 nextState=SYNC_CHECK;
	       else
		 nextState=DATA_RCV;
	    end

	  BYTE_RCV:
	    begin
	       rcving=1'b1;
	       w_enable=1'b1;
	       nextState=EOP_WT3;
	    end

	  BIT_RCV:
	    begin
	       rcving=1'b1;
	       if(byte_received==1'b1)
		 nextState=BYTE_RCV;
	       else if(eop==1&&shift_enable==1)
		 nextState=EOP_WT2;
	    end 

	  EOP_WT1:
	    begin
	       rcving=1'b1;
	       r_error=1'b1;
	       if(shift_enable==1&&eop==1)
		 nextState=EOP_WT2;
	    end

	  EOP_WT2:
	    begin
	       rcving=1'b1;
	       r_error=1'b1;
	       if(d_edge==1'b1)
		 nextState=EIDLE;
	    end

	  EOP_WT3:
	    begin
	       rcving=1'b1;
	       if(shift_enable==1&&eop==1)
		 nextState=EOP_WT4;
	       else if(shift_enable==1&&eop==0)
		 nextState=BIT_RCV;
	    end
	  
	  EOP_WT4:
	    begin
	       rcving=1'b1;
	       if(d_edge==1'b1)
		 nextState=IDLE;
	    end

	  EIDLE:
	    begin
	       r_error=1'b1;
	       rcving=0;
	       w_enable=0;
	       if(d_edge==1'b1)
		 nextState=DATA_RCV;
	    end
	endcase
     end 
endmodule



