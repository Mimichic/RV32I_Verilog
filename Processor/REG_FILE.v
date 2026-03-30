module REG_FILE(
    input [4:0] read_reg_num1,
    input [4:0] read_reg_num2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2,
    input regwrite,
    input clock,
    input reset
);

    (* mark_debug = "true" *) reg [31:0] reg_memory [0:31];
    integer i;

    // Combinational Read: Always outputs data based on the address
    // We add a check for reg 0 just to be safe, though memory[0] should be 0.
    assign read_data1 = (read_reg_num1 == 5'b0) ? 32'b0 : reg_memory[read_reg_num1];
    assign read_data2 = (read_reg_num2 == 5'b0) ? 32'b0 : reg_memory[read_reg_num2];

    // Single Sequential Block: Handles both Reset and Writing
    always @(posedge clock or posedge reset)
    begin
        if (reset) begin
            // This loop will now work perfectly
            for (i = 0; i < 32; i = i + 1) begin
                reg_memory[i] <= i; // Initializing with index as you did
            end
        end 
        else if (regwrite && (write_reg != 5'b0)) begin
            // Write to register if regwrite is high AND it's not register 0
            reg_memory[write_reg] <= write_data;
        end
    end

endmodule