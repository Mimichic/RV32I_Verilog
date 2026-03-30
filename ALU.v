module ALU (
    input [31:0] in1, in2, 
    input [3:0] alu_control,
    output reg [31:0] alu_result,
    output reg zero_flag
);
    always @(*)
    begin
        alu_result = 32'b0;
        zero_flag  = 1'b0;

        case(alu_control)
            4'b0000: alu_result = in1 & in2;           // AND
            4'b0001: alu_result = in1 | in2;           // OR
            4'b0010: alu_result = in1 + in2;           // ADD
            4'b0100: alu_result = in1 - in2;           // SUB
            4'b1000: alu_result = (in1 < in2) ? 1 : 0; // SLT
            4'b0011: alu_result = in1 << in2;          // SLL
            4'b0101: alu_result = in1 >> in2;          // SRL
            4'b0110: alu_result = in1 * in2;           // MUL
            4'b0111: alu_result = in1 ^ in2;           // XOR
            default: alu_result = 32'b0;               // Default safety
        endcase

        // Since zero_flag was initialized to 0 at the top, 
        // we only need to check the '1' condition here.
        if (alu_result == 32'b0)
            zero_flag = 1'b1;
    end
endmodule