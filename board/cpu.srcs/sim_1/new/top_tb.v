`timescale 1ns / 1ps

module top_tb();

reg clk;
reg rst_i;
wire [7:0] led_en;
wire [7:0] led_dt;
wire [23:0] device_led;

top tb_top(
    .clk (clk),
    .rst_i (rst_i),
    .led_en (led_en),
    .led_dt (led_dt),
    .device_led (device_led)
);

always #1 clk = ~clk;

initial begin
    #0  clk = 0;
        rst_i = 1;
    #500 rst_i = 0;
end
endmodule
