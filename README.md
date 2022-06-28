# 计算机设计与实践

> HITsz 计算机设计与实践课程, [Website](https://hitsz-cslab.gitee.io/cpu/).

简单实现笔记与 Debug 过程.

[TOC]

## Prepare

风格简介:<br/>
1\. 为了看得清晰, 控制信号使用驼峰命名法<br/>
2\. 其他遵循 [Verilog 代码规范](https://hitsz-cslab.gitee.io/cpu/codingstyle/)

---

> [Sheet.xlsx](Datapath_Control_Sheet.xlsx): 数据通路表 与 控制信号取值表

使用 Excel 建立数据通路表 与 控制信号取值表.

* 数据通路: 数据流经路径上的所有部件构成的通路，是 CPU 完成数据处理的物理基础. (PC, IROM, DRAM, RF, ALU, etc.)
* 控制信号: 数据通路具体功能, 主要是控制器.

可以根据 [SoC.circ](./lab1/RISCV-SoC.circ) 做出类似的 CPU.(?)

<details><summary>Excel Sheet</summary><img src="https://user-images.githubusercontent.com/70138429/175284762-139a6230-bb9d-4edd-a695-b8c4e9da8340.png" alt="datapath"><br/><img src="https://user-images.githubusercontent.com/70138429/175284806-0f3376d0-163e-4c55-8ca6-7eb1608380ce.png" alt="control"></details>

---

> 零碎的 Sheet 实现笔记.

* 取值单元
    * PC
    * NPC: (next PC) 下一条指令的地址, `PC+4` or `ALU.C`<br/>其中 `Branch` 综合了 `PCSel`, `BrSel`, `BrEQ`, `BrLT`
    * IROM: 指令存储器
* 译码单元
    * RF: 寄存器堆
    * SEXT: 立即数 imm-gen<br/>`ImmSel` 是指令类型<br/>移位需要单独设置, 仅存在 5 位立即数.
* 执行单元
    * ALU: 计算单元<br/>`ALUSel_LUI` 计算 `0+imm`
    * BrUN: 比较器<br/>`BrSel` 表示为哪一个操作, `BrUn` 是无符号数比较
* 存储单元
    * DRAM: 数据存储器<br/>`Mem` 表示有 **读或写** 操作, `MemW` 表示为 **写** 操作.
* Attention
    * `lui`: ALU_op 为 `0+SEXT.ext`
    * `lw`: 存入时需要符号扩展, `R[rd]={32'bM[](31),M[R[rs1]+imm](31:0)}`
    * 一般来说, `1b'1` 代表**使能**

## lab1

> [lab1](./lab1): RISC-V Assembly

### 1. 简单的 Logisim 操作使用

外设与 I/O 接口:
* 数码管: `0xFFFF_F000`
* LED: `0xFFFF_F060`
* 拨码开关: `0xFFFF_F070`

* SW: n -> LED: n (各位置相对应)
* SW: xxxx -> LED: xxxx (二进制数据 -> 十进制数据)

### 2. 简易计算器实现

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

<details><summary>24 instructions</summary><img src="https://hitsz-cslab.gitee.io/cpu/lab1/assets/t2-1.png" alt="instructions"></details>

## lab2

> 单周期 CPU 设计

总体上, 需要如下模块:
* top module:<br/>`mini_rv.v` 实例化、连接各部件
* clock:<br/>`cpuclk.v` 系统时钟(25MHz)
* memory:<br/>`prgrom.v` 指令存储器(64KB)<br/>`dmem.v` 数据存储器(64KB)
* control: `control.v` defined in [control](#control)
* IF: defined in [lab2-1](#lab2-1)
* ID: defined in [lab2-1](#lab2-1)
* EXE: defined in [lab2-2](#lab2-2)
* MEM: defined in [lab2-2](#lab2-2)
* WB: defined in [lab2-2](#lab2-2)

<details><summary>Hand Painted Datapath</summary><img src="https://user-images.githubusercontent.com/70138429/175945950-bf6abb9e-af5c-40ee-988c-a3656399bca0.png" alt="datapath"><br/><img src="https://user-images.githubusercontent.com/70138429/175945993-c1a4e1bb-cb4b-4035-8172-1be98896cde1.png" alt="ALU"></details>

### control

`control.v` 由于各个模块测试都需要控制器, 故在此处实现, 定义都在 [Sheet.xlsx](Datapath_Control_Sheet.xlsx) 中.

为了方便起见, 这里直接将 32 位指令全部作为 `input` 传入控制器.

### lab2-1

> [lab2](./lab2): 单周期 CPU 设计(IF, ID)

* IF
    * `pc_reg.v`: PC(Combinatorial logic)<br/>PC 的初始值是 CPU 复位后执行的首条指令的地址
    * `next_pc.v`: NPC(Sequential logic)
    * `progrom.xci`: IROM(Combinatorial logic)
* ID
    * `reg_file.v`: RF(Sequential logic)
    * `imm_gen.v`: SEXT(Combinatorial logic)

### lab2-2

> [lab2](./lab2): 单周期 CPU 设计(EXE, MEM, WB)

* EXE: `exe_top.v`
    * `alu`: ALU(Combinatorial logic)
    * `comp`: COMP(Combinatorial logic)
* MEM
* WB: defined before, in `reg_file.v`

### lab2-3

> [lab2](./lab2): 单周期 CPU 设计(Control, Simulation)

在本模块将会把各个 Module 组合起来, 组成一个 CPU 进行仿真测试.

* `mini_rv.v`: 将各个模块实例化<br/>在实现本模块之前, 需要先将 `dram.xci` 用 `data_ram.v` 封装起来 (虽然没有必要, 我还是将 `prgrom.xci` 也用 `inst_rom.v` 封装起来).

经过简单的仿真测试后, 将会进行 [Trace 测试](https://hitsz-cslab.gitee.io/cpu/trace/trace/).

---

仿真测试:

0. 宏定义出错

Vivado 无法识别定义的宏.

```error
'BRANCH_IMM' is not declared [.../next_pc.v:18]
```

将其包含到文件中、将其内容复制到文件中, 都没有效果. ~~也许不能够在 `case` 中用宏?~~

解决方案: use "`MACRO_NAME" instead.

1. I 型指令

> [I-type](./test/riscv/I_type_insts.asm)

<strong>*</strong> `ASel==1` => bug01

```diff
assign aSel_o =   (op == OPCODE_SB)
                ||(op == OPCODE_U )
                ||(op == OPCODE_UJ) ?
<               `ASEL_R : `ASEL_PC  ;
---
>               `ASEL_PC : `ASEL_R  ;
```

2. R 型指令

> [R-type](./test/riscv/R_type_insts.asm)

<strong>*</strong> `sub` & `ALUSel=0` => bug02

```diff
case (funct3)
< FUNCT3_AS_: aluSel_o = funct3 == FUNCT7_ADD ? `ALUSEL_ADD : `ALUSEL_SUB;
< FUNCT3_SR_: aluSel_o = funct3 == FUNCT7_SRL ? `ALUSEL_SRL : `ALUSEL_SRA;
---
> FUNCT3_AS_: aluSel_o = funct7 == FUNCT7_ADD ? `ALUSEL_ADD : `ALUSEL_SUB;
> FUNCT3_SR_: aluSel_o = funct7 == FUNCT7_SRL ? `ALUSEL_SRL : `ALUSEL_SRA;
endcase
```

<strong>*</strong> `addi` & `ALUSel=1` => bug03

```diff
case (funct3)
< FUNCT3_AS_: aluSel_o = funct7 == FUNCT7_ADD ? `ALUSEL_ADD : `ALUSEL_SUB;
---
> FUNCT3_AS_: aluSel_o = (funct7 == FUNCT7_SUB) && (op == OPCODE_R) ? `ALUSEL_SUB : `ALUSEL_ADD;
FUNCT3_SR_: aluSel_o = funct7 == FUNCT7_SRL ? `ALUSEL_SRL : `ALUSEL_SRA;
endcase
```

3. MEM 访存指令

> [MEM](./test/riscv/MEM_insts.asm)

It is fine.

4. U 型指令

> [U-type](./test/riscv/U_type_insts.asm)

It is fine.

5. J 型指令

> [J-type](./test/riscv/J_type_insts.asm)

<strong>*</strong> `branch==1` => bug04

```verilog
// exe_top
always @(*) begin
    case(brSel_i)
    // 代码中仅考虑了比较器, 没有考虑分支器, 将 PCSel 加在 default 即可.
    endcase
end
```

6. B 型指令

> [B-type](./test/riscv/B_type_insts.asm)

```assembly
jal loop # jal x1, loop
```

It is fine.

7. 混合指令

> [Mixin](./test/riscv/Mixin_insts.asm): 魔改后的 lab1

得到结果 -620<s>, 与预期 -20 不同.</s>, 正确.

### lab2-4

Trace 测试:

0. 创建 `top.v`

在差分测试时, 各模块都需要在顶部声明 `include "param.v"

1. 第一次差分测试

结果如下:

```
Passed Tests:
add, addi, and, andi, beq, bne, jal, jalr, lui, lw, or, ori, simple, slli, srai, srli, sub, sw, xor, xori
Failed Tests:
auipc, bge, bgeu, blt, bltu, lb, lbu, lh, lhu, sb, sh, sll, slt, slti, sltiu, sltu, sra, srl
```

除去非必要指令, 测试失败的指令有: `bge`, `blt`, `sll`, `srl`, `sra`.

<strong>*</strong> 立即数移位操作正确, 寄存器移位错误 => bug05

```diff
< `ALUSEL_SRL: aluC_o = a >> b;
---
> wire [4:0] shamt = b[4:0];
> `ALUSEL_SRL: aluC_o = a >> shamt;
```

2. 第二次差分测试

结果如下:

```
Passed Tests:
add, addi, and, andi, beq, bne, jal, jalr, lui, lw, or, ori, simple, sll, slli, sra, srai, srl, srli, sub, sw, xor, xori
Failed Tests:
auipc, bge, bgeu, blt, bltu, lb, lbu, lh, lhu, sb, sh, slt, slti, sltiu, sltu
```

除去非必要指令, 测试失败的指令有: `bge`, `blt`.

```diff
case (a_b_sign_eq)
    0: brLT_o = rd1_i[30:0] < rd2_i[30:0] ? `BRLT_T : `BRLT_F;
< 1: brLT_o = rd1_i[31] == 0 ? `BRLT_T : `BRLT_F;
---
> 1: brLT_o = rd1_i[31] == 1 ? `BRLT_T : `BRLT_F;
endcase
```

至此, trace 测试全部通过.

### lab2-5

创建一个新工程 [board](./board/), 并在其中创建 `top.v` —— Waiting for next course.
