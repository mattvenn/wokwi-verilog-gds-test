`default_nettype none

// Keep I/O fixed for TinyTapeout
module user_module_339898704941023827(
  input [7:0] io_in, 
  output [7:0] io_out
);

  // using io_in[0] as clk, io_in[1] as reset
  wire clk;
  assign clk = io_in[0];
  wire reset;
  assign reset = io_in[1];

  reg [21:0] counter = 0; // XXX: What is the clk freq for TT?
  reg [4:0] state = 5'b00000;
  //reg led = 0;

  // XXX: Are we using CA/CC 7seg for TT board?
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
      if (counter == 0) begin // overflow
        state <= state + 5'b00001;
        //led <= ~led;
      end

      counter <= counter + 1;
    end

    case(state)
      5'b00000 : led_out <= letter_h;
      5'b00001 : led_out <= letter_blank;
      5'b00010 : led_out <= letter_e;
      5'b00011 : led_out <= letter_blank;
      5'b00100 : led_out <= letter_l;
      5'b00101 : led_out <= letter_blank;
      5'b00110 : led_out <= letter_l;
      5'b00111 : led_out <= letter_blank;
      5'b01000 : led_out <= letter_o;
      5'b01001 : led_out <= letter_blank;
      5'b01010 : led_out <= letter_blank;
      5'b01011 : led_out <= letter_a;
      5'b01100 : led_out <= letter_blank;
      5'b01101 : led_out <= letter_s;
      5'b01110 : led_out <= letter_blank;
      5'b01111 : led_out <= letter_i;
      5'b10000 : led_out <= letter_blank;
      5'b10001 : led_out <= letter_c;
      5'b10010 : led_out <= letter_blank;
      5'b10011 : led_out <= letter_blank;
      5'b10100 : led_out <= letter_blank;
      5'b10101 : state <= 0; // reset

      default : led_out <= letter_blank;
    endcase
  end

  assign io_out = led_out;
  //assign io_out[6] = led;

endmodule
