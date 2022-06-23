# 计算机设计与实践

> HITsz 计算机设计与实践课程, [Website](https://hitsz-cslab.gitee.io/cpu/).

简单实现笔记与 Debug 过程.

[TOC]

## Prepare

> [Sheet.xlsx](Datapath_Control_Sheet.xlsx): 数据通路表 与 控制信号取值表

使用 Excel 建立数据通路表 与 控制信号取值表.

* 数据通路: 数据流经路径上的所有部件构成的通路，是 CPU 完成数据处理的物理基础. (PC, IROM, DRAM, RF, ALU, etc.)
* 控制信号: 数据通路具体功能, 主要是控制器.

可以根据 [SoC.circ](./lab1/RISCV-SoC.circ) 做出类似的 CPU.(?)

<details><img src="https://user-images.githubusercontent.com/70138429/175284762-139a6230-bb9d-4edd-a695-b8c4e9da8340.png" alt="datapath"><br/><img src="https://user-images.githubusercontent.com/70138429/175284806-0f3376d0-163e-4c55-8ca6-7eb1608380ce.png" alt="control"></details>

---

> 零碎的实现笔记.

* 取值单元
    * PC
    * NPC: (next PC) 下一条指令的地址, `PC+4` or `ALU.C`<br/>其中 `Branch` 综合了 `PCSel`, `BrSel`, `BrEQ`, `BrLT`
    * IROM: 指令存储器
* 译码单元
    * RF: 寄存器堆
    * SEXT: 立即数 imm-gen<br/>`ImmSel` 是指令类型
* 执行单元
    * ALU: 计算单元<br/>`ALUSel_LUI` 计算 `0+imm`
    * BrUN: 比较器<br/>`BrSel` 表示为哪一个操作, `BrUn` 是无符号数比较
* 存储单元
    * DRAM: 数据存储器<br/>`Mem` 表示有 **读或写** 操作, `MemW` 表示为 **写** 操作.
* Attention
    * `lui`: ALU_op 为 `0+SEXT.ext`
    * 一般来说, `1b'1` 代表**使能**

### lab1

> [lab1](./lab1): RISC-V Assembly

#### 1. 简单的 Logisim 操作使用

外设与 I/O 接口:
* 数码管: `0xFFFF_F000`
* LED: `0xFFFF_F060`
* 拨码开关: `0xFFFF_F070`

* SW: n -> LED: n (各位置相对应)
* SW: xxxx -> LED: xxxx (二进制数据 -> 十进制数据)

#### 2. 简易计算器实现

> 原码输入

* SW 为拨码开关: `[0:23]` => 运算符 + 操作数A + 操作数B
    * \[23:21]: 运算符.<br/>1:`+` 2:`-` 3:`&` 4:`|` 5:`<<` 6:`>>` 7:`*`
    * \[20:16]: None
    * \[15:8]: 操作数B
    * \[7:0]: 操作数A
* DK 为数码管: DK7~DK0 => 运算结果

1. decode sw (转换为补码)
2. compute
3. display

---

1. 无显示

`lui s1, 0xFFFF` => `lui s1, 0xFFFFF`

2. Digit 无显示

利用 LED 测试解码是否正确, <s>操作符解码错误.</s> => 非必要初始化错误

`andi a3, s0, 0x8` => `addi a3, s0, 0x0`

3. 乘法存在未知 bug

使用 `mul` 测试程序, **当且仅当**操作数 B 中前三位同时选中时才会出现正确结果.

```diff
< addi t0, x0, 7
< beq a2, t0, op_mul
---
> addi t0, x0, 7
> beq a3, t0, op_mul
```

**调试了一万年**...没想到这么简单.

![24 条指令](https://hitsz-cslab.gitee.io/cpu/lab1/assets/t2-1.png)

## lab2

> 单周期 CPU 设计

总体上, 需要如下模块:
* top module:<br/>`miniRV.v` 实例化、连接各部件
* clock:<br/>`cpuclk.v` 系统时钟(25MHz)
* memory:<br/>`prgrom.v` 指令存储器(64KB)<br/>`dmem.v` 数据存储器(64KB)
* IF: defined in [lab2-1](#lab2-1)
* ID: defined in [lab2-1](#lab2-1)

```verilog
// cpuclk.v usage
`timescale 1ns / 1ps
module cpuclk_sim();
    // input
    reg fpga_clk = 0;
    // output
    wire clk_lock;
    wire pll_clk;
    wire cpu_clk;

    always #5 fpga_clk = ~fpga_clk;

    cpuclk UCLK (
        .clk_in1    (fpga_clk),
        .locked     (clk_lock),
        .clk_out1   (pll_clk)
    );

    assign cpu_clk = pll_clk & clk_lock;

endmodule

// IROM usage
    //......

    wire [31:0] instruction;

    // 64KB IROM
    prgrom U0_irom (
        .a      (pc_i[15:2]),   // input  wire [13:0] a
        .spo    (instruction)   // output wire [31:0] spo
    );

    ......
endmodule

// 64KB DRAM
dram U_dram (
    .clk    (clk_i),            // input  wire clka
    .a      (addr_i[15:2]),     // input  wire [13:0] addra
    .spo    (rd_data_o),        // output wire [31:0] douta
    .we     (memwr_i),          // input  wire [0:0] wea
    .d      (wr_data_i)         // input  wire [31:0] dina
);
```

### lab2-1

> [lab2-1](./lab2-1/): 单周期 CPU 设计(IF, ID)

* IF
    * `pc_reg.v`: PC
    * `next_pc.v`: NPC
    * `progrom.xci`: IROM
* ID
    * `reg_file.v`: RF
    * `imm_gen.v`: SEXT
