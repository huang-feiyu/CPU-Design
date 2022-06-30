`timescale 1ns / 1ps

module data_ram(
    input             clk_i    ,
    input      [31:0] aluC_i   ,
    input             mem_i    , // do nothing
    input             memW_i   ,
    input      [31:0] rd2_i    ,

    output reg [31:0] mem_rd_o ,

    input      [23:0] device_sw,
    output reg [23:0] device_led
);

wire we;

assign we = (aluC_i == 32'hFFFFF060) || (aluC_i == 32'hFFFFF062) ?
            1'b0 : memW_i;

always @(*) begin
    if (aluC_i == 32'hFFFFF060 && memW_i)
        device_led = {device_led[23:16], rd2_i[15:0]};
    else if (aluC_i == 32'hFFFFF062 && memW_i)
        device_led = {rd2_i[7:0], device_led[15:0]}  ;
    else
        device_led = device_led;
end

wire [31:0] tmp_rd; // data read from dram ip core
always @(*) begin
    if      (aluC_i == 32'hFFFFF070) mem_rd_o = {16'b0, device_sw[15:0]} ;
    else if (aluC_i == 32'hFFFFF072) mem_rd_o = {24'b0, device_sw[23:16]};
    else                             mem_rd_o = tmp_rd;
end

dram U_dram (
    .clk (clk_i)       ,
    .a   (aluC_i[15:2]),
    .spo (tmp_rd)      ,
    .we  (we)          ,
    .d   (rd2_i)
);

endmodule
