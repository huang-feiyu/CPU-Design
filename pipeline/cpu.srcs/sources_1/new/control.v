`include "param.v"

module control #(
    parameter OPCODE_R      = 7'b0110011,
    parameter OPCODE_I_ALU  = 7'b0010011,
    parameter OPCODE_I_LOAD = 7'b0000011,
    parameter OPCODE_I_JALR = 7'b1100111,
    parameter OPCODE_S      = 7'b0100011,
    parameter OPCODE_SB     = 7'b1100011,
    parameter OPCODE_U      = 7'b0110111,
    parameter OPCODE_UJ     = 7'b1101111,
    parameter FUNCT3_AS_    = 3'b000    ,
    parameter FUNCT7_ADD    = 7'b0000000,
    parameter FUNCT7_SUB    = 7'b0100000,
    parameter FUNCT3_AND    = 3'b111    ,
    parameter FUNCT3_OR     = 3'b110    ,
    parameter FUNCT3_XOR    = 3'b100    ,
    parameter FUNCT3_SLL    = 3'b001    ,
    parameter FUNCT3_SR_    = 3'b101    ,
    parameter FUNCT7_SRL    = 7'b0000000,
    parameter FUNCT7_SRA    = 7'b0100000,
    parameter FUNCT3_BEQ    = 3'b000    ,
    parameter FUNCT3_BNE    = 3'b001    ,
    parameter FUNCT3_BLT    = 3'b100    ,
    parameter FUNCT3_BGE    = 3'b101
)(
    input      [31:0] inst_i  ,

    output            re1_o   ,
    output            re2_o   ,
    output            pcSel_o ,
    output            regWEn_o,
    output reg [1 :0] wbSel_o ,
    output reg [2 :0] immSel_o,
    output reg [3 :0] aluSel_o,
    output            aSel_o  ,
    output            bSel_o  ,
    output            brUn_o  ,
    output reg [2 :0] brSel_o ,
    output            mem_o   ,
    output            memW_o
);

wire [6:0] op     = inst_i[6:0];
wire [2:0] funct3 = inst_i[14:12];
wire [6:0] funct7 = inst_i[31:25];

assign re1_o = (op == OPCODE_U )
            || (op == OPCODE_UJ) ?
            `RE1_NON : `RE1_EN   ;

assign re2_o = (op == OPCODE_R )
            || (op == OPCODE_S )
            || (op == OPCODE_SB) ?
            `RE2_EN : `RE2_NON   ;

assign pcSel_o =   (op == OPCODE_I_JALR)
                || (op == OPCODE_UJ    ) ?
                `PCSEL_IMM : `PCSEL_PC4  ;

assign regWEn_o =  (op == OPCODE_R     )
                || (op == OPCODE_I_ALU )
                || (op == OPCODE_I_LOAD)
                || (op == OPCODE_I_JALR)
                || (op == OPCODE_U     )
                || (op == OPCODE_UJ    ) ?
                `REGWEN_EN : `REGWEN_NON ;

assign aSel_o =   (op == OPCODE_SB)
                ||(op == OPCODE_U )
                ||(op == OPCODE_UJ) ?
                `ASEL_PC : `ASEL_R  ;

assign bSel_o = op == OPCODE_R   ?
                `BSEL_R : `BSEL_I;

assign brUn_o = `BRUN_NON;

assign mem_o =    (op == OPCODE_I_LOAD)
                ||(op == OPCODE_S) ?
                `MEM_EN : `MEM_NON ;

assign memW_o = op == OPCODE_S ?
                `MEMW_EN : `MEMW_NON;

// wbSel_o
always @(*) begin
    case (op)
        OPCODE_R     : wbSel_o = `WBSEL_ALU;
        OPCODE_I_ALU : wbSel_o = `WBSEL_ALU;
        OPCODE_I_LOAD: wbSel_o = `WBSEL_MEM;
        OPCODE_I_JALR: wbSel_o = `WBSEL_PC4;
        OPCODE_U     : wbSel_o = `WBSEL_ALU;
        OPCODE_UJ    : wbSel_o = `WBSEL_PC4;
        default:       wbSel_o = `WBSEL_NON;
    endcase
end

// immSel_o
always @(*) begin
    case (op)
        OPCODE_R     : immSel_o =   `IMMSEL_R ;
        OPCODE_I_ALU : immSel_o =   (funct3 == FUNCT3_SLL) || (funct3 == FUNCT3_SR_) ?
                                    `IMMSEL_IS : `IMMSEL_I;
        OPCODE_I_LOAD: immSel_o =   `IMMSEL_I ;
        OPCODE_I_JALR: immSel_o =   `IMMSEL_I ;
        OPCODE_S     : immSel_o =   `IMMSEL_S ;
        OPCODE_SB    : immSel_o =   `IMMSEL_SB;
        OPCODE_U     : immSel_o =   `IMMSEL_U ;
        OPCODE_UJ    : immSel_o =   `IMMSEL_UJ;
        default:       immSel_o =   `IMMSEL_R ;
    endcase
end

// aluSel_o
always @(*) begin
    if (op == OPCODE_I_ALU || op == OPCODE_R) begin
        case (funct3)
            FUNCT3_AND: aluSel_o = `ALUSEL_AND;
            FUNCT3_OR : aluSel_o = `ALUSEL_OR ;
            FUNCT3_XOR: aluSel_o = `ALUSEL_XOR;
            FUNCT3_SLL: aluSel_o = `ALUSEL_SLL;
            FUNCT3_AS_: aluSel_o = (funct7 == FUNCT7_SUB) && (op == OPCODE_R) ?
                                    `ALUSEL_SUB : `ALUSEL_ADD;
            FUNCT3_SR_: aluSel_o = funct7 == FUNCT7_SRL ? `ALUSEL_SRL : `ALUSEL_SRA;
        endcase
    end else if (op == OPCODE_U) begin
        aluSel_o = `ALUSEL_LUI;
    end else begin
        aluSel_o = `ALUSEL_ADD;
    end
end

// brSel_o
always @(*) begin
    if (op == OPCODE_SB) begin
        case (funct3)
            FUNCT3_BEQ: brSel_o = `BRSEL_BEQ;
            FUNCT3_BNE: brSel_o = `BRSEL_BNE;
            FUNCT3_BLT: brSel_o = `BRSEL_BLT;
            FUNCT3_BGE: brSel_o = `BRSEL_BGE;
        endcase
    end else begin
        brSel_o = `BRSEL_NON;
    end
end

endmodule
