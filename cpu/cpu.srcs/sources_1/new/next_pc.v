`timescale 1ns / 1ps

module next_pc(
    input             clk_i ,
    input             rst_i ,
    input      [31:0] pc_i  ,
    input      [31:0] imm_i , // NOTE: ALU.C, no need to plus pc
    input             branch, // branch <= `PCSel`, `BrSel`, `BrEQ`, `BrLT`

    output reg [31:0] npc_o ,
    output reg [31:0] pc4_o   // for jalr or jal
);

// npc_o
always @(posedge clk_i or negedge rst_i) begin
    if (rst_i) begin
        npc_o <= 0;
    end else begin
        if (branch) begin
            npc_o <= imm_i;
        end else begin
            npc_o <= pc_i + 4;
        end
    end
end

// pc4_o
always @(posedge clk_i or negedge rst_i) begin
    if (rst_i) begin
        pc4_o <= 0;
    end else begin
        pc4_o <= pc_i + 4;
    end
end

endmodule
