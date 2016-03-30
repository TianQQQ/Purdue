// $Id: $
// File name:   flex_pts_sr.sv
// Created:     2/3/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: N bit paralle to serial shift register design
module flex_pts_sr
#(
  NUM_BITS = 4,
  SHIFT_MSB = 1
)
  
(
  input wire clk, n_rst, shift_enable, load_enable, 
  input reg [NUM_BITS-1:0]parallel_in,
  output wire serial_out

);
  reg [(NUM_BITS - 1):0] curr_state;
  reg [(NUM_BITS - 1):0] nextState;



  always_ff @ (posedge clk, negedge n_rst)
  begin
    
    if( n_rst == 0)
      curr_state <= '1;
    else
      curr_state <= nextState;
        
  end
  
  
  always_comb
  begin
    
    if(load_enable == 1)
      nextState = parallel_in;
      
    else
    begin
      if(shift_enable == 1)
      begin
        if (SHIFT_MSB == 1)
          nextState = {curr_state[NUM_BITS-2:0], 1'b1};
        else
          nextState = { 1'b1, curr_state[NUM_BITS-1:1]};      
      end
      else
        nextState = curr_state;
    end
  end
  
  if(SHIFT_MSB == 1)
    assign serial_out = curr_state[(NUM_BITS-1)];
  else
    assign serial_out = curr_state[0];
  
  


endmodule
