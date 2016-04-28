// $Id: $
// File name:   mealy.sv
// Created:     2/9/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: mealy.sv
 module mealy
(
    input wire clk,
    input wire n_rst,
    input wire i,
    output reg o
);

   // try parameter this time
    reg [1:0]currstate;
    reg [1:0]nextstate;

    parameter [1:0]statestart = 2'b00;
    parameter [1:0]state1 = 2'b01;
    parameter [1:0]state11 = 2'b10;
    parameter [1:0]state110 = 2'b11;
    

    always_ff @ ( posedge clk, negedge n_rst ) 
    begin
        if( n_rst == 0 )
            currstate <= 2'b00;
        else
            currstate <= nextstate;
    end


    always_comb begin
        nextstate = currstate;
        o = 0;
        case(currstate) 

            statestart : begin        
                            if(i == 1)
                                nextstate = state1;
                            else
                                nextstate = statestart;
                          end
            state1     : begin                      
                            if(i == 1)
                                nextstate = state11;
                            else
                                nextstate = statestart;
                          end
            state11    : begin
                            if(i == 0)
                                nextstate = state110;
                            else
                                nextstate = state11;
                          end
            state110   : begin
                            if(i == 1)
                            begin
                                nextstate = state1;
                                o = 1;
                            end
                            else
                                nextstate = statestart;
                          end
            default     : begin
                            nextstate = statestart;
            end
	  endcase
    end

   


endmodule
