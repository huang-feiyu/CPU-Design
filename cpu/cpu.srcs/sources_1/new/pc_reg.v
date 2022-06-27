`timescale 1ns / 1ps

module pc_reg(
    input             clk_i  ,
    input             rst_n_i,
    input             en     ,
    input      [31:0] npc_i  , // next pc

    output reg [31:0] pc_o
);

always @(posedge clk_i or negedge rst_n_i) begin
    // DEBUG: `rst_n`; timing might be wrong, refers to xyfJASON

    // reset active low
    // NOTE: after reset, address is the address of first instruction
    if (~rst_n_i) begin
        pc_o <= 32'b0;
    // end else if (en) begin
    //     pc_o <= npc_i;
    end else begin
        pc_o <= npc_i;
    end
end

endmodule
