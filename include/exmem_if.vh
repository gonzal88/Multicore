/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  EXMEM interface
 */


`ifndef EXMEM_IF_VH
 `define EXMEM_IF_VH

 `include "cpu_types_pkg.vh"

interface exmem_if;
   import cpu_types_pkg::*;

   word_t rdat2_o, rdat2_i, rdat1_i, rdat1_o, extout_i, extout_o, Jaddr_i, Jaddr_o, npc_o, npc_i, alu_out_i, alu_out_o;
   logic enable, jr_i, jr_o, RegW_i, RegW_o, Branch_i, Branch_o, jump_i, jump_o, DWen_i, DWen_o, DRen_o, DRen_i, BNE_i, BNE_o, halt_i, halt_o, zero_i, zero_o;
   logic [1:0] Mem_i, Mem_o, RegDest_i, RegDest_o;
   aluop_t ALUop_i, ALUop_o;
   opcode_t opcode_i, opcode_o;
   
   
   

   modport ex(
	      input  enable, rdat2_i, rdat1_i, extout_i, Jaddr_i, npc_i, jr_i, RegW_i, Branch_i, jump_i, DWen_i, DRen_i, BNE_i, halt_i, zero_i, alu_out_i, opcode_i, Mem_i, RegDest_i,
	      output rdat2_o, rdat1_o, extout_o, Jaddr_o, npc_o, jr_o, RegW_o, Branch_o, jump_o, DWen_o, DRen_o, BNE_o, halt_o, zero_o, alu_out_o, opcode_o, Mem_o, RegDest_o
	      );
endinterface // exmem_if

`endif
