`timescale 1ns / 1ps

module hazard_detector(
    input         clk_i         ,
    input         rst_n_i       ,

    input         exe_branch_i  ,
    input         id_re1_i      ,
    input         id_re2_i      ,
    input  [4 :0] id_rs1_i      ,
    input  [4 :0] id_rs2_i      ,
    input  [4 :0] exe_wr_i      ,
    input  [4 :0] mem_wr_i      ,
    input  [4 :0] wb_wr_i       ,
    input         exe_regWEn_i  ,
    input         mem_regWEn_i  ,
    input         wb_regWEn_i   ,

    output        if_id_flush_o ,
    output        id_exe_flush_o,
    output reg    pc_stop_o     ,
    output reg    if_id_stop_o  ,
    output reg    id_exe_stop_o
);

wire rs1_id_exe_hazard, rs2_id_exe_hazard, rs_id_exe_hazard;
wire rs1_id_mem_hazard, rs2_id_mem_hazard, rs_id_mem_hazard;
wire rs1_id_wb_hazard , rs2_id_wb_hazard , rs_id_wb_hazard ;

reg [1:0] stop_cycle;

// situation A: ID & EXE hazard
assign rs1_id_exe_hazard = (exe_wr_i == id_rs1_i) && exe_regWEn_i && id_re1_i && exe_wr_i != 0;
assign rs2_id_exe_hazard = (exe_wr_i == id_rs2_i) && exe_regWEn_i && id_re2_i && exe_wr_i != 0;
assign rs_id_exe_hazard  = rs1_id_exe_hazard || rs2_id_exe_hazard;

// situation B: ID & MEM hazard
assign rs1_id_mem_hazard = (mem_wr_i == id_rs1_i) && mem_regWEn_i && id_re1_i && mem_wr_i != 0;
assign rs2_id_mem_hazard = (mem_wr_i == id_rs2_i) && mem_regWEn_i && id_re2_i && mem_wr_i != 0;
assign rs_id_mem_hazard  = rs1_id_mem_hazard || rs2_id_mem_hazard;

// situation C: ID & WB hazard
assign rs1_id_wb_hazard = (wb_wr_i == id_rs1_i) && wb_regWEn_i && id_re1_i && wb_wr_i != 0;
assign rs2_id_wb_hazard = (wb_wr_i == id_rs2_i) && wb_regWEn_i && id_re2_i && wb_wr_i != 0;
assign rs_id_wb_hazard  = rs1_id_wb_hazard || rs2_id_wb_hazard;

// stop_cycle: init
always @(posedge rs_id_mem_hazard or posedge rs_id_exe_hazard or posedge rs_id_wb_hazard) begin
    if (rs_id_wb_hazard )      stop_cycle = 1;
    else if (rs_id_mem_hazard) stop_cycle = 2;
    else if (rs_id_exe_hazard) stop_cycle = 3;
    else                       stop_cycle = 0;
end

// stop_cycle: --
always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i)        stop_cycle = 0             ;
    else if (stop_cycle) stop_cycle = stop_cycle - 1;
    else                 stop_cycle = stop_cycle    ;
end

// pc_stop_o
always @(*) begin
    if (~rst_n_i)        pc_stop_o = 1'b0;
    else if (stop_cycle) pc_stop_o = 1'b1;
    else                 pc_stop_o = 1'b0;
end

// if_id_stop_o
always @(*) begin
    if (~rst_n_i)        if_id_stop_o = 1'b0;
    else if (stop_cycle) if_id_stop_o = 1'b1;
    else                 if_id_stop_o = 1'b0;
end

// id_exe_stop_o
always @(*) begin
    if (~rst_n_i)        id_exe_stop_o = 1'b0;
    else if (stop_cycle) id_exe_stop_o = 1'b1;
    else                 id_exe_stop_o = 1'b0;
end

assign if_id_flush_o  = exe_branch_i;
assign id_exe_flush_o = exe_branch_i;

endmodule
