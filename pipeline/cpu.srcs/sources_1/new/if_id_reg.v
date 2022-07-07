`timescale 1ns / 1ps

module if_id_reg(
    input             clk_i    ,
    input             rst_n_i  ,

    input             stop_i   ,

    input      [31:0] if_pc_i  ,
    input      [31:0] if_pc4_i ,
    input      [31:0] if_inst_i,

    output reg [31:0] id_pc_o  ,
    output reg [31:0] id_pc4_o ,
    output reg [31:0] id_inst_o
);

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i)    id_pc_o <= 'b0    ;
    else if (stop_i) id_pc_o <= id_pc_o;
    else             id_pc_o <= if_pc_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i)    id_pc4_o <= 'b0     ;
    else if (stop_i) id_pc4_o <= id_pc4_o;
    else             id_pc4_o <= if_pc4_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i)    id_inst_o <= 'b0      ;
    else if (stop_i) id_inst_o <= id_inst_o;
    else             id_inst_o <= if_inst_i;
end

endmodule
