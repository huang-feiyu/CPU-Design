`timescale 1ns / 1ps

module next_pc(
    input             clk_i   ,
    input             rst_n_i ,
    input      [31:0] pc_i    ,
    input      [31:0] imm_i   , // NOTE: ALU.C, no need to plus pc
    input             branch_i, // branch_i <= `PCSel`, `BrSel`, `BrEQ`, `BrLT`

    output reg [31:0] npc_o   ,
    output reg [31:0] pc4_o     // for jalr or jal
);

// npc_o
always @(posedge clk_i or negedge rst_n_i) begin
    if (rst_n_i) begin
        npc_o <= 31'b0;
    end else begin
        if (branch_i == param.BRANCH_IMM) begin
            npc_o <= imm_i;
        end else begin
            npc_o <= pc_i + 31'h4;
        end
    end
end

// pc4_o
always @(posedge clk_i or negedge rst_n_i) begin
    if (rst_n_i) begin
        pc4_o <= 31'b0;
    end else begin
        pc4_o <= pc_i + 31'h4;
    end
end

endmodule
