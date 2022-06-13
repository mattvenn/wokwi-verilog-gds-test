/* Automatically generated from https://wokwi.com/projects/334295537442357843 */

module user_module(
  input reset,
  input clk,
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = 1'b0;
  wire net2 = 1'b1;
  wire net3;
  wire net4;
  wire net5;
  wire net6;
  wire net7;
  wire net8;
  wire net9;
  wire net10;
  wire net11;
  wire net12;
  wire net13;

  and_cell gate1 (
    .a (net2),
    .b (net3),
    .out (net4)
  );
  or_cell gate2 (
    .a (net5),
    .b (net6),
    .out (net7)
  );
  xor_cell gate3 (
    .a (net4),
    .b (net8),
    .out (net5)
  );
  nand_cell gate4 (
    .a (net3),
    .b (net1),
    .out (net9)
  );
  not_cell gate5 (
    .in (net10),
    .out (net6)
  );
  mux_cell mux1 (
    .a (net11),
    .b (net1),
    .sel (net12),
    .out (net10)
  );
  dff_cell flipflop1 (
    .d (net8),
    .clk (net9),
    .q (net11),
    .notq (net13)
  );
endmodule
