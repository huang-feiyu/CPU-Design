`timescale 1ns / 1ps

module led_display(
    input             clk_i   ,
    input             rst_n_i ,
    input      [31:0] data_i  ,
    output reg [7 :0] led_en_o,
    output reg [7 :0] led_dt_o
);

reg [2:0] led_cn_t; // current number

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) led_cn_t <= 3'h0;
    else          led_cn_t <= led_cn_t + 3'h1;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i)led_en_o <= 8'b1111_1111;
    else
    case (led_cn_t)
        3'b000 : led_en_o <= 8'b1111_1110;
        3'b001 : led_en_o <= 8'b1111_1101;
        3'b010 : led_en_o <= 8'b1111_1011;
        3'b011 : led_en_o <= 8'b1111_0111;
        3'b100 : led_en_o <= 8'b1110_1111;
        3'b101 : led_en_o <= 8'b1101_1111;
        3'b110 : led_en_o <= 8'b1011_1111;
        3'b111 : led_en_o <= 8'b0111_1111;
        default: led_en_o <= 8'b1111_1111;
    endcase
end

reg [3:0] led_display;

always @(*) begin
    case (led_cn_t)
        3'b000 : led_display = data_i[3 :0 ];
        3'b001 : led_display = data_i[7 :4 ];
        3'b010 : led_display = data_i[11:8 ];
        3'b011 : led_display = data_i[15:12];
        3'b100 : led_display = data_i[19:16];
        3'b101 : led_display = data_i[23:20];
        3'b110 : led_display = data_i[27:24];
        3'b111 : led_display = data_i[31:28];
        default: led_display = 4'b0000;
    endcase
end

wire eq0 = (led_display == 4'h0);
wire eq1 = (led_display == 4'h1);
wire eq2 = (led_display == 4'h2);
wire eq3 = (led_display == 4'h3);
wire eq4 = (led_display == 4'h4);
wire eq5 = (led_display == 4'h5);
wire eq6 = (led_display == 4'h6);
wire eq7 = (led_display == 4'h7);
wire eq8 = (led_display == 4'h8);
wire eq9 = (led_display == 4'h9);
wire eqa = (led_display == 4'ha);
wire eqb = (led_display == 4'hb);
wire eqc = (led_display == 4'hc);
wire eqd = (led_display == 4'hd);
wire eqe = (led_display == 4'he);
wire eqf = (led_display == 4'hf);

/*************
*   LED      *
* |--A--|    *
* F     B    *
* |--G--|    *
* E     C    *
* |--D--| .  *
*         ⬆️  *
*         DP *
**************/

wire led_ca_d = ~(eq0 | eq2 | eq3 | eq5 | eq6 | eq7 | eq8 | eq9 | eqa | eqc | eqe | eqf);
wire led_cb_d = ~(eq0 | eq1 | eq2 | eq3 | eq4 | eq7 | eq8 | eq9 | eqa | eqd)            ;
wire led_cc_d = ~(eq0 | eq1 | eq3 | eq4 | eq5 | eq6 | eq7 | eq8 | eq9 | eqa | eqb | eqd);
wire led_cd_d = ~(eq0 | eq2 | eq3 | eq5 | eq6 | eq8 | eq9 | eqb | eqc | eqd | eqe)      ;
wire led_ce_d = ~(eq0 | eq2 | eq6 | eq8 | eqa | eqb | eqc | eqd | eqe | eqf)            ;
wire led_cf_d = ~(eq0 | eq4 | eq5 | eq6 | eq8 | eq9 | eqa | eqb | eqc | eqd | eqe | eqf);
wire led_cg_d = ~(eq2 | eq3 | eq4 | eq5 | eq6 | eq8 | eq9 | eqa | eqb | eqd | eqe | eqf);

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) led_dt_o[0] <= 1'b0    ;
    else          led_dt_o[0] <= led_ca_d;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) led_dt_o[1] <= 1'b0    ;
    else          led_dt_o[1] <= led_cb_d;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) led_dt_o[2] <= 1'b0    ;
    else          led_dt_o[2] <= led_cc_d;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) led_dt_o[3] <= 1'b0    ;
    else          led_dt_o[3] <= led_cd_d;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) led_dt_o[4] <= 1'b0    ;
    else          led_dt_o[4] <= led_ce_d;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) led_dt_o[5] <= 1'b0    ;
    else          led_dt_o[5] <= led_cf_d;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) led_dt_o[6] <= 1'b0    ;
    else          led_dt_o[6] <= led_cg_d;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) led_dt_o[7] <= 1'b1;
    else          led_dt_o[7] <= 1'b1;
end

endmodule
