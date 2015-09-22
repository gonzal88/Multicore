/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  Program Counter Interface for Single Cycle
*/

`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH

 `include "cpu_types_pkg.vh"

interface program_counter_if;
   import cpu_types_pkg::*;

   logic PCen;
   word_t PCnext, PCcurr;

   modport pc(
	     input PCen, PCnext,
	     output PCcurr
	     );
endinterface
`endif