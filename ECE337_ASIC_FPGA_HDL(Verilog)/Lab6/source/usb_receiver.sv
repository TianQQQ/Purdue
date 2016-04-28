// $Id: $
// File name:   usb_receiver.sv
// Created:     3/1/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: reveiver.sv



// top level design, connectup all of the other functional unit design files
module usb_receiver (
		     input 	       clk,
		     input 	       n_rst,
		     input 	       d_plus,
		     input 	       d_minus,
		     input 	       r_enable,
		     output wire [7:0] r_data,
		     output wire       empty,
		     output wire       full,
		     output wire       rcving,
		     output wire       r_error);


   reg 				       eop;
   reg 				       d_orig;
   reg 				       d_edge;
   reg 				       w_enable;
   reg 				       d_plus_sync;
   reg 				       d_minus_sync;
   reg 				       shift_enable;
   reg 				       byte_received;
   reg [7:0] 			       rcv_data;
   


   decode DECODE(
		 .clk(clk),
		 .n_rst(n_rst),
		 .d_plus(d_plus_sync),
		 .shift_enable(shift_enable),
		 .eop(eop),
		 .d_orig(d_orig)
		 );
   
   edge_detect EDGE_DETECT(
			   .clk(clk),
			   .n_rst(n_rst),
			   .d_plus(d_plus_sync),
			   .d_edge(d_edge)
			   );

   
   timer TIMER(
	       .clk(clk),
	       .n_rst(n_rst),
	       .d_edge(d_edge),
	       .rcving(rcving),
	       .shift_enable(shift_enable),
	       .byte_received(byte_received)
	       );

   shift_register SHIFT_REGISTER (
				  .clk(clk),
				  .n_rst(n_rst),
				  .shift_enable(shift_enable),
				  .d_orig(d_orig),
				  .rcv_data(rcv_data)
				  );

   rx_fifo RX_FIFO(
		   .clk(clk),
		   .n_rst(n_rst),
		   .r_enable(r_enable),
		   .w_enable(w_enable),
		   .w_data(rcv_data),
		   .r_data(r_data),
		   .empty(empty),
		   .full(full)
		   );
   
   eop_detect EOP_DETECT (
			  .d_plus(d_plus_sync),
			  .d_minus(d_minus_sync),
			  .eop(eop)
			  );

   rcu RCU(
	   .clk(clk),
	   .n_rst(n_rst),
	   .d_edge(d_edge),
	   .eop(eop),
	   .shift_enable(shift_enable),
	   .rcv_data(rcv_data),
	   .byte_received(byte_received),
	   .rcving(rcving),
	   .w_enable(w_enable),
	   .r_error(r_error)
	   );



   sync SYNC_HIGH(
		       .clk(clk),
		       .n_rst(n_rst),
		       .async_in(d_plus),
		       .k(1'd1),
		       .sync_out(d_plus_sync)
		       );

   sync SYNC_LOW(
		     .clk(clk),
		     .n_rst(n_rst),
		     .async_in(d_minus),
		     .k(1'd0),
		     .sync_out(d_minus_sync)
		     );





endmodule 
