	org 0x0000
	ori $2, $0, 0x016D//365 days
	ori $3, $0, 0x07D0//2000 years
	ori $4, $0, 0x001E//30 days
	ori $5, $0, 0x0001//one
	ori $6, $0, 0x0014//20
	ori $7, $0, 0x0008//August
	ori $8, $0, 0x07DF//2015
	ori $28, $0, 0xFFFB
	ori $29, $0, 0xFFFC
	ori $30, $0, 0xFFFC
	push $8//2015
	push $2//365
	push $3//2000
	push $7
	push $4
	push $5
	j Popping

Return:
	add $21, $0, $18


	
Popping:
	ori $18, $0, 0x0000
	beq $29, $30, Exit2
	pop $13//2000
	pop $10//365
	pop $11//2015
	subu $12, $11, $13
	add $19, $0, $12
	add $11, $0, $10
Adding:
	beq $12, $0, Exit1
	and $11, $5, $12
	beq $11, $0, Shift
	add $18, $18, $10
Shift:
	srl $12, $12, 0x0001
	sll $10, $10, 0x0001
	j Adding

Exit1:
	beq $29, $30, Exit_final
	j Return
	//j Popping

Exit2:	halt

Exit_final:
	add $21, $21, $18
	add $23, $6, $21
	halt
	
