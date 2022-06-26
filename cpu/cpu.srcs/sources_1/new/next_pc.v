`timescale 1ns / 1ps

module next_pc(
    input      [31:0] pc_i    ,
    input      [31:0] aluC_i  , // NOTE: ALU.C, no need to plus pc
    input             branch_i, // branch_i <= `PCSel`, `BrSel`, `BrEQ`, `BrLT`

    output reg [31:0] npc_o   ,
    output     [31:0] pc4_o     // for jalr or jal
);

// pc4
assign pc4_o = pc_i + 32'h4;

// npc_o
always @(*) begin
    case (branch_i)
        param.BRANCH_IMM: npc_o = {aluC_i[31:1], 1'b0};
        param.BRANCH_PC4: npc_o = pc_i + 32'h4;
        default:          npc_o = npc_o;
    endcase
end

endmodule
