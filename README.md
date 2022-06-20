# 计算机设计与实践

> HITsz 计算机设计与实践课程, [Website](https://hitsz-cslab.gitee.io/cpu/).

简单实现笔记与 Debug 过程.

## Labs

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

* SW 为拨码开关: `[0:23]` => 运算符 + 操作数A + 操作数B
    * [23:21]\: 运算符.
        * 1:`+` 2:`-` 3:`&` 4:`|` 5:`<<` 6:`>>` 7:`*`
    * [20:16]\: None
    * [15:8]\: 操作数B
    * [7:0]\: 操作数A
* DK 为数码管: DK7~DK0 => 运算结果

1. decode sw
2. compute
3. display

---

1. 无显示

`lui s1, 0xFFFF` => `lui s1, 0xFFFFF`

2. Digit 无显示

利用 LED 测试解码是否正确, 操作符解码错误.


![24 条指令](https://hitsz-cslab.gitee.io/cpu/lab1/assets/t2-1.png)

