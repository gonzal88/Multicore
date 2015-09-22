	org 0x0000
	ori $29, $0, 0xFFFC
	ori $20, $0, 0x0011//var1
	ori $21, $0, 0x0100//var2
	ori $22, $0, 0x0010//var3
	ori $30, $0, 0xFFFC
	ori $2, $0, 0x0001//one
	push $20
	push $21
	push $22
Popping:
	and $3, $0, $0//final result
	beq $29, $30, Exit2
	pop $5//var1
	pop $6//var2
	add $7, $0, $5
Adding:
	beq $6, $0, Exit1
	and $7, $2, $6
	beq $7, $0, Shift
	add $3, $3, $5
Shift:
	srl $6, $6, 0x0001
	sll $5, $5, 0x0001
	j Adding

Exit1:
	beq $29, $30, Exit2
	push $3
	j Popping

Exit2:	push $3
	halt
	
