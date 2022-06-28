// for board
module top(
    input  wire clk_i    ,
    input  wire rst_i    ,
    output wire led0_en_o,
    output wire led1_en_o,
    output wire led2_en_o,
    output wire led3_en_o,
    output wire led4_en_o,
    output wire led5_en_o,
    output wire led6_en_o,
    output wire led7_en_o,
    output wire led_ca_o ,
    output wire led_cb_o ,
    output wire led_cc_o ,
    output wire led_cd_o ,
    output wire led_ce_o ,
    output wire led_cf_o ,
    output wire led_cg_o ,
    output wire led_dp_o
);

wire clk   =  clk_i;
wire rst_n = ~rst_i;

wire [31:0] pc    ;
wire [7 :0] led_en;

mini_rv U_mini_rv(
    .fpga_clk_i (clk  ),
    .rst_n_i    (rst_n),
    .pc         (pc   )
);

led_display U_display(
    .clk_i     (clk     ),
    .rst_n_i   (rst_n   ),
    .pc_i      (pc      ),
    .led_en_o  (led_en  ),
    .led_ca_o  (led_ca_o),
    .led_cb_o  (led_cb_o),
    .led_cc_o  (led_cc_o),
    .led_cd_o  (led_cd_o),
    .led_ce_o  (led_ce_o),
    .led_cf_o  (led_cf_o),
    .led_cg_o  (led_cg_o),
    .led_dp_o  (led_dp_o)
);

assign led0_en_o = led_en[0];
assign led1_en_o = led_en[1];
assign led2_en_o = led_en[2];
assign led3_en_o = led_en[3];
assign led4_en_o = led_en[4];
assign led5_en_o = led_en[5];
assign led6_en_o = led_en[6];
assign led7_en_o = led_en[7];

endmodule