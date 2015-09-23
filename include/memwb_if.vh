/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  MEMWB interface
 */


`ifndef MEMWB_IF_VH
 `define MEMWB_IF_VH

 `include "cpu_types_pkg.vh"

interface memwb_if;
   import cpu_types_pkg::*;

   word_t Addr_i, Addr_o, npc_o, npc_i, alu_out_i, alu_out_o;
   logic enable, RegW_i, RegW_o, halt_i, halt_o;
   logic [1:0] Mem_i, Mem_o, RegDest_i, RegDest_o;
   
   opcode_t opcode_i, opcode_o;
   
   
   

   modport me(
	      input  enable, Addr_i, npc_i,  RegW_i, halt_i, opcode_i, alu_out_i, Mem_i, RegDest_i,
	      output Addr_o, npc_o, RegW_o, halt_o, opcode_o, alu_out_o, Mem_o, RegDest_o
	      );
endinterface // exmem_if

`endif
