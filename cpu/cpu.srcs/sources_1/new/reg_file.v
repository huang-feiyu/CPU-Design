`timescale 1ns / 1ps

module reg_file(
    input             clk_i   ,
    input             rst_n_i ,
    input      [4 :0] rs1_i   ,
    input      [4 :0] rs2_i   ,
    input      [4 :0] wd_i    ,

    // write data
    input             regWEn_i,
    input      [2 :0] wbSel_i ,
    input      [31:0] alu_c_i ,
    input      [31:0] mem_i   ,
    input      [31:0] pc4_i   ,

    output reg [31:0] rd1_i   ,
    output reg [31:0] rd2_i
);

reg [31:0] 	   regfile [5:0];

integer i;

// read from RF
assign rd1_i = regfile[rs1_i];
assign rd2_i = regfile[rs2_i];

// write to RF
always @(posedge clk or negedge rst_n_i) begin
    if (~rst_n_i) begin
        for (i = 0; i < 31; i = i + 1) begin
            regfile[i] <= 0;
        end
    end else begin
        if (regWEn_i)
        case (wbSel_i)
        param.WBSEL_NON: regfile[wd_i] <= regfile[i];
        param.WBSEL_ALU: regfile[wd_i] <= alu_c_i   ;
        param.WBSEL_MEM: regfile[wd_i] <= mem_i     ;
        param.WBSEL_PC4: regfile[wd_i] <= pc4_i     ;
        endcase
    end
end

endmodule
