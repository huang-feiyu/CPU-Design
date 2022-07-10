// for trace
module top(
    input         clk               ,
    input         rst_n             ,
    output        debug_wb_have_inst,
    output [31:0] debug_wb_pc       ,
    output        debug_wb_ena      ,
    output [4: 0] debug_wb_reg      ,
    output [31:0] debug_wb_value
);

wire rst_n_i;
assign rst_n_i = rst_n;

wire [31:0] if_pc   ;
wire [31:0] if_inst ;
wire [31:0] mem_rd2 ;
wire [31:0] mem_aluC;
wire [31:0] mem_rd  ;
wire        mem_memW;

cpu CPU_CORE (
    .clk      (clk     ),
    .rst_n_i  (rst_n_i ),
    .if_inst  (if_inst ),
    .if_pc    (if_pc   ),
    .mem_rd   (mem_rd  ),
    .mem_aluC (mem_aluC),
    .mem_memW (mem_memW),
    .mem_rd2  (mem_rd2 ),

    .debug_wb_have_inst (debug_wb_have_inst),
    .debug_wb_pc        (debug_wb_pc       ),
    .debug_wb_ena       (debug_wb_ena      ),
    .debug_wb_reg       (debug_wb_reg      ),
    .debug_wb_value     (debug_wb_value    )
);

inst_mem imem(
    .a   (if_pc[15:2]),
    .spo (if_inst    )
);

data_mem dmem(
    .clk (clk           ),
    .a   (mem_aluC[15:2]),
    .spo (mem_rd        ),
    .we  (mem_memW      ),
    .d   (mem_rd2       )
);

endmodule