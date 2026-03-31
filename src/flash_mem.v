module data_memory #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8,
    parameter ROM_DEPTH   = 64,  
    parameter RAM_DEPTH  = 64   
)(
    input wire clk,
    input wire rst,

    input wire [DATA_WIDTH-1:0] w_data,
    output reg [DATA_WIDTH-1:0] r_data,

    input wire [ADDR_WIDTH-1:0] address,

    input wire ctrl_mem_w,
    input wire ctrl_mem_r
);

    reg [DATA_WIDTH-1:0] rom_memory [0:ROM_DEPTH-1];
    reg [DATA_WIDTH-1:0] ram_memory [0:RAM_DEPTH-1];

    integer i;

    initial begin
        $readmemh("image_read .mem", rom_memory);
        for (i = 0; i < RAM_DEPTH; i = i + 1) begin
            ram_memory[i] = {DATA_WIDTH{1'b0}};
        end
    end

    always @(*) begin
        if (ctrl_mem_r) begin
            if (address < ROM_DEPTH) begin
                r_data = rom_memory[address];
            end else begin
                // Subtract ROM_DEPTH to get the RAM address
                r_data = ram_memory[address - ROM_DEPTH];
            end
        end else begin
            r_data = {DATA_WIDTH{1'b0}};
        end
    end

    // Only writes to the RAM section
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < RAM_DEPTH; i = i + 1) begin
                ram_memory[i] <= {DATA_WIDTH{1'b0}};
            end
        end else begin
            if (ctrl_mem_w && (address >= ROM_DEPTH)) begin
                ram_memory[address - ROM_DEPTH] <= w_data;
            end
        end
    end

endmodule