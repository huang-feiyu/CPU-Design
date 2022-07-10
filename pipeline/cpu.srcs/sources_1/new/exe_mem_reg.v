`timescale 1ns / 1ps

module exe_mem_reg(
    input             clk_i       ,
    input             rst_n_i     ,

    input      [31:0] exe_rd2_i   ,
    input             exe_memW_i  ,
    input             exe_regWEn_i,
    input      [1 :0] exe_wbSel_i ,
    input      [4 :0] exe_wr_i    ,
    input      [31:0] exe_pc_i    ,
    input      [31:0] exe_pc4_i   ,
    input      [31:0] exe_aluC_i  ,
    input             exe_branch_i,

    output reg [31:0] mem_rd2_o   ,
    output reg        mem_memW_o  ,
    output reg        mem_regWEn_o,
    output reg [1 :0] mem_wbSel_o ,
    output reg [4 :0] mem_wr_o    ,
    output reg [31:0] mem_pc_o    ,
    output reg [31:0] mem_pc4_o   ,
    output reg [31:0] mem_aluC_o  ,
    output reg        mem_branch_o,

    input             exe_is_inst ,
    output reg        mem_is_inst
);

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) mem_is_inst <= 'b0      ;
    else          mem_is_inst <= exe_is_inst;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) mem_rd2_o <= 'b0      ;
    else          mem_rd2_o <= exe_rd2_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) mem_memW_o <= 'b0       ;
    else          mem_memW_o <= exe_memW_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) mem_regWEn_o <= 'b0         ;
    else          mem_regWEn_o <= exe_regWEn_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) mem_wbSel_o <= 'b0        ;
    else          mem_wbSel_o <= exe_wbSel_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) mem_wr_o <= 'b0     ;
    else          mem_wr_o <= exe_wr_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) mem_pc_o <= 'b0     ;
    else          mem_pc_o <= exe_pc_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) mem_pc4_o <= 'b0      ;
    else          mem_pc4_o <= exe_pc4_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) mem_aluC_o <= 'b0       ;
    else          mem_aluC_o <= exe_aluC_i;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) mem_branch_o <= 'b0         ;
    else          mem_branch_o <= exe_branch_i;
end

endmodule
