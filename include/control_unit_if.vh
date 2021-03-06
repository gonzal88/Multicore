/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  Control Unit Interface for Single Cycle
*/

`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

 `include "cpu_types_pkg.vh"

interface control_unit_if;
   import cpu_types_pkg::*;

   //control unit signals
   
   opcode_t       opcode;
   funct_t        funct;

   logic          zero_flag, over_flag, lui, jr, RegW, Branch, jump, Dwen, Dren, Iren, halt, BNE;
   logic [1:0]    regDest, ExtSel, Mem, ALUsource;
   aluop_t        opcode_ALU;

   modport control(
		   input opcode, funct, zero_flag, over_flag,
		   output RegW, lui, jr, Branch, jump, Dwen, Dren, Iren, halt, regDest, ExtSel, Mem, ALUsource, opcode_ALU, BNE
		   );

endinterface // control_unit_if
`endif
   
   
