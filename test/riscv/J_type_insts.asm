# J_type_insts

start:
addi x3, x0, 4 # 0
addi x3, x0, 8 # 4
jalr x1, x3, 8 # 8

addi x4, x0, 4 # 12

jal x2, start  # 16
