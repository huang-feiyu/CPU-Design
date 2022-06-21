	addi  s1,s1,3             # what does this mean?
	lui   s1,0xFFFFF          # s1 <- 0xFFFF_F000

switled:                      # Test led and switch
	lw   s0,0x70(s1)          # read switch; s0 <- Mem[0xFFFF_F070]
	sw   s0,0x60(s1)          # write led; Mem[0xFFFF_F060] <- s0
	sw   s0,0x00(s1)          # write digit; Mem[0xFFFF_F000] <- s0
	jal switled
