`include "param.v"

module hazard_detector(
    input         clk_i         ,
    input         rst_n_i       ,

    input         exe_branch_i  ,
    input  [4 :0] exe_rs1_i     ,
    input  [4 :0] exe_rs2_i     ,
    input  [31:0] exe_rd1_i     ,
    input  [31:0] exe_rd2_i     ,
    input  [4 :0] mem_wr_i      ,
    input  [4 :0] wb_wr_i       ,
    input         mem_regWEn_i  ,
    input         wb_regWEn_i   ,

    input  [1 :0] mem_wbSel_i   ,
    input  [31:0] mem_wd_i      ,
    input  [31:0] wb_wd_i       ,

    output reg [31:0] rs1_f_o   ,
    output reg [31:0] rs2_f_o   ,

    output reg    if_id_flush_o ,
    output reg    id_exe_flush_o,
    output reg    pc_stop_o     ,
    output reg    if_id_stop_o
);

wire rs1_exe_mem_hazard, rs2_exe_mem_hazard;
wire rs1_exe_wb_hazard , rs2_exe_wb_hazard , rs_exe_wb_hazard ;

// situation A: EXE & MEM hazard
assign rs1_exe_mem_hazard = (exe_rs1_i == mem_wr_i) && mem_regWEn_i && mem_wr_i != 0;
assign rs2_exe_mem_hazard = (exe_rs2_i == mem_wr_i) && mem_regWEn_i && mem_wr_i != 0;

// situation B: EXE & WB hazard
assign rs1_exe_wb_hazard = (exe_rs1_i == wb_wr_i) && wb_regWEn_i && wb_wr_i != 0;
assign rs2_exe_wb_hazard = (exe_rs2_i == wb_wr_i) && wb_regWEn_i && wb_wr_i != 0;

// rs1: forward data
always @(*) begin
    if (rs1_exe_mem_hazard)     rs1_f_o = mem_wd_i ;
    else if (rs1_exe_wb_hazard) rs1_f_o = wb_wd_i  ;
    else                        rs1_f_o = exe_rd1_i;
end

// rs2: forward data
always @(*) begin
    if (rs2_exe_mem_hazard)     rs2_f_o = mem_wd_i ;
    else if (rs2_exe_wb_hazard) rs2_f_o = wb_wd_i  ;
    else                        rs2_f_o = exe_rd2_i;
end

// must stop
wire load_exe_hazard;
assign load_exe_hazard = (rs1_exe_mem_hazard || rs2_exe_mem_hazard) && mem_wbSel_i == `WBSEL_MEM;

// pc_stop_o
always @(*) begin
    if (load_exe_hazard) pc_stop_o = 1;
    else                 pc_stop_o = 0;
end

// if_id_stop_o
always @(*) begin
    if (load_exe_hazard) if_id_stop_o = 1;
    else                 if_id_stop_o = 0;
end

// if_id_flush_o
always @(*) begin
    if (load_exe_hazard) if_id_flush_o = 1;
    else                 if_id_flush_o = 0;
end

// id_exe_flush_o
always @(*) begin
    if (load_exe_hazard)   id_exe_flush_o = 1;
    else if (exe_branch_i) id_exe_flush_o = 1;
    else                   id_exe_flush_o = 0;
end

endmodule
