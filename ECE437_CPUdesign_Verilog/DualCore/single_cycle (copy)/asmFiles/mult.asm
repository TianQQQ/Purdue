org 0x0000 #initialize the base address

ori $29, $0, 0xFFFC
ori $7,  $0, 0x0000 #register to count number of addition

#load the operand
ori $4, $0, 0x0003
ori $5, $0, 0x0005

	push $4
	push $5

	pop $10
	pop $11
	ori $15, $0, 0x0000
MUL:
	beq $11, $7, FINISH
	addu $15, $15, $10
	addiu $7, $7, 0x0001
j MUL

FINISH:
HALT
