`timescale 1ns / 1ps

module pc_reg(
    input             clk_i,
    input             rst_i,
    input      [31:0] npc_i, // next pc

    output reg [31:0] pc_o
);

always @(posedge clk_i or negedge rst_i) begin
    // reset active low
    if (~rst_i) begin
        pc_o <= 0;
    end else begin
        pc_o <= npc_i;
    end
end

endmodule
