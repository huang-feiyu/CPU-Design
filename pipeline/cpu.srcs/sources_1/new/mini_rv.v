`timescale 1ns / 1ps

// CPU
module mini_rv(
    input         fpga_clk_i,
    input         rst_n_i
);

wire clk;

// signals IF generates:
wire        pc_en;

wire [31:0] if_pc  ;
wire [31:0] if_pc4 ;
wire [31:0] if_inst;

// singals ID gets from IF:
wire [31:0] id_pc  ;
wire [31:0] id_pc4 ;
wire [31:0] id_inst;

// signals ID generates:
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

wire [31:0] exe_rd1;
wire [31:0] exe_rd2;
wire [31:0] exe_ext;
wire exe_pcSel, exe_aSel, exe_bSel, exe_memW, exe_regWEn;
wire [1:0] exe_wbSel ;
wire [2:0] exe_brSel ;
wire [3:0] exe_aluSel;
wire [4:0] exe_wr    ;

// signals EXE generates:
wire [31:0] aluC  ;
wire        branch;

// signals MEM generates
wire [31:0] mem_rd;

// signals WB generates
wire [31:0] wd;

// instantiate in a specific order
cpuclk CPU_CLK (
    .clk_in1  (fpga_clk_i),
    .clk_out1 (clk       )
);

// IF
if_top CPU_IF (
    .clk_i    (clk    ),
    .rst_n_i  (rst_n_i),
    .aluC_i   (aluC   ),
    .branch_i (branch ),
    .en_i     (pc_en  ),

    .pc_o     (if_pc  ),
    .pc4_o    (if_pc4 )
);

inst_rom CPU_IROM (
    .pc_i   (if_pc  ),
    .inst_o (if_inst)
);

// IF/ID
if_id_reg CPU_IF_ID (
    .clk_i     (clk    ),
    .rst_n_i   (rst_n_i),

    .if_pc_i   (if_pc  ),
    .if_pc4_i  (if_pc4 ),
    .if_inst_i (if_inst),

    .id_pc_o   (id_pc  ),
    .id_pc4_o  (id_pc4 ),
    .id_inst_o (id_inst)
);

// ID
id_top CPU_ID (
    .clk_i    (clk       ),
    .rst_n_i  (rst_n_i   ),
    .inst_i   (id_inst   ),
    .wd_i     (wd        ),
    .wr_i     (exe_wr    ), // NOTE: temp
    .regWEn_i (exe_regWEn), // NOTE: temp
    .rd1_o    (id_rd1    ),
    .rd2_o    (id_rd2    ),
    .ext_o    (id_ext    ),
    .wr_o     (id_wr     ),
    .regWEn_o (id_regWEn ),
    .pcSel_o  (id_pcSel  ),
    .wbSel_o  (id_wbSel  ),
    .aluSel_o (id_aluSel ),
    .aSel_o   (id_aSel   ),
    .bSel_o   (id_bSel   ),
    .brSel_o  (id_brSel  ),
    .memW_o   (id_memW   )
);

// ID/EXE
id_exe_reg CPU_ID_EXE (
    .clk_i        (clk      ),
    .rst_n_i      (rst_n_i  ),

    .id_pc_i      (id_pc    ),
    .id_pc4_i     (id_pc4   ),
    .id_pcSel_i   (id_pcSel ),
    .id_wbSel_i   (id_wbSel ),
    .id_aluSel_i  (id_aluSel),
    .id_aSel_i    (id_aSel  ),
    .id_bSel_i    (id_bSel  ),
    .id_brSel_i   (id_brSel ),
    .id_memW_i    (id_memW  ),
    .id_ext_i     (id_ext   ),
    .id_rd1_i     (id_rd1   ),
    .id_rd2_i     (id_rd2   ),
    .id_wr_i      (id_wr    ),
    .id_regWEn_i  (id_regWEn),

    .exe_pc_o     (exe_pc    ),
    .exe_pc4_o    (exe_pc4   ),
    .exe_pcSel_o  (exe_pcSel ),
    .exe_wbSel_o  (exe_wbSel ),
    .exe_aluSel_o (exe_aluSel),
    .exe_aSel_o   (exe_aSel  ),
    .exe_bSel_o   (exe_bSel  ),
    .exe_brSel_o  (exe_brSel ),
    .exe_memW_o   (exe_memW  ),
    .exe_ext_o    (exe_ext   ),
    .exe_rd1_o    (exe_rd1   ),
    .exe_rd2_o    (exe_rd2   ),
    .exe_wr_o     (exe_wr    ),
    .exe_regWEn_o (exe_regWEn)
);

// EXE
exe_top CPU_EXE (
    .rd1_i    (exe_rd1   ),
    .rd2_i    (exe_rd2   ),
    .pc_i     (exe_pc    ),
    .ext_i    (exe_ext   ),
    .aSel_i   (exe_aSel  ),
    .bSel_i   (exe_bSel  ),
    .aluSel_i (exe_aluSel),
    .brSel_i  (exe_brSel ),
    .pcSel_i  (exe_pcSel ),
    .aluC_o   (aluC      ),
    .branch_o (branch    )
);

// MEM
data_ram CPU_DRAM (
    .clk_i    (clk     ),
    .aluC_i   (aluC    ),
    .memW_i   (exe_memW), // NOTE: temp
    .rd2_i    (exe_rd2 ), // NOTE: temp
    .mem_rd_o (mem_rd  )
);

// WB
wb_top CPU_WB (
    .wbSel_i  (exe_wbSel), // NOTE: temp
    .aluC_i   (aluC     ),
    .mem_rd_i (mem_rd   ),
    .pc4_i    (exe_pc4  ), // NOTE: temp
    .wd_o     (wd       )
);

endmodule
