// $Id: $
// File name:   tb_rx_fifo.sv
// Created:     2/25/2016
// Author:      Tian Qiu
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: tb rxfifo

`timescale 1ns / 10ps

module tb_rx_fifo();

   localparam CLK_PERIOD = 2.5;
   localparam CHECK_DELAY = 1;

   reg clk;
   reg n_rst;
   reg r_enable;
   reg w_enable;
   reg [7:0] w_data;
   reg [7:0] r_data;
   reg empty;
   reg full;


   rx_fifo DUT(
		.clk(clk),
		.n_rst(n_rst),
		.r_enable(r_enable),
		.w_enable(w_enable),
		.w_data(w_data),
		.r_data(r_data),
		.empty(empty),
		.full(full)
		);

   always
     begin
    clk = 1'b0;
    #(CLK_PERIOD/2.0);
    clk = 1'b1;
    #(CLK_PERIOD/2.0);
     end

   initial begin
      @(negedge clk);
      n_rst = 0;
      r_enable = 0;
      w_enable = 0;
      w_data = 0;

      @(negedge clk);
      n_rst = 1;
      assert (full == 0)begin
	 $info("PASS TEST CASE");
      end else begin
	 $info("FAIL TEST CASE");
      end

      assert (empty == 1)begin
	 $info("PASS TEST CASE");
      end else begin
	 $info("FAIL TEST CASE");
      end

      w_enable = 1;
      w_data = 8'b11111111;
      #(CLK_PERIOD)
      w_enable = 0;
      #(CLK_PERIOD)
      w_enable = 1;
      w_data = 8'b11101110;
      #(CLK_PERIOD)
      w_enable = 0;

      #(CLK_PERIOD)
      r_enable = 1;
      assert (r_data == 8'b11111111)begin
	 $info("PASS TEST CASE");
      end else begin
	 $info("FAIL TEST CASE");
      end
      #(CLK_PERIOD)
      r_enable = 0;

      #(CLK_PERIOD)
      r_enable = 1;
      assert (r_data == 8'b11101110)begin
	 $info("PASS TEST CASE");
      end else begin
	 $info("FAIL TEST CASE");
      end
      #(CLK_PERIOD)
      r_enable = 0;

      end

endmodule


      

   



      

   


