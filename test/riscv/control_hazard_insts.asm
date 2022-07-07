# control_hazard_insts

start:
addi x2, x0, 0x7 # x2 <- f
beq x2, x2, skip # if x2 == x2, goto skip
addi x3, x0, 0x1 # x3 <- 1 (can never happen)

skip:
beq x1, x0, start # if x1 == x0, goto start
addi x3, x0, 0x2  # x3 <- 2 (always happen)
addi x3, x3, 0x1  # x3 <- 3 (data hazard)
jal x0, start
