`default_nettype none

module user_module_339898704941023827(
  //input TINY_CLK, // XXX: for testing with real hardware
  input [7:0] io_in, //using io_in[0] as clk, io_in[1] as reset
  output [7:0] io_out
);

  wire clk;
  //assign clk = TINY_CLK; // XXX: for testing with real hardware
  assign clk = io_in[0];
  wire reset;
  assign reset = io_in[1];

  reg [23:0] counter = 0;
  reg [3:0] state = 4'b0000;
  reg led = 0;

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
  
  reg [7:0] led_out = 0;
  
  always @(posedge clk) begin
    if (reset) begin
        counter <= 0;
        state <= 0;
        led_out <= letter_blank;
    end else begin
      counter <= counter + 1;
      if (counter[23])
        state <= state + 4'b0001;
        //led <= ~led;
    end

    case(state)
      4'b0000 : led_out <= letter_h;
      4'b0001 : led_out <= letter_e;
      4'b0010 : led_out <= letter_l;
      4'b0011 : led_out <= letter_l;
      4'b0100 : led_out <= letter_o;
      4'b0101 : led_out <= letter_blank;
      4'b0110 : led_out <= letter_a;
      4'b0111 : led_out <= letter_s;
      4'b1000 : led_out <= letter_i;
      4'b1001 : led_out <= letter_c;
      4'b1010 : led_out <= letter_blank;
      4'b1011 : led_out <= letter_blank;
      4'b1100 : state <= 0; // reset

      default : led_out <= letter_blank;
    endcase


  end

  assign io_out = led_out;
  //assign io_out[6] = led;

endmodule
