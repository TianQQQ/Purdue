// $Id: $
// File name:   rcu.sv
// Created:     2/11/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: rcu.sv
module rcu 
(
	input wire clk,
	input wire n_rst,
	input wire start_bit_detected,
	input wire packet_done,
	input wire framing_error,
	output reg sbc_clear,
	output reg sbc_enable,
	output reg load_buffer,
	output reg enable_timer
);

   typedef enum    logic [2:0] {FIRST, START_BIT, PACKET_BIT_RV, STOP_BIT, FRAMING_ERROR, DATA_LOADING} state_type;
   state_type currentState, nextState;

   always_ff @ (posedge clk, negedge n_rst)   // state ff
     begin
    	if(n_rst == 0) 
          begin 
             currentState <= FIRST;
          end
        else
          begin
             currentState <= nextState;
          end
     end

   always_comb
     begin
        nextState = currentState;
        case(currentState) 
          FIRST: 
            begin
               if(start_bit_detected == 1)   // start bit got
                 begin
                    nextState = START_BIT;
                 end
               else
                 begin
                    nextState = FIRST;
                 end
            end // case: FIRST
	  
          START_BIT: 
            begin
               nextState = PACKET_BIT_RV;
            end //
	  
          PACKET_BIT_RV: 
            begin

               if(packet_done == 1)
                 begin
                    nextState = STOP_BIT;
                 end

               else
                 begin
                    nextState = PACKET_BIT_RV;
                 end
            end // case: PACKET_BIT_RV
	  
          STOP_BIT: 
            begin
               nextState = FRAMING_ERROR;
            end
	  
          FRAMING_ERROR: 
            begin
               if(framing_error == 1)
                 begin
                    nextState = FIRST;
                 end
               else
                 begin
                    nextState = DATA_LOADING;
                 end
            end // case: FRAMING_ERROR
	  
          DATA_LOADING: 
            begin
               nextState = FIRST;
            end
	  
          default
            begin
               nextState = FIRST;
            end
        endcase
     end
   assign sbc_clear = (currentState == START_BIT);
   assign sbc_enable = (currentState == STOP_BIT);
   assign enable_timer = (currentState == PACKET_BIT_RV);
   assign load_buffer = (currentState == DATA_LOADING);

endmodule

