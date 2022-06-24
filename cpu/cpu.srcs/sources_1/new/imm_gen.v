`timescale 1ns / 1ps

module imm_gen(
    input             clk_i   ,
    input             rst_n_i ,
    input      [3 :0] immSel_i,
    input      [31:7] inst_i  ,

    output reg [31:0] ext_o
);

// ext_o
always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) begin
        ext_o <= 0;
    end else begin
        case (immSel_i)
        param.IMMSEL_R : begin
            ext_o <= 32'b0;
        end

        param.IMMSEL_I : begin
            // inst[31:25|11:7]
            ext_o <= {{(20){inst_i[31]}}, inst_i[31:20]};
        end

        param.IMMSEL_S : begin
            // inst[31:25|11:7]
            ext_o <= {{(20){inst_i[31]}}, inst_i[31:25], inst_i[11:7]};
        end
        param.IMMSEL_SB: begin
            // {inst[31|7|30:25|11:8], 1'b0}
            ext_o <= {{(20){inst_i[31]}}, inst_i[31], inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};
        end
        param.IMMSEL_U : begin
            // {inst[31:12], 12'b0}
            ext_o <= {inst_i[31:12], 12'b0};
        end
        param.IMMSEL_UJ: begin
            // {inst[31|19:12|20|30:21], 1'b0}
            ext_o <= {{(11){inst_i[31]}}, inst_i[31], inst_i[19:12], inst_i[20], inst_i[30:21], 1'b0};
        end
        endcase
    end
end

endmodule
