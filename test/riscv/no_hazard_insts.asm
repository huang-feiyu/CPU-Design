# no_hazard_insts

#addi x6, x0, 0x0

start:
addi x1, x0, 0x1
addi x2, x0, 0x2
addi x3, x0, 0x3

lui x4, 0x1000
lui x5, 0x2000

add x6, x6, x1

jal x0, start
