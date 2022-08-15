`default_nettype none

module user_module_339898704941023827(
  //input CLK, // for testing with real hardware

  input [7:0] io_in,
  output [7:0] io_out
);

  // patterns for common anode wiring
                       //76543210
                       //xGFEDCBA
  reg[7:0] letter_h = 8'b10001001;
  reg[7:0] letter_e = 8'b10000110;
  reg[7:0] letter_l = 8'b11000111;
  reg[7:0] letter_o = 8'b11000000;
  reg[7:0] letter_a = 8'b10001000;
  reg[7:0] letter_s = 8'b10010010;
  reg[7:0] letter_i = 8'b11001111;
  reg[7:0] letter_c = 8'b11000110;
  reg[7:0] letter_blank =  8'b11111111;

  reg [23:0] counter;
  reg [3:0] state;

  //always @(posedge CLK) begin
  always @(posedge io_in[0]) begin
    counter <= counter + 1;

    if (counter[23])
      state <= state + 1;

    case(state)
      4'b0000 : io_out = letter_h;
      4'b0001 : io_out = letter_e;
      4'b0010 : io_out = letter_l;
      4'b0011 : io_out = letter_l;
      4'b0100 : io_out = letter_o;
      4'b0101 : io_out = letter_blank;
      4'b0110 : io_out = letter_a;
      4'b0111 : io_out = letter_s;
      4'b1000 : io_out = letter_i;
      4'b1001 : io_out = letter_c;
      4'b1010 : io_out = letter_blank;
      4'b1011 : io_out = letter_blank;
      //4'b1100 : state = 0; // this somehow breaks things?
      default : io_out = letter_blank;
    endcase

  end

endmodule
