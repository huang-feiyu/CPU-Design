# Author: Huang
# Date: 2022.06.22
# Description: Simple Calculator using RISC-V

lui s3, 0xFFFFF          # s3 <- 0xFFFF_F000

calc:
# 1. decode sw (original -> 2'complement)
lw   s0, 0x70(s3)       # read switch; s0 <- Mem[0xFFFF_F070]
andi s1, s0, 0x7F       # s1 <- |A|
andi t0, s0, 0x80       # A sign
andi a1, s0, 0x7F       # load A; a1 <- s0 & 0x7F
beq t0, x0, A_non       # if A is negative, jump to A_non

# get negative A
xori a1, a1, -1         # a1 <- not a1
addi a1, a1, 1          # a1 <- a1 + 1
A_non:

srli s0, s0, 8          # s0 <- s0 >> 8
andi s2, s0, 0x7F       # s2 <- |B|
andi t1, s0, 0x80       # B sign
andi a2, s0, 0x7F       # load B; a2 <- s0 & 0x7F
beq t1, x0, B_non       # if B is negative, jump to B_non

# get negative B
xori a2, a2, -1         # a2 <- not a2
addi a2, a2, 1          # a2 <- a2 + 1
B_non:

xor s4, t0, t1          # A * B sign

srli s0, s0, 0xD        # s0 <- s0 >> 13
addi a3, s0, 0x0        # load op

# 2. compute
# 1:`+` 2:`-` 3:`&` 4:`|` 5:`<<` 6:`>>` 7:`*`
addi t0, x0, 0          # t0 <- 0
beq a3, t0, display     # if op == 0, do nothing, undefined
addi t0, x0, 1
beq a3, t0, op_add      # if op == 1, do op_add
addi t0, x0, 2
beq a3, t0, op_sub      # if op == 2, do op_sub
addi t0, x0, 3
beq a3, t0, op_and      # if op == 3, do op_and
addi t0, x0, 4
beq a3, t0, op_or       # if op == 4, do op_or
addi t0, x0, 5
beq a3, t0, op_sll      # if op == 5, do op_sll
addi t0, x0, 6
beq a3, t0, op_sra      # if op == 6, do op_sra
addi t0, x0, 7
beq a3, t0, op_mul      # if op == 7, do op_mul

op_add:
add a0, a1, a2          # a0 <- a1 + a2
jal display
op_sub:
sub a0, a1, a2          # a0 <- a1 - a2
jal display
op_and:
and a0, a1, a2          # a0 <- a1 & a2
jal display
op_or:
or a0, a1, a2           # a0 <- a1 | a2
jal display
op_sll:
sll a0, a1, a2          # a0 <- a1 << a2
jal display
op_sra:
sra a0, a1, a2          # a0 <- a1 >> a2
jal display
op_mul:                 # original code one-digit multiplication

addi t1, x0, 0          # counter
addi a0, x0, 0          # result
loop:
andi t0, s2, 0x1        # t0 <- s2 & 0x1
beq t0, x0, mul_not_add # if s2 & 0x1 == 0, jump to mul_not_add
add a0, a0, s1          # a0 <- a0 + s1
mul_not_add:
slli s1, s1, 1          # s1 <- s1 << 1
srli s2, s2, 1          # s2 <- s2 >> 1
addi t1, t1, 1          # counter++
addi t0, x0, 0x8        # t0 <- 8
bne t1, t0, loop        # if counter < 8, jump to loop

beq s4, x0, AB_non      # if A*B is negative, jump to AB_non
# get negative A*B
xori a0, a0, -1         # a0 <- not a0
addi a0, a0, 1          # a0 <- a0 + 1
AB_non:

jal display

display:
# 3. display
sw a0, 0x00(s3)         # write digit; Mem[0xFFFF_F000] <- a0
sw a3, 0x60(s3)         # write led; Mem[0xFFFF_F060] <- a3
jal calc
