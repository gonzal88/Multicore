# Written by Javier Gonzales Souto && Cyrus Sutaria
#########
# Parallel Algorithm
#########
# Producer:
# Lock before operation on buffer/stack.
# crc subroutine will be used to generate 256 random numbers
# which will be put into a circular buffer (of size 10) (or
# stack of max size 10).
# Unlock.
#########
# Consumer:
# Lock before operation on buffer/stack.
# Get valid values, update running min, max, avg.
# Unlock
#########

org 0x0000 # Core 1 start
#  counter starts at 256
#  while counter not at 0
  #   if structure not full
  #     produce number

  ori $s1, $0, 256											#############################
  ori $t5, $0, 4
  ori $s2, $0, data											#############################
  subu $s3, $s2, $t5											#############################
  addi $s4, $s2, 40											#############################
  lw  $a0, seed($0)											#############################
  jal crc32												#############################


p0label:
  lw  $s5, stack_top($0)										#############################
  beq $s5, $s4, p0label											#############################
  

	
looklock1:                     #   see lock

  ll $t1, lockloc($0)
  ori $t2, $t1, 1              #   go back to looklock if locked
  beq $t2, $t1, looklock1
  sc $t2, lockloc($0)          #   try set lock
  beq $t2, $0, looklock1       #   go back to looklock if fail
 
  #  store number in structure
  lw  $s5, stack_top($0)										#############################
  addiu $s5, $s5, 4                     #############################
  sw  $v0, 0($s5)											#############################
  sw  $s5, stack_top($0)										#############################

  ori $t2, $0, 0              #   unlock 
  sw $t2, lockloc($0)
 
  ori $a0, $v0, 0											#############################
  jal crc32												#############################
  ori $t5, $0, 1
  subu $s1, $s1, $t5											#############################
  
  bne $s1, $0, p0label											#############################
halt

org 0x0200 # Core 2 start
  #   while counter not at 256 and structure not empty
  ori $29, $0, 0xFFFC

  ori $s1, $0, 256
  ori $s2, $0, 0
  ori $s3, $0, 0xFFFF
  ori $s4, $0, 0
  ori $s5, $0, data
  ori $t5, $0, 4
  subu $s5, $s5, $t5

	
p1label:
  lw  $t3, stack_top($0)
  beq $t3, $s5, p1label 

	
looklock2:     #   see lock
  ll $t1, lockloc($0)
  ori $t2, $t1, 1              #   go back to looklock if locked
  beq $t2, $t1, looklock2
  sc $t2, lockloc($0)          #   try set lock
  beq $t2, $0, looklock2       #   go back to looklock if fail

#     get value - lower 4 bytes
  lw  $t3, stack_top($0)
  lw  $t6, 0($t3)
  ori $t5, $0, 4
  subu $t3, $t3, $t5
  sw  $t3, stack_top($0)
   
  ori $t2, $0, 0              #   unlock 
  sw $t2, lockloc($0)

  andi $t6, $t6, 0xFFFF

#     update min
  ori $a0, $s2, 0
  ori $a1, $t6, 0
  jal min
  ori $s2, $v0, 0
#     update max
  ori $a0, $s3, 0
  ori $a1, $t6, 0
  jal max
  ori $s3, $v0, 0
#     update running avg
  addu $s4, $s4, $t6

  ori $t5, $0, 1
  subu $s1, $s1, $t5
  bne $s1, $0, p1label
  ori $a0, $s4, 0
  ori $a1, $0, 256
  jal divide
  ori $s4, $v0, 0
	
#store results any way store to some mem location or something
  sw $s3, minresult($0)
  sw $s2, maxresult($0)
  sw $s4, avgresult($0)
halt


##############################################################
#                        SUBROUTINES                         #
##############################################################

#CRC
#REGISTERS
#at $1 at
#v $2-3 function returns
#a $4-7 function args
#t $8-15 temps
#s $16-23 saved temps (callee preserved)
#t $24-25 temps
#k $26-27 kernel
#gp $28 gp (callee preserved)
#sp $29 sp (callee preserved)
#fp $30 fp (callee preserved)
#ra $31 return address
# USAGE random0 = crc(seed), random1 = crc(random0)
#       randomN = crc(randomN-1)
#------------------------------------------------------
# $v0 = crc32($a0)
crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

l1:
  slt $t4, $t2, $t3
  beq $t4, $zero, l2

  srl $t4, $a0, 31
  sll $a0, $a0, 1
  beq $t4, $0, l3
  xor $a0, $a0, $t1
l3:
  addiu $t2, $t2, 1
  j l1
l2:
  or $v0, $a0, $0
  jr $ra
#------------------------------------------------------


#MINMAX
# registers a0-1,v0,t0
# a0 = a
# a1 = b
# v0 = result
#-max (a0=a,a1=b) returns v0=max(a,b)--------------
max:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a0, $a1
  beq   $t0, $0, maxrtn
  or    $v0, $0, $a1
maxrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------
#-min (a0=a,a1=b) returns v0=min(a,b)--------------
min:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a1, $a0
  beq   $t0, $0, minrtn
  or    $v0, $0, $a1
minrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------


#DIV
# registers a0-1,v0-1,t0
# a0 = Numerator
# a1 = Denominator
# v0 = Quotient
# v1 = Remainder
#-divide(N=$a0,D=$a1) returns (Q=$v0,R=$v1)--------
divide:               # setup frame
  push  $ra           # saved return address
  push  $a0           # saved register
  push  $a1           # saved register
  or    $v0, $0, $0   # Quotient v0=0
  or    $v1, $0, $a0  # Remainder t2=N=a0
  beq   $0, $a1, divrtn # test zero D
  slt   $t0, $a1, $0  # test neg D
  bne   $t0, $0, divdneg
  slt   $t0, $a0, $0  # test neg N
  bne   $t0, $0, divnneg
divloop:
  slt   $t0, $v1, $a1 # while R >= D
  bne   $t0, $0, divrtn
  addiu $v0, $v0, 1   # Q = Q + 1
  subu  $v1, $v1, $a1 # R = R - D
  j     divloop
divnneg:
  subu  $a0, $0, $a0  # negate N
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
  beq   $v1, $0, divrtn
  addiu $v0, $v0, -1  # return -Q-1
  j     divrtn
divdneg:
  subu  $a0, $0, $a1  # negate D
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
divrtn:
  pop $a1
  pop $a0
  pop $ra
  jr  $ra
#-divide--------------------------------------------

##############################################################
#                            VARS                            #
##############################################################
lockloc:
  cfw 0x0000
seed:
  cfw 0x0000
data:
  cfw 0
  cfw 0
  cfw 0
  cfw 0
  cfw 0
  cfw 0
  cfw 0
  cfw 0
  cfw 0
  cfw 0

stack_top:
  cfw data

minresult:
  cfw 0
maxresult:
  cfw 0
avgresult:
  cfw 0  
