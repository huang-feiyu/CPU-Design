# B_type_insts

start:
addi x1, x0, 1 # x1 = 1
addi x2, x0, 0 # x2 = 0
addi x3, x0, 3 # x1 = 3

loop:
beq x3, x2, done # if i == 3, goto done
addi x2, x2, 1
slli x1, x1, 1   # x1 <<= 1
jal x5, loop

done:
addi x3, x0, 8
bne x3, x1, done

bge x1, x2, next
addi x4, x0, 4

next:
addi x3, x0, -4
blt x1, x3, start
