// for board
module top(
    input         clk   ,
    input         rst_i ,

    output [7: 0] led_en,
    output [7: 0] led_dt,

    input  [23:0] device_sw,
    output [23:0] device_led

);

wire rst_n = ~rst_i;

mini_rv U_mini_rv(
    .fpga_clk_i (clk   ),
    .rst_n_i    (rst_n ),

    .led_en_o   (led_en),
    .led_dt_o   (led_dt),

    .device_sw_i  (device_sw ),
    .device_led_o (device_led)
);

endmodule