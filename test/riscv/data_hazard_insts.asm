# data_hazard_insts

start:
addi x1, x0, 1 # x1 <- 1
addi x2, x1, 1 # x2 <- 2
addi x3, x1, 2 # x3 <- 3
addi x4, x1, 3 # x4 <- 4
addi x5, x4, 1 # x5 <- 5
add x6, x6, x1 # x6 <- x6 + 1
jal x0, start
