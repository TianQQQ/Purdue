// $Id: $
// File name:   timer.sv
// Created:     2/11/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: timer.sv
module timer 
(
	input wire clk,
	input wire n_rst,
	input wire enable_timer,
	output wire shift_strobe,
	output wire packet_done
);

    reg ff;
    reg enable_delay;
    reg [3:0]count_10;
    reg [3:0]count_9;
   
    flex_counter #(4) count_to_9
    (
     .clk(clk),
     .n_rst(n_rst),
     .clear(packet_done),
     .count_enable(shift_strobe),
     .rollover_val(4'd9),
     .count_out(count_9),
     .rollover_flag(packet_done)
    );

    flex_counter #(4) count_to_10
    (
     .clk(clk),
     .n_rst(n_rst),
     .clear(packet_done),
     .count_enable(enable_delay),
     .rollover_val(4'd10),
     .count_out(count_10),
     .rollover_flag(shift_strobe)
    );
   
    always_ff @ (posedge clk, negedge n_rst) begin
        if(n_rst == 0) begin 
            enable_delay <= 0;
            ff <= 0;
        end
        else begin
            ff <= enable_timer;
            enable_delay <= ff;
        end
    end

endmodule
