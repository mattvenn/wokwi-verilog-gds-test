`timescale 1ns / 1ps
//`include "user_module_339898704941023827.v"

module user_module_339898704941023827_tb;

reg [7:0] io_in;
wire [7:0] io_out;

reg [23:0] counter;
reg [3:0] state;

parameter CLK_HALF_PERIOD = 5;

initial begin
  io_in[0] = 0;
  #(CLK_HALF_PERIOD);
  forever io_in[0] = #(CLK_HALF_PERIOD) ~io_in[0];
end

initial begin
  $dumpfile("user_module_339898704941023827_tb.vcd");
  $dumpvars(0, user_module_339898704941023827_tb);
end

initial begin
   #1_000_000; // Wait a long time in simulation units (adjust as needed).
   $display("Caught by trap");
   $finish;
 end

endmodule
