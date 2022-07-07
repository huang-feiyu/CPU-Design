# MEM_insts

addi x1, x0, 257 # x1 = 257
sw x1, 0(x1)     # Mem[257] = 257
lw x2, 0(x1)     # x2 = 257
