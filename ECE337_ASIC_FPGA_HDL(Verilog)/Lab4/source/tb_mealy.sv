// $Id: $
// File name:   tb_mealy.sv
// Created:     2/9/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: mealy.sv
`timescale 1ns / 10ps

module tb_mealy ();

   localparam CLK_PERIOD = 2.5;
   localparam CHECK_DELAY = 1;

   reg tb_clk;
   reg tb_n_rst;
   reg tb_i;
   reg tb_o;

   integer testcase;

   mealy DUT
   (
    .clk( tb_clk ),
    .n_rst( tb_n_rst ),
    .i ( tb_i ),
    .o ( tb_o )

    );

    
   // Clock generation block
   always
     begin
	tb_clk = 1'b0;
	#(CLK_PERIOD/2.0);
	tb_clk = 1'b1;
	#(CLK_PERIOD/2.0);
     end


   initial
     begin

	
	 //TEST CASE 1  RESET
	testcase = 1;
	tb_n_rst = 0;
	#(CHECK_DELAY);

	@(posedge tb_clk);
        tb_n_rst = 1;
	#(CHECK_DELAY);
	@(posedge tb_clk);
	
	tb_i = 1'b1;;
	@(posedge tb_clk);
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b0;
	@(posedge tb_clk);
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_n_rst = 0;
	#(CHECK_DELAY);

	@(posedge tb_clk);
	
	#(CHECK_DELAY);
	if(tb_o == 1'b0)
	  $info("Test case 1: Passed");
	else
	  $error("Test case 1: Failed");

		 //TEST CASE 2  continuous input
	testcase = 2;
	tb_n_rst = 0;
	#(CHECK_DELAY);
	@(posedge tb_clk);
        tb_n_rst = 1;
	#(CHECK_DELAY);
	@(posedge tb_clk);
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b0;
	@(posedge tb_clk);
	tb_i = 1'b1;
	#(CHECK_DELAY);
	
	if(tb_o == 1'b1)
	  $info("Test case 2: Passed");
	else
	  $error("Test case 2: Failed");

	//TEST CASE 3  return from 1100 to 1101
	testcase = 3;
	tb_n_rst = 0;
	#(CHECK_DELAY);
	@(posedge tb_clk);
        tb_n_rst = 1;
	#(CHECK_DELAY);
	@(posedge tb_clk);
	//input begin
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b0;
	@(posedge tb_clk);
	tb_i = 1'b0;
	@(posedge tb_clk);
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b0;
	@(posedge tb_clk);
	tb_i = 1'b1;
	#(CHECK_DELAY);
	
	if(tb_o == 1'b1)
	  $info("Test case 3: Passed");
	else
	  $error("Test case 3: Failed");



		//TEST CASE 4  continuous input from 10 to 1101
	testcase = 4;
	tb_n_rst = 0;
	#(CHECK_DELAY);
	@(posedge tb_clk);
        tb_n_rst = 1;
	#(CHECK_DELAY);
	@(posedge tb_clk);
	//input begin
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b0;
	@(posedge tb_clk);
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b0;
	@(posedge tb_clk);
	tb_i = 1'b1;

	#(CHECK_DELAY);
	
	if(tb_o == 1'b1)
	  $info("Test case 3: Passed");
	else
	  $error("Test case 3: Failed");


		//TEST CASE 5  continuous input from 111 to 1101
	testcase = 5;
	tb_n_rst = 0;
	#(CHECK_DELAY);
	@(posedge tb_clk);
        tb_n_rst = 1;
	#(CHECK_DELAY);
	@(posedge tb_clk);
	//input begin
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b0;
	@(posedge tb_clk);
	tb_i = 1'b1;
	#(CHECK_DELAY);
	
	if(tb_o == 1'b1)
	  $info("Test case 5: Passed");
	else
	  $error("Test case 5: Failed");

	
     end

endmodule

