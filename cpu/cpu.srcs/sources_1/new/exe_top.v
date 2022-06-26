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

    output reg [31:0] aluC_o  ,
    output reg        branch_o
);

wire brEQ_t; // t means temp
wire brLT_t;

alu exe_alu(
    .rd1_i    (rd1_i)   ,
    .rd2_i    (rd2_i)   ,
    .pc_i     (pc_i)    ,
    .ext_i    (ext_i)   ,
    .aSel_i   (aSel_i)  ,
    .bSel_i   (bSel_i)  ,
    .aluSel_i (aluSel_i),
    .aluC_o   (aluC_o)
);

comp exe_comp(
    .rd1_i  (rd1_i) ,
    .rd2_i  (rd2_i) ,
    .brUn_i (brUn_i),

    .brEQ_o (brEQ_t),
    .brLT_o (brLT_t)
);

always @(*) begin
    case(brSel_i)
        param.BRSEL_NON: branch_o = param.BRANCH_PC4;
        param.BRSEL_BEQ: branch_o = brEQ_t == param.BREQ_T ? param.BRANCH_IMM : param.BRANCH_PC4;
        param.BRSEL_BNE: branch_o = brEQ_t == param.BREQ_F ? param.BRANCH_IMM : param.BRANCH_PC4;
        param.BRSEL_BLT: branch_o = brLT_t == param.BRLT_T ? param.BRANCH_IMM : param.BRANCH_PC4;
        param.BRSEL_BGE: branch_o = (brLT_t == param.BRLT_F) || (brEQ_t == param.BREQ_T) ?
                                    param.BRANCH_IMM : param.BRANCH_PC4;
        default:         branch_o = param.BRANCH_PC4;
    endcase
end


endmodule
