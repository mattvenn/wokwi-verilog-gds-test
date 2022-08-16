`default_nettype none
//`include "user_module_339898704941023827.v"

module sevenseg_top (
  input TINY_CLK,
  input [7:0] io_in, //using io_in[0] as clk, io_in[1] as reset
  output [7:0] io_out
);

assign io_in[0] = TINY_CLK;

user_module_339898704941023827 mod1(.io_in(io_in), .io_out(io_out));

endmodule
