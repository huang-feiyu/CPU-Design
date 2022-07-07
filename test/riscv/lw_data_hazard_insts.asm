# lw_data_hazard_insts

addi x4, x0, 1

start:
lui x1, 0x12345 # x1 = 0x12345000
sw x1, 0(x1)    # Mem[0x12345000] = 0x12345000
lw x2, 0(x1)    # x2 = 0x12345000
add x3, x2, x1  # x3 = 0x2468A000
add x4, x4, x4  # x4 = 2 * x4
jal x0, start
