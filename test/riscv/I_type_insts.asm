# I_type_insts

addi x1, x0, 0  # x1 = 0
addi x2, x1, 1  # x2 = 1
addi x3, x2, -2 # x3 = -1
addi x3, x3, 1  # x3 = 0

addi x1, x0, 5 # x1 = 0b0101 = 5
andi x2, x1, 6 # x2 = 0b0100 = 4

addi x1, x0, 7 # x1 = 0b0111 = 7
ori  x2, x1, 8 # x2 = 0b1111 = 15

addi x1, x0, 9 # x1 = 0b1001 = 9
xori x2, x1, 5 # x2 = 0b1100 = 12

addi x1, x0, 5 # x1 = 0b0101 = 5
slli x2, x1, 1 # x2 = 0b1010 = 10

addi x1, x0, 9 # x1 = 0b1001 = 9
srli x2, x1, 2 # x2 = 0b0010 = 2

addi x1, x0, -5 # x1 = 0b1111_1011 = -5
srai x2, x1, 1  # x2 = 0b1111_1101 = -3
