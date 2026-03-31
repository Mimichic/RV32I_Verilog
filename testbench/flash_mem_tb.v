`timescale 1ns / 1ps

module data_memory_tb();

    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 8;
    parameter ROM_DEPTH  = 64;
    parameter RAM_DEPTH  = 64;

    reg clk;
    reg rst;
    reg [DATA_WIDTH-1:0] w_data;
    wire [DATA_WIDTH-1:0] r_data;
    reg [ADDR_WIDTH-1:0] address;
    reg ctrl_mem_w;
    reg ctrl_mem_r;

    data_memory #(DATA_WIDTH, ADDR_WIDTH, ROM_DEPTH, RAM_DEPTH) uut (
        .clk(clk),
        .rst(rst),
        .w_data(w_data),
        .r_data(r_data),
        .address(address),
        .ctrl_mem_w(ctrl_mem_w),
        .ctrl_mem_r(ctrl_mem_r)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        rst = 1;
        ctrl_mem_w = 0;
        ctrl_mem_r = 0;
        address = 0;
        w_data = 0;

        #25 rst = 0; 


        ctrl_mem_r = 1;
        ctrl_mem_r = 0;
        ctrl_mem_w = 1;
        address = 8'h40; // Address 64 (Start of RAM)
        w_data = 32'hDEADBEEF;
        #20; // Wait for clock edge     
        address = 8'h41;
        w_data = 32'hCAFEBABE;
        #20;
        ctrl_mem_w = 0;
        ctrl_mem_r = 1;
    end

endmodule