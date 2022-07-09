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

> [I-type](./test/riscv/NonPipeline/I_type_insts.asm)

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

> [R-type](./test/riscv/NonPipeline/R_type_insts.asm)

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

> [MEM](./test/riscv/NonPipeline/MEM_insts.asm)

It is fine.

4. U 型指令

> [U-type](./test/riscv/NonPipeline/U_type_insts.asm)

It is fine.

5. J 型指令

> [J-type](./test/riscv/NonPipeline/J_type_insts.asm)

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

> [B-type](./test/riscv/NonPipeline/B_type_insts.asm)

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

<strong>*</strong> 等于正确, 大于小于错误 => bug06

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

创建一个新工程 [board](./board/), 并在其中创建 `top.v`.

<s>添加总线桥 <code>io_bus.v</code>, 连接各外设.</s> 直接使用 `data_ram.v` 即可.

* `data_ram.v`
    * `dram.v`: 内存模块
    * `led_display.v`: Digit 显示模块
    * `divider.v`: 时钟分频模块
    * LED 显示模块
    * SW 取数模块

等待下板验证...

---

<font color="red"><strong>血泪教训</strong>: 先在仿真中调试完成外设信号, 再进行下板</font>

1. 数码管不亮, LED 与 SW 取数模块正常工作

* `led_display.v`: 行为正常

<strong>*</strong> 忘记写 DRAM 的复位信号 => bug07

```diff
data_ram CPU_DRAM (
    .clk_i    (clk    ),
>   .rst_i    (rst_n_i)
);
```

2. 数码管黯淡

添加 `divider.v`.

3. 切换时, 存在时序 bug

<strong>*</strong> `data_digit` 会在一瞬间变成下一个数据的值 => bug08

```diff
< data_digit = (aluC_i == 32'hFFFFF000 && memW_i) ? rd2_i : data_digit;
---
> always @(posedge clk_i) begin
>     if (aluC_i == 32'hFFFFF000 && memW_i) data_digit <= rd2_i     ;
>     else                                  data_digit <= data_digit;
end
```

<details><summary>FPGA board</summary><img src="https://user-images.githubusercontent.com/70138429/176848507-06c07d40-1eb1-4139-b926-40208be5b617.png"><br/><img src="https://user-images.githubusercontent.com/70138429/176848447-8f66b201-36a3-4488-9adc-819f8de6e9b2.png"></details>

## lab3

> 流水线 CPU 设计

采用[经典五级流水线](https://en.wikipedia.org/wiki/Classic_RISC_pipeline)设计.

在这之前需要修改此前的单周期 CPU 的 WB 阶段代码, 分离出一个新的模块 `wb_top`.
——后续视情况而定, 是否将现在各个零散的模块组合成五个分离的模块: IF, ID, EXE, MEM, WB.

### lab3-1

> [lab3](./lab3): 理想流水线

理想流水线: 假设指令之间没有任何 hazard 存在, 不考虑数据冒险与控制冒险.

0\. 先编写一个**无冒险**[测试指令](./test/riscv/no_hazard_insts.asm), 写到 IROM 中.

1\. `if_id_reg.v`
* `pc`
* `pc4`
* `inst`

2\. `id_exe_reg.v`
* `pc`
* `pc4`
* `pcSel`
* `wbSel`
* `aluSel`
* `aSel`
* `bSel`
* `brSel`
* `memW`
* `ext`
* `rd1`
* `rd2`
* `wr_o`
* `regWEn_o`

<strong>*</strong> RF 写入数据时出现时序前移错误 => bug09

经过排查, 错误在加入 `id_exe_reg.v` 后出现. 在 WB 阶段出现错误, 将 RF 中的部分逻辑后移.

```diff
  * `ext`
  * `rd1`
  * `rd2`
> * `wr_o`
> * `regWEn_o`
```

<strong>*</strong> RF 写入数据时出现时序后移错误 => bug10

```diff
< always @(posedge clk_i or negedge rst_n_i) begin
<    if (~rst_n_i) wr_o <= 'b0         ;
<    else          wr_o <= inst_i[11:7];
< end
---
> assign wr_o = !rst_n_i ? 'b0 : inst_i[11:7];
```

3\. `exe_mem_reg.v`
* `pc4`
* `wbSel`
* `memW`
* `rd2`
* `wr`
* `regWEn`
* `aluC`
* `branch`

4\. `mem_wb_reg.v`
* `branch`
* `aluC`
* `rd`
* `pc4`
* `wbSel`
* `regWEn`
* `wr`

<strong>*</strong> RF 写回高阻态数据 => bug11

```diff
id_top CPU_ID (
    .clk_i    (clk      ),
    .rst_n_i  (rst_n_i  ),
<   .wd_i     (wd       ),
>   .wd_i     (wb_wd    ),
);
```

### lab3-2

> [lab3](./lab3): 停顿, 解决数据冒险和控制冒险

0\. 编写存在**三种情形**数据冒险的[测试指令](./test/riscv/data_hazard_insts.asm), 写入 IROM

根据所编写的测试指令, 可以看到:
* none cycle data wrong: `x1`, `x6` (验证: 未破坏原有理想流水线的功能)
* 1st cycle data wrong: `x2`, `x3`, `x4`
* 1st & 2nd cycle data wrong: `x5`

1\. 添加控制信号 (未添加到数据通路与控制信号表中)
* `re1`: 是否读取 `rs1`<br/>`1`: 读取 `rs1`; `0`: 不读取 `rs1`
* `re2`: 是否读取 `rs2` (同 `re1`)

2\. `hazard_detector.v`: 实现简单数据冒险的流水线暂停
* Input Ports
    * `id_re1`
    * `id_re2`
    * `id_rs1`
    * `id_rs2`
    * `exe_wr`
    * `mem_wr`
    * `wb_wr`
    * `exe_regWEn`
    * `mem_regWEn`
    * `wb_regWEn`
* Output Ports
    * `pc_stop`
    * `if_id_stop`
    * `id_exe_stop`
* Control Logic (数据冒险)<br/>保持 PC, IF/ID, ID/EXE 模块不变
    * A: (REG<sub>ID/EX</sub>.RD == ID.RS1) || (REG<sub>ID/EX</sub>.RD == ID.RS2)<br/> => stop 3 cycles
    * B: (REG<sub>EX/MEM</sub>.RD == ID.RS1) || (REG<sub>EX/MEM</sub>.RD == ID.RS2)<br/> => stop 2 cycles
    * C: (REG<sub>MEM/WB</sub>.RD == ID.RS1) || (REG<sub>MEM/WB</sub>.RD == ID.RS2)<br/> => stop 1 cycle

<strong>*</strong> 流水线时序后移错误 => bug12

在指令 1 执行后, 指令 2 没有被阻塞, 指令 3 被阻塞.

```diff
### 时序后移
< always @(posedge clk_i or negedge rst_n_i) begin
---
> always @(*) begin
    if (~rst_n_i)        pc_stop_o <= 1'b0;
    else if (stop_cycle) pc_stop_o <= 1'b1;
    else                 pc_stop_o <= 1'b0;
end

### 修改赋值顺序
always @(posedge rs_id_mem_hazard or posedge rs_id_exe_hazard or posedge rs_id_wb_hazard) begin
<   if (rs_id_exe_hazard)      stop_cycle <= 3;
<   else if (rs_id_mem_hazard) stop_cycle <= 2;
<   else if (rs_id_wb_hazard ) stop_cycle <= 1;
---
>   if (rs_id_wb_hazard )      stop_cycle <= 1;
>   else if (rs_id_mem_hazard) stop_cycle <= 2;
>   else if (rs_id_exe_hazard) stop_cycle <= 3;
    else                       stop_cycle <= 0;
end
```

3\. `hazard_detector.v`: 实现访存数据冒险的流水线暂停

同样地, 编写存在数据冒险的[测试指令](./test/riscv/lw_data_hazard_insts.asm). 然后, 跑一次仿真. 很容易就通过了.

4\. `hazard_detector.v`: 实现控制冒险的流水线暂停<br/>测试指令使用 [Mixin](./test/riscv/NonPipeline/Mixin_insts.asm), 添加控制信号.
* Input Ports
    * `exe_brSel`
* Output Ports
    * `if_id_flush`
    * `id_exe_flush`

<strong>*</strong> 答案不正确, 编写[简单测试指令](./test/riscv/control_hazard_insts.asm); `is_branch` 高阻态; `pc_reg` 慢一个 cycle => bug13

<s>找不出来, 放弃控制冒险停顿.</s>

由于存在数据冒险与控制冒险的组合, 所以不能在 IF 阶段判断是否为 branch 指令. 要做的是: 在 EXE 阶段判断是否为 branch 指令; 也就要清空下一条指令与下下条指令所产生的寄存器数据: ID/EXE, IF/ID.

Q: 是不是说"不需要停顿"了呢?<br/>A: 是的, 只需要将此前错误取出的后两条指令清零即可. They have done nothing.

<img src="https://user-images.githubusercontent.com/70138429/177804521-3b2579c1-233d-4be5-a6d0-daa4c6c19e7a.png" height="200px">

<strong>*</strong> 同时存在控制冒险与数据冒险时, 控制冒险的 `flush` 信号没有上升 => bug14

```diff
< input         exe_branch_i,
---
> input  [2:0]  exe_branch_i,

< assign if_id_flush_o = exe_branch_i;
< assign id_exe_flush_o = exe_branch_i;
---
> assign if_id_flush_o = exe_branch_i != 'b0;
> assign id_exe_flush_o = exe_branch_i != 'b0;
```

<strong>*</strong> 分支信号总是清除后两条指令 => bug15

```diff
# 1. 撤回 bug14 修改
# 2. 增加判断语句: iff 跳转指令
> wire        exe_hz_br ;
> assign exe_hz_br = exe_branch;
hazard_detector CPU_HZD (
    .clk_i         (clk        ),
    .rst_n_i       (rst_n_i    ),
<   .exe_branch_i  (exe_branch ),
>   .exe_branch_i  (exe_hz_br  ),
```

找了两天半的 bug, 发现: 由于早期设计问题, 修改的话会出现矛盾; 除非从头再来, 虽然还有一个星期的时间, 但是干点别的不好吗?

到此为止吧, 由于早期设计问题以及有点懒, 我选择放弃<s>这个作业.</s> 停顿/［垃圾］指导书.

### lab3-3

> [lab3](./lab3): 数据前递, 解决数据冒险和控制冒险

根据[《计算机组成与设计》](https://book.douban.com/subject/26604008/), 重新设计数据通路. 基本思路为:
* 数据冒险: 在 ID/EXE 后半阶段检测冒险, 将前递的数据传送到 `exe_top`/`alu` 中; 也就是在 `hazard_detector` 判断并输出 ALU 的输入 `rs1_f`, `rs2_f`.
    * `rs_f` 三种选择: `rd`, `MEM.wd`, `WB.wd`
    * load 停顿控制: PC, IF/ID 停顿; ID/EXE 清空
    * 冒险类型
        * 1A: ID/EX.rs1 = EX/MEM.wR (其他省略)
        * 2A: ID/EX.rs2 = EX/MEM.wR
        * 1B: ID/EX.rs1 = MEM/WB.wR
        * 2B: ID/EX.rs2 = MEM/WB.wR
        * C: 在同时写入和读取的情况下, 对于读取数据进行判断 `rs==wr && regWEn && wr!=0`, 是否**直接**读取写入的数据 `wd`. (另一种形式的前递)
* 控制冒险: 假设分支不发生, 如果发生分支跳转, 则插入两个 bubble; 也就是在 `hazard_detector` 中, 传入 EXE 阶段的 `branch`, 如果有控制冒险, 则清空 IF/ID, ID/EXE 以达到插入两个 bubble 的目的.

<details><summary>作图如下:</summary><img src="https://user-images.githubusercontent.com/70138429/178110145-949f0a0a-ab6b-4b4a-9582-8a628a047587.png"></details>


第一次差分测试

<strong>*</strong> 写入 `x0` 错误 => bug16

```diff
< assign rd1_o = regWEn_i && wr_i == rs1_i ? wd_i : regfile[rs1_i];
< assign rd2_o = regWEn_i && wr_i == rs2_i ? wd_i : regfile[rs2_i];
---
> assign rd1_o = regWEn_i && wr_i == rs1_i && wr_i != 0 ? wd_i : regfile[rs1_i];
> assign rd2_o = regWEn_i && wr_i == rs2_i && wr_i != 0 ? wd_i : regfile[rs2_i];
```

第二次差分测试

```
Passed Tests:
add, addi, and, andi, beq, bge, blt, bne, jal, jalr, lui, or, ori, simple, sll, slli, sra, srai, srl, srli, sub, xor, xori
Failed Tests:
auipc, bgeu, bltu, lb, lbu, lh, lhu, lw, sb, sh, slt, slti, sltiu, sltu, start, sw
```

两条指令未通过 `lw`, `sw`.

<strong>*</strong> load 暂停时写入数据出错, 寄存器出错 => bug17

```diff
// mem MUX
wb_top CPU_MEM_MUX (
    .wbSel_i  (mem_wbSel),
    .aluC_i   (mem_aluC ),
<   .mem_rd_i (mem_aluC ),
---
>   .mem_rd_i (mem_rd   ),
    .pc4_i    (mem_pc4  ),
    .wd_o     (mem_wd   )
);
```

第三次差分测试

仅 `sw` 未通过.

<strong>*</strong> `wb_top` 中 `mem_rd_i` 恒为零, 意即: `sw` 无法读出数据 => bug18

```diff
exe_mem_reg CPU_EXE_MEM (
    .clk_i        (clk       ),
    .rst_n_i      (rst_n_i   ),
<   .exe_rd2_i    (exe_rd2   ),
>   .exe_rd2_i    (rs2_forward),
```

至此, Trace 测试全部通过.
