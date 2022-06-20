# Author: Huang
# Date: 2022.06.22
# Description: Simple Calculator using RISC-V

lui s1, 0xFFFFF         # s1 <- 0xFFFF_F000

# 	addi  s1,s1,3             # what does this mean?
# 	lui   s1,0xFFFFF          # s1 <- 0xFFFF_F000
# switled:                    # Test led and switch and digit
# 	lw   s0,0x70(s1)          # read switch; s0 <- Mem[0xFFFF_F070]
# 	sw   s0,0x60(s1)          # write led; Mem[0xFFFF_F060] <- s0
# 	sw   s0,0x00(s1)          # write digit; Mem[0xFFFF_F000] <- s0
# 	jal switled
calc:
add a0, x0, x0
add a1, x0, x0
add a2, x0, x0
# 1. decode sw
# SW[0:23]
# * [23:21]: Op
# * [20:16]: None
# * [15:8]: Operator B
# * [7:0]: Operator A
lw   s0, 0x70(s1)       # read switch; s0 <- Mem[0xFFFF_F070]
andi a1, s0, 0xFF       # load A; a1 <- s0 & 0xFF
srli s0, s0, 8          # s0 <- s0 >> 8
andi a2, s0, 0xFF       # load B; a2 <- s0 & 0xFF
srli s0, s0, 0xD        # s0 <- s0 >> 13
sw s0, 0x60(s1)         # write led; Mem[0xFFFF_F060] <- a2
andi a3, s0, 0x8        # load op; a3 <- s0 & 0x8

# 2. compute
# 1:`+` 2:`-` 3:`&` 4:`|` 5:`<<` 6:`>>` 7:`*`
add t0, x0, x0          # t0 <- 0
beq a3, t0, display     # if op == 0, do nothing, undefined
addi t0, t0, 1
beq a3, t0, op_add      # if op == 1, do op_add
addi t0, t0, 1
beq a3, t0, op_sub      # if op == 2, do op_sub
addi t0, t0, 1
beq a3, t0, op_and      # if op == 3, do op_and
addi t0, t0, 1
beq a3, t0, op_or       # if op == 4, do op_or
addi t0, t0, 1
beq a3, t0, op_sll      # if op == 5, do op_sll
addi t0, t0, 1
beq a3, t0, op_sra      # if op == 6, do op_sra
addi t0, t0, 1
beq a3, t0, op_mul      # if op == 7, do op_mul

beq x0, x0, display     # do nothing

op_add:
add a0, a1, a2          # a0 <- a1 + a2
beq x0, x0, display
op_sub:
sub a0, a1, a2          # a0 <- a1 - a2
beq x0, x0, display
op_and:
and a0, a1, a2          # a0 <- a1 & a2
beq x0, x0, display
op_or:
or a0, a1, a2           # a0 <- a1 | a2
beq x0, x0, display
op_sll:
sll a0, a1, a2          # a0 <- a1 << a2
beq x0, x0, display
op_sra:
sra a0, a1, a2          # a0 <- a1 >> a2
beq x0, x0, display
op_mul: # temporarily not implemented
addi a0, a1, 0
beq x0, x0, display

display:
sw a0, 0x00(s1)         # write digit; Mem[0xFFFF_F000] <- a0
jal calc
