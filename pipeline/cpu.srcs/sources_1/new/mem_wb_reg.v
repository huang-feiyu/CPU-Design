`timescale 1ns / 1ps

module mem_wb_reg(
    input             clk_i       ,
    input             rst_n_i     ,

    input             mem_branch_i,
    input      [31:0] mem_aluC_i  ,
    input      [31:0] mem_rd_i    ,
    input      [31:0] mem_pc4_i   ,
    input      [1 :0] mem_wbSel_i ,
    input             mem_regWEn_i,
    input      [4 :0] mem_wr_i    ,

    output reg        wb_branch_o ,
    output reg [31:0] wb_aluC_o   ,
    output reg [31:0] wb_rd_o     ,
    output reg [31:0] wb_pc4_o    ,
    output reg [1 :0] wb_wbSel_o  ,
    output reg        wb_regWEn_o ,
    output reg [4 :0] wb_wr_o
);

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) wb_branch_o <= 'b0         ;
    else          wb_branch_o <= mem_branch_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) wb_aluC_o <= 'b0       ;
    else          wb_aluC_o <= mem_aluC_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) wb_rd_o <= 'b0     ;
    else          wb_rd_o <= mem_rd_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) wb_pc4_o <= 'b0      ;
    else          wb_pc4_o <= mem_pc4_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) wb_wbSel_o <= 'b0        ;
    else          wb_wbSel_o <= mem_wbSel_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) wb_regWEn_o <= 'b0         ;
    else          wb_regWEn_o <= mem_regWEn_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) wb_wr_o <= 'b0     ;
    else          wb_wr_o <= mem_wr_i;
end

endmodule
