`include "param.v"

module alu(
    input      [31:0] rd1_i   ,
    input      [31:0] rd2_i   ,
    input      [31:0] pc_i    ,
    input      [31:0] ext_i   ,
    input             aSel_i  ,
    input             bSel_i  ,
    input      [3 :0] aluSel_i,

    output reg [31:0] aluC_o
);

wire [31:0] a = (aSel_i == `ASEL_R) ? rd1_i : pc_i ;
wire [31:0] b = (bSel_i == `BSEL_R) ? rd2_i : ext_i;

wire [4:0] shamt = b[4:0];

always @(*) begin
    case (aluSel_i)
        `ALUSEL_ADD: aluC_o = a + b;
        `ALUSEL_SUB: aluC_o = a - b;
        `ALUSEL_AND: aluC_o = a & b;
        `ALUSEL_OR : aluC_o = a | b;
        `ALUSEL_XOR: aluC_o = a ^ b;
        `ALUSEL_SLL: aluC_o = a << shamt; // NOTE: naive shift-op might be wrong
        `ALUSEL_SRL: aluC_o = a >> shamt;
        `ALUSEL_SRA: aluC_o = $signed(a) >>> shamt;
        `ALUSEL_LUI: aluC_o = b; // rd <- {imm[31:12], 12'b0}
        default    : aluC_o = aluC_o;
    endcase
end

endmodule
