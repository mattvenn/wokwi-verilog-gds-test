`default_nettype none

module user_module_341476989274686036(
    input [7:0] io_in,
    output [7:0] io_out
    );
    
    localparam OP_NOP = 4'h0;
    localparam OP_AND = 4'h1;
    localparam OP_OR  = 4'h2;
    localparam OP_XOR = 4'h3;
    localparam OP_SLL = 4'h4;
    localparam OP_SRL = 4'h5;
    localparam OP_SLA = 4'h6;
    localparam OP_ADD = 4'h7;
    localparam OP_NOP1= 4'h8;
    localparam OP_NOP2= 4'h9;
    localparam OP_JNE = 4'hA;
    localparam OP_JMP = 4'hB;
    localparam OP_LDA = 4'hC;
    localparam OP_LDB = 4'hD;
    localparam OP_STA = 4'hE;
    localparam OP_STB = 4'hF;
    
    wire clk = io_in[0];
    wire rst_p = io_in[1];
    wire[3:0] data_in = io_in[5:2];
    
    wire wcyc;
    wire[5:0] addr;
    
    reg[3:0] reg_a;
    reg[3:0] reg_b;
    reg[5:0] tmp;
    reg[5:0] pc;
    reg rb;
    reg store;
    
    reg jmp;
    reg jne;
    
    localparam STATE_ADDR  = 3'h0;
    localparam STATE_OP    = 3'h1;
    localparam STATE_MEM1  = 3'h2;
    localparam STATE_MEM2  = 3'h3;
    localparam STATE_MEM3  = 3'h4;
    reg[2:0] state;
    reg[2:0] next_state;

    always@(posedge clk or posedge rst_p) begin
        if(rst_p) begin
            rb <= 0;
            store <= 0;
            jmp <= 0;
            jne <= 0;
        end else begin
            store <= 0;
            rb <= 0;
            jmp <= 0;
            jne <= 0;
            if(state == STATE_OP) begin
                store <= &data_in[3:1];
                rb <= data_in[0];
                jmp <= data_in == OP_JMP;
                jne <= data_in == OP_JNE;
            end
        end
    end

    always@(posedge clk or posedge rst_p) begin
        if(rst_p) state <= STATE_ADDR;
        else state <= next_state;
    end 
    
    always@(*) begin
        next_state <= STATE_ADDR;
        case(state)
            STATE_ADDR: next_state <= STATE_OP;
            STATE_OP: if(data_in[3]) next_state <= STATE_MEM1;
            STATE_MEM1: next_state <= STATE_MEM2;
            STATE_MEM2: if(!jmp & !jne) next_state <= STATE_MEM3;
        endcase
    end
    
    always@(posedge clk or posedge rst_p) begin
        if(rst_p) begin
            reg_a <= 0;
            reg_b <= 0;
        end else begin
            if(state == STATE_OP)
                case(data_in[2:0])
                    OP_AND: reg_a <= reg_a & reg_b;
                    OP_OR:  reg_a <= reg_a | reg_b;
                    OP_XOR: reg_a <= reg_a ^ reg_b;
                    OP_SLL: reg_a <= reg_a << reg_b[1:0];
                    OP_SRL: reg_a <= reg_a >> reg_b[1:0];
                    OP_SLA: reg_a <= reg_a >>> reg_b[1:0];
                    OP_ADD: reg_a <= reg_a + reg_b;
                endcase
            else if(state == STATE_MEM3 && !store)
                if(rb) reg_b <= data_in;
                else reg_a <= data_in;
        end
    end
    
    always@(posedge clk or posedge rst_p) begin
        if(rst_p)
            tmp <= 0;
        else if(state == STATE_MEM1) tmp[5:4] <= data_in[1:0];
        else if(state == STATE_MEM2) tmp[3:0] <= data_in;
    end    
    
    always@(posedge clk or posedge rst_p) begin
        if(rst_p) pc <= 0;
        else if(state == STATE_MEM2 && (jne & (reg_a != reg_b))) pc <= {tmp[5:4],data_in};
        else if(state == STATE_MEM2 && jmp) pc <= {tmp[5:4],data_in};
        else pc <= pc + 1;
    end
    
    assign wcyc = (state == STATE_MEM3) & store;
    assign addr = (state == STATE_MEM3) ? tmp : pc;
    assign io_out[5:0] = wcyc ? (rb ? reg_b : reg_a) : addr;
    assign io_out[6] = wcyc;
    
endmodule
