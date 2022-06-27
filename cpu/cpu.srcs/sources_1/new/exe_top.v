`timescale 1ns / 1ps

module exe_top(
    input      [31:0] rd1_i   ,
    input      [31:0] rd2_i   ,
    input      [31:0] pc_i    ,
    input      [31:0] ext_i   ,
    input             aSel_i  ,
    input             bSel_i  ,
    input      [3 :0] aluSel_i,

    input      [2 :0] brSel_i ,
    input             brUn_i  ,

    input             pcSel_i ,

    output     [31:0] aluC_o  ,
    output reg        branch_o
);

wire brEQ_t; // t means temp
wire brLT_t;

alu exe_alu (
    .rd1_i    (rd1_i)   ,
    .rd2_i    (rd2_i)   ,
    .pc_i     (pc_i)    ,
    .ext_i    (ext_i)   ,
    .aSel_i   (aSel_i)  ,
    .bSel_i   (bSel_i)  ,
    .aluSel_i (aluSel_i),
    .aluC_o   (aluC_o)
);

comp exe_comp (
    .rd1_i  (rd1_i) ,
    .rd2_i  (rd2_i) ,
    .brUn_i (brUn_i),

    .brEQ_o (brEQ_t),
    .brLT_o (brLT_t)
);

always @(*) begin
    case(brSel_i)
        `BRSEL_NON: branch_o = pcSel_i;
        `BRSEL_BEQ: branch_o = brEQ_t == `BREQ_T ? `BRANCH_IMM : `BRANCH_PC4;
        `BRSEL_BNE: branch_o = brEQ_t == `BREQ_F ? `BRANCH_IMM : `BRANCH_PC4;
        `BRSEL_BLT: branch_o = brLT_t == `BRLT_T ? `BRANCH_IMM : `BRANCH_PC4;
        `BRSEL_BGE: branch_o = (brLT_t == `BRLT_F) || (brEQ_t == `BREQ_T) ? `BRANCH_IMM : `BRANCH_PC4;
        default:    branch_o = pcSel_i;
    endcase
end


endmodule
