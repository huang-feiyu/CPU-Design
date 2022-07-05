`timescale 1ns / 1ps

module id_exe_reg(
    input             clk_i       ,
    input             rst_n_i     ,

    input      [31:0] id_pc_i     ,
    input      [31:0] id_pc4_i    ,
    input             id_pcSel_i  ,
    input      [1 :0] id_wbSel_i  ,
    input      [3 :0] id_aluSel_i ,
    input             id_aSel_i   ,
    input             id_bSel_i   ,
    input      [2 :0] id_brSel_i  ,
    input             id_memW_i   ,
    input      [31:0] id_ext_i    ,
    input      [31:0] id_rd1_i    ,
    input      [31:0] id_rd2_i    ,
    output     [4 :0] id_wr_i     ,
    output            id_regWEn_i ,

    output reg [31:0] exe_pc_o    ,
    output reg [31:0] exe_pc4_o   ,
    output reg        exe_pcSel_o ,
    output reg [1 :0] exe_wbSel_o ,
    output reg [3 :0] exe_aluSel_o,
    output reg        exe_aSel_o  ,
    output reg        exe_bSel_o  ,
    output reg [2 :0] exe_brSel_o ,
    output reg        exe_memW_o  ,
    output reg [31:0] exe_ext_o   ,
    output reg [31:0] exe_rd1_o   ,
    output reg [31:0] exe_rd2_o   ,
    output reg [4 :0] exe_wr_o    ,
    output reg        exe_regWEn_o
);

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_pc_o <= 'b0    ;
    else          exe_pc_o <= id_pc_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_pc4_o <= 'b0     ;
    else          exe_pc4_o <= id_pc4_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_pcSel_o <= 'b0       ;
    else          exe_pcSel_o <= id_pcSel_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_wbSel_o <= 'b0       ;
    else          exe_wbSel_o <= id_wbSel_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_aluSel_o <= 'b0        ;
    else          exe_aluSel_o <= id_aluSel_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_aSel_o <= 'b0      ;
    else          exe_aSel_o <= id_aSel_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_bSel_o <= 'b0      ;
    else          exe_bSel_o <= id_bSel_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_brSel_o <= 'b0       ;
    else          exe_brSel_o <= id_brSel_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_memW_o <= 'b0      ;
    else          exe_memW_o <= id_memW_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_ext_o <= 'b0     ;
    else          exe_ext_o <= id_ext_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_rd1_o <= 'b0     ;
    else          exe_rd1_o <= id_rd1_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_rd2_o <= 'b0     ;
    else          exe_rd2_o <= id_rd2_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_wr_o <= 'b0    ;
    else          exe_wr_o <= id_wr_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) exe_regWEn_o <= 'b0        ;
    else          exe_regWEn_o <= id_regWEn_i;
end

endmodule
