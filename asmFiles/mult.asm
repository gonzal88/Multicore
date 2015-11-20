//Equation taken from answer in the following post which describes how to multiply by shifting to the left on one number and shifting to the right on the other and if there is a one when shifting right then we add the other number to another variable repeadily
//http://stackoverflow.com/questions/2776211/how-can-i-multiply-and-divide-using-only-bit-shifting-and-adding
	org 0x0000
	ori $29, $0, 0xFFFC
	ori $21, $0, 0x0001
	ori $20, $0, 0x0001
	push $21
	push $20
	
	pop $3
	pop $2
	ori $4, $0, 0x0001
	and $8, $0, $0
	add $6, $0, $2	
Adding:	beq $2, $0, Exit
	and $6, $4, $2
	beq $6, $0, Shift
	add $8, $8, $3
Shift:	srl $2, $2, 0x0001
	sll $3, $3, 0x0001
	j   Adding
	
Exit:	push $8
	halt
	

		
