`timescale 1ns / 1ps

module reg_file(
    input             clk_i   ,
    input             rst_n_i ,
    input      [4 :0] rs1_i   ,
    input      [4 :0] rs2_i   ,
    input      [4 :0] wr_i    ,

    // write data
    input             regWEn_i,
    input      [1 :0] wbSel_i ,
    input      [31:0] aluC_i  ,
    input      [31:0] mem_rd_i,
    input      [31:0] pc4_i   ,

    output     [31:0] rd1_o   ,
    output     [31:0] rd2_o   ,
    output reg [31:0] wd_o
);

reg [31:0] regfile [31:0];

integer i;

// read from RF
assign rd1_o = regfile[rs1_i];
assign rd2_o = regfile[rs2_i];

always @(*) begin
    case (wbSel_i)
        `WBSEL_ALU: wd_o = aluC_i  ;
        `WBSEL_MEM: wd_o = mem_rd_i;
        `WBSEL_PC4: wd_o = pc4_i   ;
        default   : wd_o = 32'b0   ;
    endcase
end

// write to RF
always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) begin
        for (i = 0; i <= 31; i = i + 1) begin
            regfile[i] <= 32'b0;
        end
    end else begin
        if (regWEn_i) regfile[wr_i] <= wd_o         ;
        else          regfile[wr_i] <= regfile[wr_i];
    end
    regfile[0] <= 0;
end

endmodule
