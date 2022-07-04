// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Mon Jun 27 22:20:00 2022
// Host        : PC-Huang running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               P:/Project/iverilog/Exp/cpu/cpu.srcs/sources_1/ip/prgrom/prgrom_sim_netlist.v
// Design      : prgrom
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "prgrom,dist_mem_gen_v8_0_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module prgrom
   (a,
    spo);
  input [13:0]a;
  output [31:0]spo;

  wire [13:0]a;
  wire [31:0]spo;
  wire [31:0]NLW_U0_dpo_UNCONNECTED;
  wire [31:0]NLW_U0_qdpo_UNCONNECTED;
  wire [31:0]NLW_U0_qspo_UNCONNECTED;

  (* C_FAMILY = "artix7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* c_addr_width = "14" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "16384" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "prgrom.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "32" *) 
  prgrom_dist_mem_gen_v8_0_12 U0
       (.a(a),
        .clk(1'b0),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[31:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[31:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[31:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(spo),
        .we(1'b0));
endmodule

(* C_ADDR_WIDTH = "14" *) (* C_DEFAULT_DATA = "0" *) (* C_DEPTH = "16384" *) 
(* C_ELABORATION_DIR = "./" *) (* C_FAMILY = "artix7" *) (* C_HAS_CLK = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_DPO = "0" *) (* C_HAS_DPRA = "0" *) 
(* C_HAS_I_CE = "0" *) (* C_HAS_QDPO = "0" *) (* C_HAS_QDPO_CE = "0" *) 
(* C_HAS_QDPO_CLK = "0" *) (* C_HAS_QDPO_RST = "0" *) (* C_HAS_QDPO_SRST = "0" *) 
(* C_HAS_QSPO = "0" *) (* C_HAS_QSPO_CE = "0" *) (* C_HAS_QSPO_RST = "0" *) 
(* C_HAS_QSPO_SRST = "0" *) (* C_HAS_SPO = "1" *) (* C_HAS_WE = "0" *) 
(* C_MEM_INIT_FILE = "prgrom.mif" *) (* C_MEM_TYPE = "0" *) (* C_PARSER_TYPE = "1" *) 
(* C_PIPELINE_STAGES = "0" *) (* C_QCE_JOINED = "0" *) (* C_QUALIFY_WE = "0" *) 
(* C_READ_MIF = "1" *) (* C_REG_A_D_INPUTS = "0" *) (* C_REG_DPRA_INPUT = "0" *) 
(* C_SYNC_ENABLE = "1" *) (* C_WIDTH = "32" *) (* ORIG_REF_NAME = "dist_mem_gen_v8_0_12" *) 
module prgrom_dist_mem_gen_v8_0_12
   (a,
    d,
    dpra,
    clk,
    we,
    i_ce,
    qspo_ce,
    qdpo_ce,
    qdpo_clk,
    qspo_rst,
    qdpo_rst,
    qspo_srst,
    qdpo_srst,
    spo,
    dpo,
    qspo,
    qdpo);
  input [13:0]a;
  input [31:0]d;
  input [13:0]dpra;
  input clk;
  input we;
  input i_ce;
  input qspo_ce;
  input qdpo_ce;
  input qdpo_clk;
  input qspo_rst;
  input qdpo_rst;
  input qspo_srst;
  input qdpo_srst;
  output [31:0]spo;
  output [31:0]dpo;
  output [31:0]qspo;
  output [31:0]qdpo;

  wire \<const0> ;
  wire [13:0]a;
  wire [31:1]\^spo ;

  assign dpo[31] = \<const0> ;
  assign dpo[30] = \<const0> ;
  assign dpo[29] = \<const0> ;
  assign dpo[28] = \<const0> ;
  assign dpo[27] = \<const0> ;
  assign dpo[26] = \<const0> ;
  assign dpo[25] = \<const0> ;
  assign dpo[24] = \<const0> ;
  assign dpo[23] = \<const0> ;
  assign dpo[22] = \<const0> ;
  assign dpo[21] = \<const0> ;
  assign dpo[20] = \<const0> ;
  assign dpo[19] = \<const0> ;
  assign dpo[18] = \<const0> ;
  assign dpo[17] = \<const0> ;
  assign dpo[16] = \<const0> ;
  assign dpo[15] = \<const0> ;
  assign dpo[14] = \<const0> ;
  assign dpo[13] = \<const0> ;
  assign dpo[12] = \<const0> ;
  assign dpo[11] = \<const0> ;
  assign dpo[10] = \<const0> ;
  assign dpo[9] = \<const0> ;
  assign dpo[8] = \<const0> ;
  assign dpo[7] = \<const0> ;
  assign dpo[6] = \<const0> ;
  assign dpo[5] = \<const0> ;
  assign dpo[4] = \<const0> ;
  assign dpo[3] = \<const0> ;
  assign dpo[2] = \<const0> ;
  assign dpo[1] = \<const0> ;
  assign dpo[0] = \<const0> ;
  assign qdpo[31] = \<const0> ;
  assign qdpo[30] = \<const0> ;
  assign qdpo[29] = \<const0> ;
  assign qdpo[28] = \<const0> ;
  assign qdpo[27] = \<const0> ;
  assign qdpo[26] = \<const0> ;
  assign qdpo[25] = \<const0> ;
  assign qdpo[24] = \<const0> ;
  assign qdpo[23] = \<const0> ;
  assign qdpo[22] = \<const0> ;
  assign qdpo[21] = \<const0> ;
  assign qdpo[20] = \<const0> ;
  assign qdpo[19] = \<const0> ;
  assign qdpo[18] = \<const0> ;
  assign qdpo[17] = \<const0> ;
  assign qdpo[16] = \<const0> ;
  assign qdpo[15] = \<const0> ;
  assign qdpo[14] = \<const0> ;
  assign qdpo[13] = \<const0> ;
  assign qdpo[12] = \<const0> ;
  assign qdpo[11] = \<const0> ;
  assign qdpo[10] = \<const0> ;
  assign qdpo[9] = \<const0> ;
  assign qdpo[8] = \<const0> ;
  assign qdpo[7] = \<const0> ;
  assign qdpo[6] = \<const0> ;
  assign qdpo[5] = \<const0> ;
  assign qdpo[4] = \<const0> ;
  assign qdpo[3] = \<const0> ;
  assign qdpo[2] = \<const0> ;
  assign qdpo[1] = \<const0> ;
  assign qdpo[0] = \<const0> ;
  assign qspo[31] = \<const0> ;
  assign qspo[30] = \<const0> ;
  assign qspo[29] = \<const0> ;
  assign qspo[28] = \<const0> ;
  assign qspo[27] = \<const0> ;
  assign qspo[26] = \<const0> ;
  assign qspo[25] = \<const0> ;
  assign qspo[24] = \<const0> ;
  assign qspo[23] = \<const0> ;
  assign qspo[22] = \<const0> ;
  assign qspo[21] = \<const0> ;
  assign qspo[20] = \<const0> ;
  assign qspo[19] = \<const0> ;
  assign qspo[18] = \<const0> ;
  assign qspo[17] = \<const0> ;
  assign qspo[16] = \<const0> ;
  assign qspo[15] = \<const0> ;
  assign qspo[14] = \<const0> ;
  assign qspo[13] = \<const0> ;
  assign qspo[12] = \<const0> ;
  assign qspo[11] = \<const0> ;
  assign qspo[10] = \<const0> ;
  assign qspo[9] = \<const0> ;
  assign qspo[8] = \<const0> ;
  assign qspo[7] = \<const0> ;
  assign qspo[6] = \<const0> ;
  assign qspo[5] = \<const0> ;
  assign qspo[4] = \<const0> ;
  assign qspo[3] = \<const0> ;
  assign qspo[2] = \<const0> ;
  assign qspo[1] = \<const0> ;
  assign qspo[0] = \<const0> ;
  assign spo[31:29] = \^spo [31:29];
  assign spo[28] = \^spo [29];
  assign spo[27:1] = \^spo [27:1];
  assign spo[0] = \^spo [1];
  GND GND
       (.G(\<const0> ));
  prgrom_dist_mem_gen_v8_0_12_synth \synth_options.dist_mem_inst 
       (.a(a),
        .spo({\^spo [31:29],\^spo [27:1]}));
endmodule

(* ORIG_REF_NAME = "dist_mem_gen_v8_0_12_synth" *) 
module prgrom_dist_mem_gen_v8_0_12_synth
   (spo,
    a);
  output [29:0]spo;
  input [13:0]a;

  wire [13:0]a;
  wire [29:0]spo;

  prgrom_rom \gen_rom.rom_inst 
       (.a(a),
        .spo(spo));
endmodule

(* ORIG_REF_NAME = "rom" *) 
module prgrom_rom
   (spo,
    a);
  output [29:0]spo;
  input [13:0]a;

  wire [13:0]a;
  wire [29:0]spo;
  wire \spo[0]_INST_0_i_1_n_0 ;
  wire \spo[10]_INST_0_i_1_n_0 ;
  wire \spo[11]_INST_0_i_1_n_0 ;
  wire \spo[12]_INST_0_i_1_n_0 ;
  wire \spo[13]_INST_0_i_1_n_0 ;
  wire \spo[13]_INST_0_i_2_n_0 ;
  wire \spo[13]_INST_0_i_3_n_0 ;
  wire \spo[13]_INST_0_i_4_n_0 ;
  wire \spo[14]_INST_0_i_1_n_0 ;
  wire \spo[15]_INST_0_i_1_n_0 ;
  wire \spo[16]_INST_0_i_1_n_0 ;
  wire \spo[17]_INST_0_i_1_n_0 ;
  wire \spo[18]_INST_0_i_1_n_0 ;
  wire \spo[19]_INST_0_i_1_n_0 ;
  wire \spo[19]_INST_0_i_2_n_0 ;
  wire \spo[20]_INST_0_i_1_n_0 ;
  wire \spo[21]_INST_0_i_1_n_0 ;
  wire \spo[22]_INST_0_i_1_n_0 ;
  wire \spo[23]_INST_0_i_1_n_0 ;
  wire \spo[24]_INST_0_i_1_n_0 ;
  wire \spo[25]_INST_0_i_1_n_0 ;
  wire \spo[26]_INST_0_i_1_n_0 ;
  wire \spo[27]_INST_0_i_1_n_0 ;
  wire \spo[2]_INST_0_i_1_n_0 ;
  wire \spo[31]_INST_0_i_1_n_0 ;
  wire \spo[31]_INST_0_i_2_n_0 ;
  wire \spo[31]_INST_0_i_3_n_0 ;
  wire \spo[31]_INST_0_i_4_n_0 ;
  wire \spo[31]_INST_0_i_5_n_0 ;
  wire \spo[3]_INST_0_i_1_n_0 ;
  wire \spo[3]_INST_0_i_2_n_0 ;
  wire \spo[4]_INST_0_i_1_n_0 ;
  wire \spo[5]_INST_0_i_1_n_0 ;
  wire \spo[6]_INST_0_i_1_n_0 ;
  wire \spo[7]_INST_0_i_1_n_0 ;
  wire \spo[8]_INST_0_i_1_n_0 ;
  wire \spo[9]_INST_0_i_1_n_0 ;

  LUT6 #(
    .INIT(64'h1010101010101030)) 
    \spo[0]_INST_0 
       (.I0(a[6]),
        .I1(\spo[31]_INST_0_i_3_n_0 ),
        .I2(\spo[31]_INST_0_i_4_n_0 ),
        .I3(a[1]),
        .I4(a[4]),
        .I5(\spo[0]_INST_0_i_1_n_0 ),
        .O(spo[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spo[0]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[0]),
        .I3(a[5]),
        .O(\spo[0]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \spo[10]_INST_0 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[10]_INST_0_i_1_n_0 ),
        .O(spo[9]));
  LUT6 #(
    .INIT(64'hCAEED3EFFF301121)) 
    \spo[10]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[2]),
        .I2(a[1]),
        .I3(a[5]),
        .I4(a[0]),
        .I5(a[4]),
        .O(\spo[10]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \spo[11]_INST_0 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[11]_INST_0_i_1_n_0 ),
        .O(spo[10]));
  LUT6 #(
    .INIT(64'hFEF737EFFEFF3FFA)) 
    \spo[11]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[4]),
        .I2(a[3]),
        .I3(a[0]),
        .I4(a[5]),
        .I5(a[1]),
        .O(\spo[11]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00500030)) 
    \spo[12]_INST_0 
       (.I0(\spo[31]_INST_0_i_5_n_0 ),
        .I1(\spo[12]_INST_0_i_1_n_0 ),
        .I2(\spo[31]_INST_0_i_4_n_0 ),
        .I3(\spo[31]_INST_0_i_3_n_0 ),
        .I4(a[6]),
        .O(spo[11]));
  LUT6 #(
    .INIT(64'hFFDCF7ACD7FEDBAF)) 
    \spo[12]_INST_0_i_1 
       (.I0(a[5]),
        .I1(a[0]),
        .I2(a[1]),
        .I3(a[4]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[12]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h03FF03AB00000000)) 
    \spo[13]_INST_0 
       (.I0(\spo[19]_INST_0_i_2_n_0 ),
        .I1(\spo[13]_INST_0_i_1_n_0 ),
        .I2(\spo[13]_INST_0_i_2_n_0 ),
        .I3(\spo[13]_INST_0_i_3_n_0 ),
        .I4(\spo[13]_INST_0_i_4_n_0 ),
        .I5(\spo[31]_INST_0_i_4_n_0 ),
        .O(spo[12]));
  LUT6 #(
    .INIT(64'hFFFFFEFEFFDFCFFB)) 
    \spo[13]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[6]),
        .I2(a[5]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[2]),
        .O(\spo[13]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spo[13]_INST_0_i_2 
       (.I0(a[0]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .O(\spo[13]_INST_0_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spo[13]_INST_0_i_3 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .O(\spo[13]_INST_0_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0010)) 
    \spo[13]_INST_0_i_4 
       (.I0(a[2]),
        .I1(a[4]),
        .I2(a[1]),
        .I3(a[5]),
        .O(\spo[13]_INST_0_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00500030)) 
    \spo[14]_INST_0 
       (.I0(\spo[31]_INST_0_i_5_n_0 ),
        .I1(\spo[14]_INST_0_i_1_n_0 ),
        .I2(\spo[31]_INST_0_i_4_n_0 ),
        .I3(\spo[31]_INST_0_i_3_n_0 ),
        .I4(a[6]),
        .O(spo[13]));
  LUT6 #(
    .INIT(64'hBFEFFFEBCECC3FC9)) 
    \spo[14]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[4]),
        .I2(a[1]),
        .I3(a[5]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[14]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00500030)) 
    \spo[15]_INST_0 
       (.I0(\spo[31]_INST_0_i_5_n_0 ),
        .I1(\spo[15]_INST_0_i_1_n_0 ),
        .I2(\spo[31]_INST_0_i_4_n_0 ),
        .I3(\spo[31]_INST_0_i_3_n_0 ),
        .I4(a[6]),
        .O(spo[14]));
  LUT6 #(
    .INIT(64'h1BDBD877DBDB59E7)) 
    \spo[15]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[5]),
        .I2(a[4]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[15]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00500030)) 
    \spo[16]_INST_0 
       (.I0(\spo[31]_INST_0_i_5_n_0 ),
        .I1(\spo[16]_INST_0_i_1_n_0 ),
        .I2(\spo[31]_INST_0_i_4_n_0 ),
        .I3(\spo[31]_INST_0_i_3_n_0 ),
        .I4(a[6]),
        .O(spo[15]));
  LUT6 #(
    .INIT(64'h25F071F5FFDFFF77)) 
    \spo[16]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[1]),
        .I2(a[0]),
        .I3(a[4]),
        .I4(a[3]),
        .I5(a[5]),
        .O(\spo[16]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00500030)) 
    \spo[17]_INST_0 
       (.I0(\spo[31]_INST_0_i_5_n_0 ),
        .I1(\spo[17]_INST_0_i_1_n_0 ),
        .I2(\spo[31]_INST_0_i_4_n_0 ),
        .I3(\spo[31]_INST_0_i_3_n_0 ),
        .I4(a[6]),
        .O(spo[16]));
  LUT6 #(
    .INIT(64'h8F97CF5EDDBFCFBF)) 
    \spo[17]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[4]),
        .O(\spo[17]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00500030)) 
    \spo[18]_INST_0 
       (.I0(\spo[31]_INST_0_i_5_n_0 ),
        .I1(\spo[18]_INST_0_i_1_n_0 ),
        .I2(\spo[31]_INST_0_i_4_n_0 ),
        .I3(\spo[31]_INST_0_i_3_n_0 ),
        .I4(a[6]),
        .O(spo[17]));
  LUT6 #(
    .INIT(64'hE700FC55AFFF0301)) 
    \spo[18]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[5]),
        .I4(a[4]),
        .I5(a[0]),
        .O(\spo[18]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000044000000F400)) 
    \spo[19]_INST_0 
       (.I0(a[0]),
        .I1(\spo[19]_INST_0_i_1_n_0 ),
        .I2(\spo[19]_INST_0_i_2_n_0 ),
        .I3(\spo[31]_INST_0_i_4_n_0 ),
        .I4(\spo[31]_INST_0_i_3_n_0 ),
        .I5(a[6]),
        .O(spo[18]));
  LUT6 #(
    .INIT(64'h0F00000000000010)) 
    \spo[19]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[6]),
        .I3(a[5]),
        .I4(a[4]),
        .I5(a[1]),
        .O(\spo[19]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \spo[19]_INST_0_i_2 
       (.I0(a[1]),
        .I1(a[5]),
        .I2(a[4]),
        .I3(a[2]),
        .I4(a[3]),
        .O(\spo[19]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00500030)) 
    \spo[20]_INST_0 
       (.I0(\spo[31]_INST_0_i_5_n_0 ),
        .I1(\spo[20]_INST_0_i_1_n_0 ),
        .I2(\spo[31]_INST_0_i_4_n_0 ),
        .I3(\spo[31]_INST_0_i_3_n_0 ),
        .I4(a[6]),
        .O(spo[19]));
  LUT6 #(
    .INIT(64'hE15101B9F2FBF219)) 
    \spo[20]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[4]),
        .O(\spo[20]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \spo[21]_INST_0 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[21]_INST_0_i_1_n_0 ),
        .O(spo[20]));
  LUT6 #(
    .INIT(64'hFF6EFFEE7FCDFF89)) 
    \spo[21]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[0]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[21]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00500030)) 
    \spo[22]_INST_0 
       (.I0(\spo[31]_INST_0_i_5_n_0 ),
        .I1(\spo[22]_INST_0_i_1_n_0 ),
        .I2(\spo[31]_INST_0_i_4_n_0 ),
        .I3(\spo[31]_INST_0_i_3_n_0 ),
        .I4(a[6]),
        .O(spo[21]));
  LUT6 #(
    .INIT(64'hB033F3F80C090C09)) 
    \spo[22]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[4]),
        .O(\spo[22]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \spo[23]_INST_0 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[23]_INST_0_i_1_n_0 ),
        .O(spo[22]));
  LUT6 #(
    .INIT(64'hDF5E6F00FE7FBF31)) 
    \spo[23]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[5]),
        .I3(a[4]),
        .I4(a[0]),
        .I5(a[3]),
        .O(\spo[23]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \spo[24]_INST_0 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[24]_INST_0_i_1_n_0 ),
        .O(spo[23]));
  LUT6 #(
    .INIT(64'hFF7C7FADFF7CFFFD)) 
    \spo[24]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[4]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[24]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \spo[25]_INST_0 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[25]_INST_0_i_1_n_0 ),
        .O(spo[24]));
  LUT6 #(
    .INIT(64'h9EFF37CCBCFF27DD)) 
    \spo[25]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[4]),
        .I2(a[3]),
        .I3(a[0]),
        .I4(a[5]),
        .I5(a[1]),
        .O(\spo[25]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \spo[26]_INST_0 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[26]_INST_0_i_1_n_0 ),
        .O(spo[25]));
  LUT6 #(
    .INIT(64'hDFFFDFFF9FF01FD3)) 
    \spo[26]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[2]),
        .I2(a[0]),
        .I3(a[5]),
        .I4(a[1]),
        .I5(a[4]),
        .O(\spo[26]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \spo[27]_INST_0 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[27]_INST_0_i_1_n_0 ),
        .O(spo[26]));
  LUT6 #(
    .INIT(64'hF7FFF7FFEDEDFD7F)) 
    \spo[27]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[4]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[27]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000F0000004400)) 
    \spo[28]_INST_0 
       (.I0(\spo[31]_INST_0_i_1_n_0 ),
        .I1(\spo[31]_INST_0_i_2_n_0 ),
        .I2(\spo[31]_INST_0_i_5_n_0 ),
        .I3(\spo[31]_INST_0_i_4_n_0 ),
        .I4(\spo[31]_INST_0_i_3_n_0 ),
        .I5(a[6]),
        .O(spo[27]));
  LUT5 #(
    .INIT(32'h00004F00)) 
    \spo[2]_INST_0 
       (.I0(a[6]),
        .I1(\spo[2]_INST_0_i_1_n_0 ),
        .I2(\spo[31]_INST_0_i_5_n_0 ),
        .I3(\spo[31]_INST_0_i_4_n_0 ),
        .I4(\spo[31]_INST_0_i_3_n_0 ),
        .O(spo[1]));
  LUT6 #(
    .INIT(64'h4040C04040004000)) 
    \spo[2]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[3]),
        .O(\spo[2]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h003000A0)) 
    \spo[30]_INST_0 
       (.I0(\spo[31]_INST_0_i_2_n_0 ),
        .I1(\spo[31]_INST_0_i_5_n_0 ),
        .I2(\spo[31]_INST_0_i_4_n_0 ),
        .I3(\spo[31]_INST_0_i_3_n_0 ),
        .I4(a[6]),
        .O(spo[28]));
  LUT6 #(
    .INIT(64'h0004000000FF0000)) 
    \spo[31]_INST_0 
       (.I0(\spo[31]_INST_0_i_1_n_0 ),
        .I1(\spo[31]_INST_0_i_2_n_0 ),
        .I2(a[6]),
        .I3(\spo[31]_INST_0_i_3_n_0 ),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[31]_INST_0_i_5_n_0 ),
        .O(spo[29]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hCC4CCCCC)) 
    \spo[31]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .O(\spo[31]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000F800000008000)) 
    \spo[31]_INST_0_i_2 
       (.I0(a[5]),
        .I1(a[3]),
        .I2(a[4]),
        .I3(a[0]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[31]_INST_0_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \spo[31]_INST_0_i_3 
       (.I0(a[7]),
        .I1(a[8]),
        .I2(a[9]),
        .O(\spo[31]_INST_0_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \spo[31]_INST_0_i_4 
       (.I0(a[12]),
        .I1(a[13]),
        .I2(a[10]),
        .I3(a[11]),
        .O(\spo[31]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spo[31]_INST_0_i_5 
       (.I0(a[1]),
        .I1(a[4]),
        .I2(a[5]),
        .I3(a[0]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[31]_INST_0_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h0000F100)) 
    \spo[3]_INST_0 
       (.I0(a[4]),
        .I1(\spo[3]_INST_0_i_1_n_0 ),
        .I2(\spo[3]_INST_0_i_2_n_0 ),
        .I3(\spo[31]_INST_0_i_4_n_0 ),
        .I4(\spo[31]_INST_0_i_3_n_0 ),
        .O(spo[2]));
  LUT6 #(
    .INIT(64'hCFFFCFFFCFFFFFFB)) 
    \spo[3]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[6]),
        .I2(a[0]),
        .I3(a[5]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[3]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0400000000000000)) 
    \spo[3]_INST_0_i_2 
       (.I0(a[6]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[0]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[3]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \spo[4]_INST_0 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[4]_INST_0_i_1_n_0 ),
        .O(spo[3]));
  LUT6 #(
    .INIT(64'hEF8067006E80C400)) 
    \spo[4]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[0]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[4]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000040C)) 
    \spo[5]_INST_0 
       (.I0(\spo[31]_INST_0_i_5_n_0 ),
        .I1(\spo[31]_INST_0_i_4_n_0 ),
        .I2(\spo[31]_INST_0_i_3_n_0 ),
        .I3(a[6]),
        .I4(\spo[5]_INST_0_i_1_n_0 ),
        .O(spo[4]));
  LUT6 #(
    .INIT(64'hA5DB0F3E0003BFBE)) 
    \spo[5]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[5]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00500030)) 
    \spo[6]_INST_0 
       (.I0(\spo[31]_INST_0_i_5_n_0 ),
        .I1(\spo[6]_INST_0_i_1_n_0 ),
        .I2(\spo[31]_INST_0_i_4_n_0 ),
        .I3(\spo[31]_INST_0_i_3_n_0 ),
        .I4(a[6]),
        .O(spo[5]));
  LUT6 #(
    .INIT(64'hA8570A13DFFFFFFF)) 
    \spo[6]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[5]),
        .I4(a[1]),
        .I5(a[0]),
        .O(\spo[6]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000040C)) 
    \spo[7]_INST_0 
       (.I0(\spo[31]_INST_0_i_5_n_0 ),
        .I1(\spo[31]_INST_0_i_4_n_0 ),
        .I2(\spo[31]_INST_0_i_3_n_0 ),
        .I3(a[6]),
        .I4(\spo[7]_INST_0_i_1_n_0 ),
        .O(spo[6]));
  LUT6 #(
    .INIT(64'h7EA953AB56CC56EE)) 
    \spo[7]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[5]),
        .I4(a[1]),
        .I5(a[4]),
        .O(\spo[7]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \spo[8]_INST_0 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[8]_INST_0_i_1_n_0 ),
        .O(spo[7]));
  LUT6 #(
    .INIT(64'hC7ABACABFFC3FFEE)) 
    \spo[8]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[4]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[8]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \spo[9]_INST_0 
       (.I0(a[6]),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(\spo[31]_INST_0_i_4_n_0 ),
        .I5(\spo[9]_INST_0_i_1_n_0 ),
        .O(spo[8]));
  LUT6 #(
    .INIT(64'h2289AA0CAFB1ABF5)) 
    \spo[9]_INST_0_i_1 
       (.I0(a[5]),
        .I1(a[0]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[4]),
        .O(\spo[9]_INST_0_i_1_n_0 ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
