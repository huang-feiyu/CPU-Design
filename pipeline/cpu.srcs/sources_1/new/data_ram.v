`timescale 1ns / 1ps

module data_ram(
    input         clk_i ,
    input  [31:0] aluC_i,
    input         mem_i , // do nothing?
    input         memW_i,
    input  [31:0] rd2_i ,

    output [31:0] mem_rd_o
);

dram U_dram (
    .clk (clk_i       ),
    .a   (aluC_i[15:2]),
    .spo (mem_rd_o    ),
    .we  (memW_i      ),
    .d   (rd2_i       )
);

endmodule
