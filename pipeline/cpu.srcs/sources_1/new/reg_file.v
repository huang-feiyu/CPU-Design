`timescale 1ns / 1ps

module reg_file(
    input         clk_i   ,
    input         rst_n_i ,
    input  [4 :0] rs1_i   ,
    input  [4 :0] rs2_i   ,

    input         regWEn_i,
    input  [4 :0] wr_i    ,
    input  [31:0] wd_i    ,

    output [31:0] rd1_o   ,
    output [31:0] rd2_o
);

reg [31:0] regfile [31:0];

integer i;

// read from RF
assign rd1_o = regfile[rs1_i];
assign rd2_o = regfile[rs2_i];

// write to RF
always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) begin
        for (i = 0; i < 32; i = i + 1) begin
            regfile[i] <= 32'b0;
        end
    end else begin
        if (regWEn_i) regfile[wr_i] <= wd_i         ;
        else          regfile[wr_i] <= regfile[wr_i];
    end
    regfile[0] <= 0;
end

endmodule
