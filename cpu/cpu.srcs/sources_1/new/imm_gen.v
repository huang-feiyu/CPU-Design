`timescale 1ns / 1ps

module imm_gen(
    input      [3 :0] immSel_i,
    input      [31:7] inst_i  ,

    output reg [31:0] ext_o
);

// ext_o
always @(*) begin
    case (immSel_i)
        param.IMMSEL_R : ext_o = 32'b0;

        // inst[31:20]
        param.IMMSEL_I : ext_o = {{(20){inst_i[31]}}, inst_i[31:20]};

        // inst[24:20]
        param.IMMSEL_IS: ext_o = {27'b0, inst_i[24:20]};

        // inst[31:25|11:7]
        param.IMMSEL_S : ext_o = {{(20){inst_i[31]}}, inst_i[31:25], inst_i[11:7]};

        // {inst[31|7|30:25|11:8], 1'b0}
        param.IMMSEL_SB: ext_o = {{(19){inst_i[31]}}, inst_i[31], inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};

        // {inst[31:12], 12'b0}
        param.IMMSEL_U : ext_o = {inst_i[31:12], 12'b0};

        // {inst[31|19:12|20|30:21], 1'b0}
        param.IMMSEL_UJ: ext_o = {{(11){inst_i[31]}}, inst_i[31], inst_i[19:12], inst_i[20], inst_i[30:21], 1'b0};
        default:         ext_o = 32'b0;
    endcase
end

endmodule
