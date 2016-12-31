org 0x0000 #initialize the base address

ori $29, $0, 0xFFFC

#load the operand
ori $10, $0, 0x0004
ori $11, $0, 0x0008
ori $12, $0, 0x0003
ori $13, $0, 0x0007

#load some counter
ori $20, $0, 0x0000  #count the operation times
ori $21, $0, 0x0003  #total operation time should be 3

push $13
push $12
push $11
push $10
	
procedure:
	beq $20, $21, FINISH
	
	pop $2
	pop $3
	ori $4, $0, 0x0000  #addition counter
	
	MUL:
		beq $4, $3, SINGLE
		addu $15, $15, $2
		addiu $4, $4, 0x0001
		j MUL
	
	SINGLE:
	push $15
	ori $15, $0, 0x0000
	addiu $20, $20, 0x0001
	j procedure

FINISH:
	pop $15
HALT
