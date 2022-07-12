// file: param.v
`ifndef CPU_PARAM
`define CPU_PARAM

    // re1: determine whether to read rs1
    `define RE1_NON    'b0
    `define RE1_EN     'b1

    // re2: determine whether to read rs2
    `define RE2_NON    'b0
    `define RE2_EN     'b1

    // PCSel: determine to use Imm or PC+4
    `define PCSEL_PC4  'b0
    `define PCSEL_IMM  'b1

    // RegWEn: determine whether to write to `rd` register
    `define REGWEN_NON 'b0
    `define REGWEN_EN  'b1

    // WBSel: determine to write and which to write, ALU.C or Mem or PC4
    `define WBSEL_NON  'b00
    `define WBSEL_ALU  'b01
    `define WBSEL_MEM  'b10
    `define WBSEL_PC4  'b11

    // ImmSel: determine which type the instruction is
    `define IMMSEL_R   'b000
    `define IMMSEL_I   'b001
    `define IMMSEL_IS  'b110
    `define IMMSEL_S   'b010
    `define IMMSEL_SB  'b011
    `define IMMSEL_U   'b100
    `define IMMSEL_UJ  'b101

    // ALUSel: determine the ALU operation
    `define ALUSEL_ADD 'b0000
    `define ALUSEL_SUB 'b0001
    `define ALUSEL_AND 'b0010
    `define ALUSEL_OR  'b0011
    `define ALUSEL_XOR 'b0100
    `define ALUSEL_SLL 'b0101
    `define ALUSEL_SRL 'b0110
    `define ALUSEL_SRA 'b0111
    `define ALUSEL_LUI 'b1000

    // ASel: use `rs1` or `pc`
    `define ASEL_R     'b0
    `define ASEL_PC    'b1

    // BSel: use `rs2` or `imm`
    `define BSEL_R     'b0
    `define BSEL_I     'b1

    // BrUn: unsigned compare
    `define BRUN_NON   'b0
    `define BRUN_EN    'b1 // probably not used

    // BrSel: determine the branch compare operation
    `define BRSEL_NON  'b000
    `define BRSEL_BEQ  'b001
    `define BRSEL_BNE  'b010
    `define BRSEL_BLT  'b011
    `define BRSEL_BGE  'b100

    // BrEQ: boolean of A==B
    `define BREQ_F     'b0
    `define BREQ_T     'b1

    // BrLT: boolean of A<B
    `define BRLT_F     'b0
    `define BRLT_T     'b1

    // Mem: memory access
    `define MEM_NON    'b0
    `define MEM_EN     'b1

    // MemW: memory write
    `define MEMW_NON   'b0
    `define MEMW_EN    'b1

    // Branch: end of PCSel
    `define BRANCH_PC4 'b0
    `define BRANCH_IMM 'b1

`endif