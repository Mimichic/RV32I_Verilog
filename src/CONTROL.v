module CONTROL(
    input [6:0] funct7,
    input [2:0] funct3,
    input [6:0] opcode,
    output reg [3:0] alu_control,
    output reg regwrite_control
);
    // Use @(*) to catch all input changes automatically
    always @(*) 
    begin
        
        alu_control = 4'b1111;      // Set to an "Invalid/Idle" state
        regwrite_control = 1'b0;     

        if (opcode == 7'b0110011) begin // R-type instructions
            regwrite_control = 1'b1;

            case (funct3)
                3'b000: begin // ADD or SUB
                    if (funct7 == 7'h00)
                        alu_control = 4'b0010; // ADD
                    else if (funct7 == 7'h20)
                        alu_control = 4'b0100; // SUB
                    else
                        alu_control = 4'b1111; // Default for unknown funct7
                end
                3'b110: alu_control = 4'b0001; // OR
                3'b111: alu_control = 4'b0000; // AND
                3'b001: alu_control = 4'b0011; // SLL
                3'b101: alu_control = 4'b0101; // SRL
                3'b010: alu_control = 4'b0110; // MUL
                3'b100: alu_control = 4'b0111; // XOR
                default: alu_control = 4'b1111; // Default for unknown funct3
            endcase
        end 
    end

endmodule