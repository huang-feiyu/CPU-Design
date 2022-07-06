`timescale 1ns / 1ps

module if_top(
    input         clk_i   ,
    input         rst_n_i ,
    input  [31:0] aluC_i  ,
    input         branch_i,

    output [31:0] pc4_o   ,
    output [31:0] pc_o
);

wire [31:0] npc;

pc_reg U_PC (
    .clk_i   (clk_i  ),
    .rst_n_i (rst_n_i),
    .npc_i   (npc    ),
    .pc_o    (pc_o   )
);

next_pc U_NPC (
    .pc_i     (pc_o    ),
    .aluC_i   (aluC_i  ),
    .branch_i (branch_i),
    .npc_o    (npc     ),
    .pc4_o    (pc4_o   )
);

endmodule
