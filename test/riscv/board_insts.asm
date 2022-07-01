# board_insts
lui x1, 0xFFFFF

lui x2, 0x87654
addi x3, x2, 0x21 # x3<-0x87654021

lui x2, 0xFEDCB
addi x4, x2, 0xA9 # x4 <- 0xFEDCB0A9

sw x3, 0x00(x1)
sw x4, 0x60(x1)
