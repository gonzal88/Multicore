
  org 0x0000
  ori  $1, $zero, 0xBBBB
  ori  $2, $zero, 0xCCCC
  ori  $3, $zero, 0xBBBB
  bne  $1, $2, braZ
  sw   $1, 0($2)

braZ:
  sw   $2, 4($2)
  halt
