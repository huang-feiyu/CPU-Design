`include "param.v"

module cpu(
    input         clk     ,
    input         rst_n_i ,

    input  [31:0] if_inst ,
    output [31:0] if_pc   ,

    input  [31:0] mem_rd  ,
    output [31:0] mem_aluC,
    output        mem_memW,
    output [31:0] mem_rd2 ,

    output        debug_wb_have_inst,
    output [31:0] debug_wb_pc       ,
    output        debug_wb_ena      ,
    output [4: 0] debug_wb_reg      ,
    output [31:0] debug_wb_value
);

assign debug_wb_have_inst = wb_is_inst;
assign debug_wb_pc        = wb_pc     ;
assign debug_wb_ena       = wb_regWEn ;
assign debug_wb_reg       = wb_wr     ;
assign debug_wb_value     = wb_wd     ;

/* BEGIN: ========== variable declaration ========== */

// signals IF generates:
wire [31:0] if_pc4;

// singals ID gets from IF:
wire [31:0] id_pc  ;
wire [31:0] id_pc4 ;
wire [31:0] id_inst;

// signals ID generates:
wire [4: 0] id_rs1;
wire [4: 0] id_rs2;
wire [31:0] id_rd1;
wire [31:0] id_rd2;
wire [31:0] id_ext;
wire id_pcSel, id_aSel, id_bSel, id_memW, id_regWEn;
wire [1:0] id_wbSel ;
wire [2:0] id_brSel ;
wire [3:0] id_aluSel;
wire [4:0] id_wr    ;

// signals EXE gets from ID:
wire [31:0] exe_pc ;
wire [31:0] exe_pc4;

wire [4: 0] exe_rs1;
wire [4: 0] exe_rs2;
wire [31:0] exe_rd1;
wire [31:0] exe_rd2;
wire [31:0] exe_ext;
wire exe_pcSel, exe_aSel, exe_bSel, exe_memW, exe_regWEn;
wire [1:0] exe_wbSel ;
wire [2:0] exe_brSel ;
wire [3:0] exe_aluSel;
wire [4:0] exe_wr    ;

// signals EXE generates:
wire [31:0] exe_aluC  ;
wire        exe_branch;

// signals MEM gets from EXE:
wire mem_regWEn, mem_branch;
wire [31:0] mem_pc   ;
wire [31:0] mem_pc4  ;
wire [1: 0] mem_wbSel;
wire [4: 0] mem_wr   ;

// signals MEM generates:

// signals WB gets from MEM:
wire wb_regWEn, wb_branch;
wire [31:0] wb_aluC ;
wire [31:0] wb_rd   ;
wire [31:0] wb_pc   ;
wire [31:0] wb_pc4  ;
wire [1: 0] wb_wbSel;
wire [4: 0] wb_wr   ;

// signals WB generates
wire [31:0] wb_wd;

// HAZARD signals
wire pc_stop    , if_id_stop  ;
wire if_id_flush, id_exe_flush;

// TRACE
wire id_is_inst, exe_is_inst, mem_is_inst, wb_is_inst;

// forward signals
wire [31:0] mem_wd;

wire [31:0] rs1_forward;
wire [31:0] rs2_forward;

/* END: ========== variable declaration ========== */


/* BEGIN: ========== instantiation ========== */
// instantiate in a specific order

// Hazard detection
hazard_detector CPU_HZD (
    .clk_i         (clk         ),
    .rst_n_i       (rst_n_i     ),

    .exe_branch_i  (exe_branch  ),
    .exe_rs1_i     (exe_rs1     ),
    .exe_rs2_i     (exe_rs2     ),
    .exe_rd1_i     (exe_rd1     ),
    .exe_rd2_i     (exe_rd2     ),
    .mem_wr_i      (mem_wr      ),
    .wb_wr_i       (wb_wr       ),
    .mem_regWEn_i  (mem_regWEn  ),
    .wb_regWEn_i   (wb_regWEn   ),

    .mem_wbSel_i   (mem_wbSel   ),
    .mem_wd_i      (mem_wd      ),
    .wb_wd_i       (wb_wd       ),

    .rs1_f_o       (rs1_forward ),
    .rs2_f_o       (rs2_forward ),

    .if_id_flush_o (if_id_flush ),
    .id_exe_flush_o(id_exe_flush),
    .pc_stop_o     (pc_stop     ),
    .if_id_stop_o  (if_id_stop  )
);

// IF
if_top CPU_IF (
    .clk_i    (clk       ),
    .rst_n_i  (rst_n_i   ),
    .aluC_i   (exe_aluC  ), // NOTE: after EXE, IMMEDIATELY use aluC & branch
    .branch_i (exe_branch),
    .stop_i   (pc_stop   ),

    .pc_o     (if_pc     ),
    .pc4_o    (if_pc4    )
);

// IF/ID
if_id_reg CPU_IF_ID (
    .clk_i     (clk        ),
    .rst_n_i   (rst_n_i    ),

    .flush_i   (if_id_flush),
    .stop_i    (if_id_stop ),

    .if_pc_i   (if_pc      ),
    .if_pc4_i  (if_pc4     ),
    .if_inst_i (if_inst    ),

    .id_pc_o   (id_pc      ),
    .id_pc4_o  (id_pc4     ),
    .id_inst_o (id_inst    )
);

// ID
id_top CPU_ID (
    .clk_i    (clk      ),
    .rst_n_i  (rst_n_i  ),
    .inst_i   (id_inst  ),
    .wd_i     (wb_wd    ),
    .wr_i     (wb_wr    ),
    .regWEn_i (wb_regWEn),
    .rs1_o    (id_rs1   ),
    .rs2_o    (id_rs2   ),
    .rd1_o    (id_rd1   ),
    .rd2_o    (id_rd2   ),
    .ext_o    (id_ext   ),
    .wr_o     (id_wr    ),
    .regWEn_o (id_regWEn),
    .pcSel_o  (id_pcSel ),
    .wbSel_o  (id_wbSel ),
    .aluSel_o (id_aluSel),
    .aSel_o   (id_aSel  ),
    .bSel_o   (id_bSel  ),
    .brSel_o  (id_brSel ),
    .memW_o   (id_memW  ),

    .is_inst  (id_is_inst)
);

// ID/EXE
id_exe_reg CPU_ID_EXE (
    .clk_i        (clk         ),
    .rst_n_i      (rst_n_i     ),

    .flush_i      (id_exe_flush),

    .id_pc_i      (id_pc       ),
    .id_pc4_i     (id_pc4      ),
    .id_pcSel_i   (id_pcSel    ),
    .id_wbSel_i   (id_wbSel    ),
    .id_aluSel_i  (id_aluSel   ),
    .id_aSel_i    (id_aSel     ),
    .id_bSel_i    (id_bSel     ),
    .id_brSel_i   (id_brSel    ),
    .id_memW_i    (id_memW     ),
    .id_ext_i     (id_ext      ),
    .id_rs1_i     (id_rs1      ),
    .id_rs2_i     (id_rs2      ),
    .id_rd1_i     (id_rd1      ),
    .id_rd2_i     (id_rd2      ),
    .id_wr_i      (id_wr       ),
    .id_regWEn_i  (id_regWEn   ),

    .exe_pc_o     (exe_pc      ),
    .exe_pc4_o    (exe_pc4     ),
    .exe_pcSel_o  (exe_pcSel   ),
    .exe_wbSel_o  (exe_wbSel   ),
    .exe_aluSel_o (exe_aluSel  ),
    .exe_aSel_o   (exe_aSel    ),
    .exe_bSel_o   (exe_bSel    ),
    .exe_brSel_o  (exe_brSel   ),
    .exe_memW_o   (exe_memW    ),
    .exe_ext_o    (exe_ext     ),
    .exe_rs1_o    (exe_rs1     ),
    .exe_rs2_o    (exe_rs2     ),
    .exe_rd1_o    (exe_rd1     ),
    .exe_rd2_o    (exe_rd2     ),
    .exe_wr_o     (exe_wr      ),
    .exe_regWEn_o (exe_regWEn  ),

    .id_is_inst   (id_is_inst  ),
    .exe_is_inst  (exe_is_inst )
);

// EXE
exe_top CPU_EXE (
    .rd1_i    (rs1_forward),
    .rd2_i    (rs2_forward),
    .pc_i     (exe_pc     ),
    .ext_i    (exe_ext    ),
    .aSel_i   (exe_aSel   ),
    .bSel_i   (exe_bSel   ),
    .aluSel_i (exe_aluSel ),
    .brSel_i  (exe_brSel  ),
    .pcSel_i  (exe_pcSel  ),
    .aluC_o   (exe_aluC   ),
    .branch_o (exe_branch )
);

// EXE/MEM
exe_mem_reg CPU_EXE_MEM (
    .clk_i        (clk        ),
    .rst_n_i      (rst_n_i    ),

    .exe_rd2_i    (rs2_forward),
    .exe_memW_i   (exe_memW   ),
    .exe_regWEn_i (exe_regWEn ),
    .exe_wbSel_i  (exe_wbSel  ),
    .exe_wr_i     (exe_wr     ),
    .exe_pc_i     (exe_pc     ),
    .exe_pc4_i    (exe_pc4    ),
    .exe_aluC_i   (exe_aluC   ),
    .exe_branch_i (exe_branch ),

    .mem_rd2_o    (mem_rd2    ),
    .mem_memW_o   (mem_memW   ),
    .mem_regWEn_o (mem_regWEn ),
    .mem_wbSel_o  (mem_wbSel  ),
    .mem_wr_o     (mem_wr     ),
    .mem_pc_o     (mem_pc     ),
    .mem_pc4_o    (mem_pc4    ),
    .mem_aluC_o   (mem_aluC   ),
    .mem_branch_o (mem_branch ),

    .exe_is_inst  (exe_is_inst),
    .mem_is_inst  (mem_is_inst)
);

// mem MUX
wb_top CPU_MEM_MUX (
    .wbSel_i  (mem_wbSel),
    .aluC_i   (mem_aluC ),
    .mem_rd_i (mem_rd   ),
    .pc4_i    (mem_pc4  ),
    .wd_o     (mem_wd   )
);

// MEM/WB
mem_wb_reg CPU_MEM_WB (
    .clk_i        (clk       ),
    .rst_n_i      (rst_n_i   ),

    .mem_branch_i (mem_branch),
    .mem_aluC_i   (mem_aluC  ),
    .mem_rd_i     (mem_rd    ),
    .mem_pc_i     (mem_pc    ),
    .mem_pc4_i    (mem_pc4   ),
    .mem_wbSel_i  (mem_wbSel ),
    .mem_regWEn_i (mem_regWEn),
    .mem_wr_i     (mem_wr    ),

    .wb_branch_o  (wb_branch ),
    .wb_aluC_o    (wb_aluC   ),
    .wb_rd_o      (wb_rd     ),
    .wb_pc4_o     (wb_pc4    ),
    .wb_pc_o      (wb_pc     ),
    .wb_wbSel_o   (wb_wbSel  ),
    .wb_regWEn_o  (wb_regWEn ),
    .wb_wr_o      (wb_wr     ),

    .mem_is_inst  (mem_is_inst),
    .wb_is_inst   (wb_is_inst )
);

// WB
wb_top CPU_WB (
    .wbSel_i  (wb_wbSel),
    .aluC_i   (wb_aluC ),
    .mem_rd_i (wb_rd   ),
    .pc4_i    (wb_pc4  ),
    .wd_o     (wb_wd   )
);

/* END: ========== instantiation ========== */

endmodule
