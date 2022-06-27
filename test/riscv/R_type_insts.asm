# R_type_insts

addi x0, x0, 4
addi x1, x0, 5  # x1 = 5
addi x2, x0, -3 # x2 = -3
add  x3, x1, x2 # x3 = 2

sub x3, x1, x2  # x3 = 8

addi x1, x0, 5  # x1 = 0b101 = 5
addi x2, x0, 6  # x2 = 0b110 = 6
and x3, x1, x2  # x3 = 0b100 = 4

or x3, x1, x2   # x3 = 0b111 = 7

xor x3, x1, x2  # x3 = 0b011 = 3

addi x1, x0, 5  # x1 = 0b101 = 5
addi x2, x0, 2  # x2 = 0b010 = 2
sll x3, x1, x2  # x3 = 0b10100 = 20

srl x3, x1, x2  # x3 = 0b001 = 1

addi x1, x0, -3 # x1 = 0b1101 = -3
addi x2, x0, 1  # x2 = 0b0001 = 1
sra x3, x1, x2  # x3 = 0b1110 = -2
