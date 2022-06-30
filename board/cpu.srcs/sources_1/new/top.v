// for board
module top(
    input  clk    ,
    input  rst_i  ,

    output led0_en,
    output led1_en,
    output led2_en,
    output led3_en,
    output led4_en,
    output led5_en,
    output led6_en,
    output led7_en,
    output led_ca ,
    output led_cb ,
    output led_cc ,
    output led_cd ,
    output led_ce ,
    output led_cf ,
    output led_cg ,
    output led_dp ,

    input  [23:0] device_sw,
    output [23:0] device_led

);

wire rst_n = ~rst_i;

wire [7:0] led_en;
wire [7:0] led_dt;

mini_rv U_mini_rv(
    .fpga_clk_i (clk   ),
    .rst_n_i    (rst_n ),

    .led_en_o   (led_en),
    .led_dt_o   (led_dt),

    .device_sw_i  (device_sw ),
    .device_led_o (device_led)
);

assign led0_en = led_en[0];
assign led1_en = led_en[1];
assign led2_en = led_en[2];
assign led3_en = led_en[3];
assign led4_en = led_en[4];
assign led5_en = led_en[5];
assign led6_en = led_en[6];
assign led7_en = led_en[7];

assign led_ca  = led_dt[0];
assign led_cb  = led_dt[1];
assign led_cc  = led_dt[2];
assign led_cd  = led_dt[3];
assign led_ce  = led_dt[4];
assign led_cf  = led_dt[5];
assign led_cg  = led_dt[6];
assign led_dp  = led_dt[7];

endmodule