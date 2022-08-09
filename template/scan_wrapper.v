`default_nettype none
/*
`ifdef COCOTB
`define UNIT_DELAY #1
`define FUNCTIONAL
`define USE_POWER_PINS
`include "libs.ref/sky130_fd_sc_hd/verilog/primitives.v"
`include "libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
`endif
*/

module scan_wrapper_USER_MODULE_ID (
    input wire clk_in,
    input wire data_in,
    input wire scan_select_in,
    input wire latch_enable_in,
    output wire clk_out,
    output wire data_out,
    output wire scan_select_out,
    output wire latch_enable_out
    );
    
    assign scan_select_out = scan_select_in;
    assign latch_enable_out = latch_enable_in;
    assign clk_out = clk_in;
    wire clk = clk_in;

    /*
    `ifdef COCOTB
    initial begin
        $dumpfile ("scan_wrapper.vcd");
        $dumpvars (0, scan_wrapper_lesson_1);
        #1;
    end
    `endif
    */

    parameter NUM_IOS = 8;

    // wires needed
    wire [NUM_IOS-1:0] scan_data_out;   // output of the each scan chain flop
    wire [NUM_IOS-1:0] scan_data_in;    // input of each scan chain flop
    wire [NUM_IOS-1:0] module_data_in;  // the data that enters the user module
    wire [NUM_IOS-1:0] module_data_out; // the data from the user module

    // scan chain - link all the flops, with data coming from data_in
    assign scan_data_in = {scan_data_out[NUM_IOS-2:0], data_in};
    
    // end of the chain is the last scan flop's out
    assign data_out = scan_data_out[NUM_IOS-1];

    // scan flops have a mux on their inputs to choose either data from the user module or the previous flop's output
    // https://antmicro-skywater-pdk-docs.readthedocs.io/en/test-submodules-in-rtd/contents/libraries/sky130_fd_sc_ls/cells/sdfxtp/README.html
    `ifndef FORMAL
    `ifndef FORMAL_COMPAT
    sky130_fd_sc_hd__sdfxtp_1 scan_flop [NUM_IOS-1:0] (
        .CLK        (clk), 
        .D          (scan_data_in),
        .SCD        (module_data_out),
        .SCE        (scan_select_in),
        .Q          (scan_data_out),
        .VPWR       (1'b1),
        .VGND       (1'b0)
    );

    // latch is used to latch the input data of the user module while the scan chain is used to capture the user module's outputs
    // https://antmicro-skywater-pdk-docs.readthedocs.io/en/test-submodules-in-rtd/contents/libraries/sky130_fd_sc_hd/cells/dlxtp/README.html
    sky130_fd_sc_hd__dlxtp_1 latch [NUM_IOS-1:0] (
        .D          (scan_data_out),
        .GATE       (latch_enable_in),
        .Q          (module_data_in),
        .VPWR       (1'b1),
        .VGND       (1'b0)
    );
    `endif
    `endif

    // instantiate the wokwi module
    user_module_USER_MODULE_ID user_module(
        .io_in     (module_data_in),
        .io_out    (module_data_out)
    );

endmodule
