`timescale 1ns / 1ps

module data_ram(
    input             clk_i    ,
    input             rst_i    ,
    input      [31:0] aluC_i   ,
    input             mem_i    , // do nothing
    input             memW_i   ,
    input      [31:0] rd2_i    ,

    output reg [31:0] mem_rd_o ,

    output     [7 :0] led_en   ,
    output     [7 :0] led_dt   ,

    input      [23:0] device_sw,
    output reg [23:0] device_led
);

// dram
wire we;
wire [31:0] tmp_rd;

assign we = (aluC_i == 32'hFFFFF060) || (aluC_i == 32'hFFFFF000) ? 1'b0 : memW_i;

dram U_dram (
    .clk (clk_i       ),
    .a   (aluC_i[15:2]),
    .spo (tmp_rd      ),
    .we  (we          ),
    .d   (rd2_i       )
);

// read from the dram/SW
always @(*) begin
    if (aluC_i == 32'hFFFFF070) mem_rd_o = {8'b0, device_sw[23:0]};
    else                        mem_rd_o = tmp_rd;
end

// led control (NOT digit)
always @(*) begin
    if (aluC_i == 32'hFFFFF060 && memW_i) device_led = rd2_i[23:0];
    else                                  device_led = device_led ;
end

// digit tube control
wire        clk_digit     ;
wire [31:0] data_digit = 0;

assign data_digit = (aluC_i == 32'hFFFFF000 && memW_i) ? rd2_i : data_digit;

divider U_divider (
    .clk_i (clk_i    ),
    .rst_n (rst_i    ),
    .clk_o (clk_digit)
);

led_display U_led_display(
    .clk_i    (clk_digit ),
    .rst_n_i  (rst_i     ),
    .data_i   (data_digit),
    .led_en_o (led_en    ),
    .led_dt_o (led_dt    )
);

endmodule
