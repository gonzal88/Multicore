  org 0x0000
  ori $2, $0, 0x0100
  ori $29, $0, 0xFFFC
  ori $21, $0, 0x0011
  ori $20, $0, 0x0100
  sw $29, 0($2)
  sw $21, 4($2)
  sw $20, 8($2)
  halt
