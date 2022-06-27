`timescale 1ns / 1ps

module comp(
    input  [31:0] rd1_i ,
    input  [31:0] rd2_i ,
    input         brUn_i,

    output        brEQ_o,
    output reg    brLT_o
);

assign brEQ_o = rd1_i == rd2_i ? param.BREQ_T : param.BREQ_F;

wire a_b_sign_eq;
assign a_b_sign_eq = (rd1_i[31] ^ rd2_i[31]);

always @(*) begin
    case(a_b_sign_eq)
        0: brLT_o = rd1_i[30:0] < rd2_i[30:0] ? param.BRLT_T : param.BRLT_F;
        1: brLT_o = rd1_i[31] == 0 ? param.BRLT_T : param.BRLT_F;
    endcase
end

endmodule
