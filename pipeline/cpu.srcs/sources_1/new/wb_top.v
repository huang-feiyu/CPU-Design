`timescale 1ns / 1ps

module wb_top(
    input      [1 :0] wbSel_i ,
    input      [31:0] aluC_i  ,
    input      [31:0] mem_rd_i,
    input      [31:0] pc4_i   ,

    output reg [31:0] wd_o
);

always @(*) begin
    case (wbSel_i)
        `WBSEL_ALU: wd_o = aluC_i  ;
        `WBSEL_MEM: wd_o = mem_rd_i;
        `WBSEL_PC4: wd_o = pc4_i   ;
        default   : wd_o = 32'b0   ;
    endcase
end

endmodule
