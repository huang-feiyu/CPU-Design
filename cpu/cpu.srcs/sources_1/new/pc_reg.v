`timescale 1ns / 1ps

module pc_reg(
    input             clk_i  ,
    input             rst_n_i,
    input      [31:0] npc_i  , // next pc

    output reg [31:0] pc_o
);

always @(posedge clk_i or negedge rst_n_i) begin
    // DEBUG: `rst_n`; timing might be wrong, refers to xyfJASON
    // DEBUG: `en`; attention if there is a bug

    // reset active low
    if (~rst_n_i) begin
        pc_o <= 31'b0;
    end else begin
        pc_o <= npc_i;
    end
end

endmodule
