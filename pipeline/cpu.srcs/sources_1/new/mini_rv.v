`timescale 1ns / 1ps

// CPU
module mini_rv(
    input         fpga_clk_i,
    input         rst_n_i,
    output        debug_wb_have_inst,
    output [31:0] debug_wb_pc       ,
    output        debug_wb_ena      ,
    output [4: 0] debug_wb_reg      ,
    output [31:0] debug_wb_value
);

wire clk;
wire [31:0] if_pc  ;
wire [31:0] if_inst;
wire mem_memW;
wire [31:0] mem_rd2  ;
wire [31:0] mem_aluC ;
wire [31:0] mem_rd;

cpu CPU_CORE (
    .clk (clk),
    .rst_n_i (rst_n_i),
    .debug_wb_have_inst (debug_wb_have_inst),
    .debug_wb_pc (debug_wb_pc),
    .debug_wb_ena (debug_wb_ena),
    .debug_wb_reg (debug_wb_reg),
    .debug_wb_value (debug_wb_value),
    .if_inst (if_inst),
    .if_pc (if_pc),
    .mem_rd (mem_rd),
    .mem_aluC (mem_aluC),
    .mem_memW (mem_memW),
    .mem_rd2 (mem_rd2)
);

cpuclk CPU_CLK (
    .clk_in1  (fpga_clk_i),
    .clk_out1 (clk       )
);

inst_rom CPU_IROM (
    .pc_i   (if_pc   ),
    .inst_o (if_inst )
);

// MEM
data_ram CPU_MEM (
    .clk_i    (clk     ),
    .aluC_i   (mem_aluC),
    .memW_i   (mem_memW),
    .rd2_i    (mem_rd2 ),
    .mem_rd_o (mem_rd  )
);

endmodule
