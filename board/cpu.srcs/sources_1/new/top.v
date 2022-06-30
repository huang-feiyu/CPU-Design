// for board
module top(
    input  wire clk    ,
    input  wire rst_i  ,
    output wire led0_en,
    output wire led1_en,
    output wire led2_en,
    output wire led3_en,
    output wire led4_en,
    output wire led5_en,
    output wire led6_en,
    output wire led7_en,
    output wire led_ca ,
    output wire led_cb ,
    output wire led_cc ,
    output wire led_cd ,
    output wire led_ce ,
    output wire led_cf ,
    output wire led_cg ,
    output wire led_dp ,

    input  [23:0] device_sw,
    output [23:0] device_led

);

wire rst_n = ~rst_i;

wire [31:0] pc    ;
wire [7 :0] led_en;

mini_rv U_mini_rv(
    .fpga_clk_i (clk  ),
    .rst_n_i    (rst_n),
    .pc         (pc   ),

    .device_sw_i  (device_sw),
    .device_led_o (device_led)
);

led_display U_display(
    .clk_i     (clk   ),
    .rst_n_i   (rst_n ),
    .pc_i      (pc    ),
    .led_en_o  (led_en),
    .led_ca_o  (led_ca),
    .led_cb_o  (led_cb),
    .led_cc_o  (led_cc),
    .led_cd_o  (led_cd),
    .led_ce_o  (led_ce),
    .led_cf_o  (led_cf),
    .led_cg_o  (led_cg),
    .led_dp_o  (led_dp)
);

assign led0_en = led_en[0];
assign led1_en = led_en[1];
assign led2_en = led_en[2];
assign led3_en = led_en[3];
assign led4_en = led_en[4];
assign led5_en = led_en[5];
assign led6_en = led_en[6];
assign led7_en = led_en[7];

endmodule