`timescale 1ns / 1ps

module mini_rv(
    input         clk   ,
    input         rst_i ,

    output [7: 0] led_en,
    output [7: 0] led_dt,

    input  [23:0] device_sw,
    output [23:0] device_led
);

wire clk_i;
wire rst_n_i =~rst_i;

wire        mem_memW;
wire [31:0] if_pc   ;
wire [31:0] if_inst ;
wire [31:0] mem_rd2 ;
wire [31:0] mem_aluC;
wire [31:0] mem_rd  ;

cpu CPU_CORE (
    .clk      (clk_i   ),
    .rst_n_i  (rst_n_i ),
    .if_inst  (if_inst ),
    .if_pc    (if_pc   ),
    .mem_rd   (mem_rd  ),
    .mem_aluC (mem_aluC),
    .mem_memW (mem_memW),
    .mem_rd2  (mem_rd2 )
);

cpuclk CPU_CLK (
    .clk_in1  (clk  ),
    .clk_out1 (clk_i)
);

inst_rom CPU_IROM (
    .pc_i   (if_pc  ),
    .inst_o (if_inst)
);

// MEM
data_ram CPU_MEM (
    .clk_i     (clk_i     ),
    .rst_i     (rst_n_i   ),
    .aluC_i    (mem_aluC  ),
    .memW_i    (mem_memW  ),
    .rd2_i     (mem_rd2   ),

    .mem_rd_o  (mem_rd    ),

    .led_en    (led_en    ),
    .led_dt    (led_dt    ),

    .device_sw (device_sw ),
    .device_led(device_led)
);

endmodule
