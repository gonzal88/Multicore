/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  MEMWB interface
 */


`ifndef MEMWB_IF_VH
 `define MEMWB_IF_VH

 `include "cpu_types_pkg.vh"

interface memwb_if;
   import cpu_types_pkkg::*;

   word_t extout_i, extout_o, Jaddr_i, Jaddr_o, Rd_i, Rd_o, Rt_i, Rt_o, npc_o, npc_i;
   logic flush, lui_i, lui_o, jr_i, jr_o, RegW_i, RegW_o, ALUsource_i, ALUsource_o, halt_i, halt_o;
   logic [1:0] Mem_i, Mem_o, RegDest_i, RegDest_o;
   
   opcode_t opcode_i, opcode_o;
   
   
   

   modport ex(
	      input  flush, extout_i, Jaddr_i, Rd_i, Rt_i, npc_i, lui_i, jr_i, RegW_i, ALUsource_i, halt_i,
	      output extout_o, Jaddr_o, Rd_o, Rt_o, npc_o, lui_o, jr_o, RegW_o, ALUsource_o, halt_o
	      );
endinterface // exmem_if

`endif
