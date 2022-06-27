`timescale 1ns / 1ps

module mini_rv_tb();

reg         clk  ;
reg         rst_n;
wire [31:0] pc   ;

mini_rv tb_mini_rv(
    .fpga_clk_i (clk)  ,
    .rst_n_i    (rst_n),
    .pc         (pc)
);

always #1 clk = ~clk;

initial begin
    #0  clk = 0;
        rst_n = 0;
    #500 rst_n = 1;
end

endmodule
