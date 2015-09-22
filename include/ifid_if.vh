/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  IFID interface
 */


`ifndef IFID_IF_VH
 `define IFID_IF_VH

 `include "cpu_types_pkg.vh"

interface ifid_if;
   import cpu_types_pkkg::*;

   word_t npc_i, npc_o, iload_i, iload_o;
   logic iien, flush;

   modport fd(
	      input npc_i, iload_i, iien, flush
	      output npc_o, iload_o
	      );
endinterface // ifid_if

`endif
