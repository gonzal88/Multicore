
  org 0x0000
  ori $1, $zero, 0xBBBB
  ori $2, $zero, 0xAAAC
  ori $3, $zero, 0xCCCC
  beq $zero, $zero, jmpR
  sw  $1, 0($2)
  jal jmpR
  sw  $3, 4($2)

jmpR:
  bne $3, $2, end
  halt

end:
  sw  $2, 8($2)
  halt
