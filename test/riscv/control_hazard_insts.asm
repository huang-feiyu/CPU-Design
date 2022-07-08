# control_hazard_insts

addi x5, x0, 1
start:
addi x1, x0, 1
addi x2, x0, 2
bge x2, x1, skip
addi x3, x0, 0x8 # can never be executed
addi x4, x0, 0x20 # can never be executed
addi x4, x2, 0x0 # can never be executed

skip:
addi x5, x5, 1
beq x2, x1, next
add x3, x1, x2 # x3 <- 3
addi x4, x0, 4 # always executed
addi x4, x0, 5 # always executed
next:
jal x0, start
