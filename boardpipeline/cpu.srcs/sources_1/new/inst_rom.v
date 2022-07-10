`timescale 1ns / 1ps

module inst_rom(
    input  [31:0] pc_i,
    output [31:0] inst_o
);

prgrom U_irom (
    .a   (pc_i[15:2]),
    .spo (inst_o    )
);

endmodule
