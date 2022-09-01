module tb();

    reg rst_p = 1;
    reg[3:0] data;
    reg clk = 0;
    reg fast = 1;
    
    wire[6:0] daout;
    wire wcyc;
    
    localparam OP_NGA = 4'h0;
    localparam OP_AND = 4'h1;
    localparam OP_OR  = 4'h2;
    localparam OP_XOR = 4'h3;
    localparam OP_SLL = 4'h4;
    localparam OP_SRL = 4'h5;
    localparam OP_SRA = 4'h6;
    localparam OP_ADD = 4'h7;
    localparam OP_NOP = 4'h8;
    localparam OP_BEQ = 4'h9;
    localparam OP_BLE = 4'hA;
    localparam OP_JMP = 4'hB;
    localparam OP_LDA = 4'hC;
    localparam OP_LDB = 4'hD;
    localparam OP_STA = 4'hE;
    localparam OP_STB = 4'hF;       
    
    initial begin
        $dumpfile("frog.vcd");
        $dumpvars;

        #10 rst_p = 0;

        repeat(10000) begin
            #10;
        end

        $finish;
    end

    always #50 clk = ~clk;

    user_module_341476989274686036 user_module(
        .io_in     ({fast, 1'b0, data, rst_p, clk}),
        .io_out    ({wcyc,daout})
    );
    
    always@(*) begin
        if(!wcyc) begin
            case(daout)
            7'h00: data = OP_NOP;
            7'h01: data = OP_NOP;
            7'h02: data = OP_LDA; //LDA 0x05
            7'h03: data = 4'h0;
            7'h04: data = 4'hd;
            7'h05: data = OP_NOP;
            7'h06: data = OP_LDB;
            7'h07: data = 4'h0;
            7'h08: data = 4'h9;
            7'h09: data = 4'h1;
            7'h0a: data = OP_NGA;
            7'h0b: data = OP_AND;
            7'h0c: data = OP_SLL;
            7'h0d: data = OP_SRL;
            7'h0e: data = OP_SLL;
            7'h0f: data = OP_SRA;
            7'h10: data = OP_SLL;
            7'h11: data = OP_OR;
            7'h12: data = OP_XOR;
            7'h13: data = OP_ADD; 
            7'h14: data = OP_BEQ;
            7'h15: data = 4'h0;
            7'h16: data = 4'h2;
            7'h17: data = OP_NOP;
            7'h18: data = OP_BLE; 
            7'h19: data = 4'h0;
            7'h1a: data = 4'h2;
            7'h1b: data = OP_NOP;
            7'h1c: data = OP_JMP;
            7'h1d: data = 4'h2; 
            7'h1e: data = 4'h0; 
            7'h1f: data = OP_NOP; 
            7'h20: data = OP_STA; 
            7'h21: data = 4'h2; 
            7'h22: data = 4'h0; 
            7'h23: data = OP_STB; 
            7'h24: data = 4'h2; 
            7'h25: data = 4'h0; 
            7'h26: data = OP_BLE; 
            7'h27: data = 4'hf; 
            7'h28: data = 4'he; 
            default: data = OP_NOP;
            endcase
        end
    end
    
endmodule
