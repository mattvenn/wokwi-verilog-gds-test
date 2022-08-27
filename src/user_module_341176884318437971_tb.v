`timescale 1ns / 1ps

`define assert(signal, value) \
    if (signal !== value) begin \
        $display("ASSERTION FAILED in %m"); \
        $finish; \
    end

module user_module_341176884318437971_tb;
    // Parameters
    parameter CLK_PERIOD = 10;

    // DUT I/O signals
    reg  [7:0] io_in;
    wire [7:0] io_out;

    // DUT
    user_module_341176884318437971
    DUT (
        .io_in (io_in),
        .io_out(io_out)
    );

    // Generate a clock.
    initial begin
        io_in[0] = 1'b0;
		
        forever #(CLK_PERIOD / 2) io_in[0] = !io_in[0];
    end

    // Generate a reset.
    initial begin
        io_in[1] = 1'b1;
        #(CLK_PERIOD)
        io_in[1] = 1'b0;
    end

    // Generate stimuli.
    initial begin
        $dumpfile("user_module_341176884318437971_tb.vcd");
        $dumpvars(0, user_module_341176884318437971_tb);
        $timeformat(-6, 2, " us", 16);

        // Initial values.
        io_in[7:2] = 6'd0;

        // Wait for reset.
        @(negedge io_in[1]);

        io_in[7:4] = 4'd3;
        #CLK_PERIOD;
        io_in[7:4] = 4'd7;
        #CLK_PERIOD;
        `assert(io_out, 8'd21);

		io_in[7:4] = 4'd15;
		#(2 * CLK_PERIOD);
		`assert(io_out, 8'd225);

		$finish;
    end
endmodule

