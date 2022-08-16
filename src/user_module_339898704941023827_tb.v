`timescale 1ns / 1ps
//`include "user_module_339898704941023827.v"

module user_module_339898704941023827_tb;

reg [7:0] io_in;
wire [7:0] io_out;

user_module_339898704941023827 UUT (.io_in(io_in), .io_out(io_out));

initial begin
  $dumpfile("user_module_339898704941023827_tb.vcd");
  $dumpvars(0, user_module_339898704941023827_tb);
end

initial begin
   #100_000_000; // Wait a long time in simulation units (adjust as needed).
   $display("Caught by trap");
   $finish;
 end

parameter CLK_HALF_PERIOD = 5;
always begin
  io_in[0] = 1'b1;
  #(CLK_HALF_PERIOD);
  io_in[0] = 1'b0;
  #(CLK_HALF_PERIOD);
end

initial 
begin
  #20
	io_in[1] = 1;
	#(CLK_HALF_PERIOD);
	io_in[1] = 0;
end

endmodule
