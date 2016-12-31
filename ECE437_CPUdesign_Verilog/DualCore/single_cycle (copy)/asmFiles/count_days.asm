org 0x0000

ori $29, $0, 0xFFFC

#load the constant
ori $2, $0, 0x000013  #days29
ori $3, $0, 0x000008  #current month
ori $4, $0, 0x00016D  # 365
ori $5, $0, 0x0007D0  # year 2000
ori $6, $0, 0x0007E0  # year 2016

#multication of the months
ori $10, $0, 0x001E  #30
ori $7, $0, 0x0001
subu $11, $3, $7
ori $20, $0, 0x0000
	# 10 multiply 11
MUL1:
	beq $11, $20, FINISH1
	addu $15, $15, $10
	addiu $20, $20, 0x0001
j MUL1

FINISH1:
#register 15 have the 7*30

#multication of years
subu $21, $6, $5
	#register 21 multiply reg 4
ori $20, $0, 0x0000
MUL2:
	beq $21, $20, FINISH2
	addu $25, $25, $4
	addiu $20, $20, 0x0001
j MUL2

FINISH2:
#register 25 have the 365 * 16

addu $25, $25, $15
addu $25, $25, $2

HALT
	
