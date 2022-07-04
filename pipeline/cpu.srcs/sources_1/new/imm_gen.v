`timescale 1ns / 1ps

module imm_gen(
    input      [2 :0] immSel_i,
    input      [31:7] inst_i  ,

    output reg [31:0] ext_o
);

// ext_o
always @(*) begin
    // I : inst[31:20]
    // IS: inst[24:20]
    // S : inst[31:25|11:7]
    // SB: {inst[31|7|30:25|11:8], 1'b0}
    // U : {inst[31:12], 12'b0}
    // UJ: {inst[31|19:12|20|30:21], 1'b0}
    case (immSel_i)
        `IMMSEL_R : ext_o = 32'b0;
        `IMMSEL_I : ext_o = {{(20){inst_i[31]}}, inst_i[31:20]};
        `IMMSEL_IS: ext_o = {27'b0, inst_i[24:20]};
        `IMMSEL_S : ext_o = {{(20){inst_i[31]}}, inst_i[31:25], inst_i[11:7]};
        `IMMSEL_SB: ext_o = {{(19){inst_i[31]}}, inst_i[31], inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};
        `IMMSEL_U : ext_o = {inst_i[31:12], 12'b0};
        `IMMSEL_UJ: ext_o = {{(11){inst_i[31]}}, inst_i[31], inst_i[19:12], inst_i[20], inst_i[30:21], 1'b0};
        default   : ext_o = 32'b0;
    endcase
end

endmodule
