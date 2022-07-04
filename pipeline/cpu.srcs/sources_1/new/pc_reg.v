`timescale 1ns / 1ps

module pc_reg(
    input             clk_i  ,
    input             rst_n_i,
    input             en     ,
    input      [31:0] npc_i  , // next pc

    output reg [31:0] pc_o
);

reg rst_n_p;
always @(posedge clk_i) begin
    rst_n_p <= rst_n_i;
end

always @(posedge clk_i, negedge rst_n_i) begin
    if(~rst_n_i)         pc_o <= 32'b0;
    else if (~rst_n_p)   pc_o <= 32'b0;
    else                 pc_o <= npc_i;
end

endmodule
