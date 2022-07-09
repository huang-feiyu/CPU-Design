`timescale 1ns / 1ps

module id_top(
    input         clk_i   ,
    input         rst_n_i ,
    input  [31:0] inst_i  ,

    // WB
    input  [31:0] wd_i    ,
    input  [4 :0] wr_i    ,
    input         regWEn_i,

    output [4 :0] rs1_o   ,
    output [4 :0] rs2_o   ,
    output [31:0] rd1_o   ,
    output [31:0] rd2_o   ,
    output [31:0] ext_o   ,
    output [4 :0] wr_o    ,
    output        regWEn_o,

    output        pcSel_o ,
    output [1 :0] wbSel_o ,
    output [3 :0] aluSel_o,
    output        aSel_o  ,
    output        bSel_o  ,
    output [2 :0] brSel_o ,
    output        memW_o  ,

    output        is_inst
);

wire brUn, mem;
wire [2:0] immSel;

assign is_inst = inst_i[6:0] != 0;
assign wr_o  = inst_i[11:7 ];
assign rs1_o = inst_i[19:15];
assign rs2_o = inst_i[24:20];

reg_file U_RF (
    .clk_i    (clk_i   ),
    .rst_n_i  (rst_n_i ),
    .rs1_i    (rs1_o   ),
    .rs2_i    (rs2_o   ),
    .regWEn_i (regWEn_i),
    .wr_i     (wr_i    ),
    .wd_i     (wd_i    ),
    .rd1_o    (rd1_o   ),
    .rd2_o    (rd2_o   )
);

imm_gen U_SEXT (
    .immSel_i (immSel      ),
    .inst_i   (inst_i[31:7]),
    .ext_o    (ext_o       )
);

control U_CTRL (
    .inst_i   (inst_i  ),
    .pcSel_o  (pcSel_o ),
    .regWEn_o (regWEn_o),
    .wbSel_o  (wbSel_o ),
    .immSel_o (immSel  ),
    .aluSel_o (aluSel_o),
    .aSel_o   (aSel_o  ),
    .bSel_o   (bSel_o  ),
    .brUn_o   (brUn    ),
    .brSel_o  (brSel_o ),
    .mem_o    (mem     ),
    .memW_o   (memW_o  )
);

endmodule
