`timescale 1ns / 1ps

module pc_reg(
    input             clk_i  ,
    input             rst_n_i,
    input      [31:0] npc_i  , // next pc
    input             stop_i ,

    output reg [31:0] pc_o
);

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i)    pc_o <= 32'b0;
    else if (stop_i) pc_o <= pc_o ;
    else             pc_o <= npc_i;
end

endmodule
