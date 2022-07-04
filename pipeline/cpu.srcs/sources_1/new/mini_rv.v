`timescale 1ns / 1ps

// CPU
module mini_rv(
    input         fpga_clk_i,
    input         rst_n_i   ,

    output [31:0] pc
);

wire clk;

// signals IF generates
wire        pc_en;
wire [31:0] pc4  ;
wire [31:0] npc  ;
wire [31:0] inst ;

// signals ID generates
wire [31:0] rd1;
wire [31:0] rd2;
wire [31:0] ext;

// signals EXE generates
wire [31:0] aluC  ;
wire        branch;

// signals MEM generates
wire [31:0] mem_rd;

// signals WB generates
wire [31:0] wd;

// control
wire pcSel, regWEn, aSel, bSel, brUn, mem, memW;
wire [1:0] wbSel ;
wire [2:0] immSel;
wire [2:0] brSel ;
wire [3:0] aluSel;

// instantiate in a specific order
cpuclk CPU_CLK (
    .clk_in1  (fpga_clk_i),
    .clk_out1 (clk       )
);

// IF
pc_reg CPU_PC (
    .clk_i   (clk    ),
    .rst_n_i (rst_n_i),
    .en      (pc_en  ),
    .npc_i   (npc    ),
    .pc_o    (pc     )
);

inst_rom CPU_IROM (
    .pc_i   (pc  ),
    .inst_o (inst)
);

next_pc CPU_NPC (
    .pc_i     (pc    ),
    .aluC_i   (aluC  ),
    .branch_i (branch),
    .npc_o    (npc   ),
    .pc4_o    (pc4   )
);

// ID
reg_file CPU_RF (
    .clk_i    (clk        ),
    .rst_n_i  (rst_n_i    ),
    .rs1_i    (inst[19:15]),
    .rs2_i    (inst[24:20]),
    .regWEn_i (regWEn     ),
    .wr_i     (inst[11:7 ]),
    .wd_i     (wd         ),
    .rd1_o    (rd1        ),
    .rd2_o    (rd2        )
);

imm_gen CPU_SEXT (
    .immSel_i (immSel    ),
    .inst_i   (inst[31:7]),
    .ext_o    (ext       )
);

// EXE
exe_top CPU_EXE (
    .rd1_i    (rd1   ),
    .rd2_i    (rd2   ),
    .pc_i     (pc    ),
    .ext_i    (ext   ),
    .aSel_i   (aSel  ),
    .bSel_i   (bSel  ),
    .aluSel_i (aluSel),
    .brSel_i  (brSel ),
    .pcSel_i  (pcSel ),
    .brUn_i   (brUn  ),
    .aluC_o   (aluC  ),
    .branch_o (branch)
);

// MEM
data_ram CPU_DRAM (
    .clk_i    (clk   ),
    .aluC_i   (aluC  ),
    .mem_i    (mem   ),
    .memW_i   (memW  ),
    .rd2_i    (rd2   ),
    .mem_rd_o (mem_rd)
);

// WB
wb_top CPU_WB (
    .wbSel_i  (wbSel ),
    .aluC_i   (aluC  ),
    .mem_rd_i (mem_rd),
    .pc4_i    (pc4   ),
    .wd_o     (wd    )
);

// control
control CPU_CTRL (
    .inst_i   (inst  ),
    .pcSel_o  (pcSel ),
    .regWEn_o (regWEn),
    .wbSel_o  (wbSel ),
    .immSel_o (immSel),
    .aluSel_o (aluSel),
    .aSel_o   (aSel  ),
    .bSel_o   (bSel  ),
    .brUn_o   (brUn  ),
    .brSel_o  (brSel ),
    .mem_o    (mem   ),
    .memW_o   (memW  )
);

endmodule
