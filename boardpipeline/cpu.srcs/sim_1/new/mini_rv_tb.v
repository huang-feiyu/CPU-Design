`timescale 1ns / 1ps

module mini_rv_tb();

reg         clk  ;
reg         rst_n;

top tb_mini_rv(
    .clk (clk  ),
    .rst_i    (rst_n)
);

always #1 clk = ~clk;

initial begin
    #0  clk = 0;
        rst_n = 0;
    #500 rst_n = 1;
end

endmodule
