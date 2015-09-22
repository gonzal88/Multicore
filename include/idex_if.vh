/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  IDEX interface
 */


`ifndef IDEX_IF_VH
 `define IDEX_IF_VH

 `include "cpu_types_pkg.vh"

interface idex_if;
   import cpu_types_pkkg::*;

   word_t rdat2_o, rdat2_i, rdat1_i, rdat1_o, extout_i, extout_o, Jaddr_i, Jaddr_o, Rd_i, Rd_o, Rs_i, Rs_o, Rt_i, Rt_o, npc_o, npc_i;
   logic flush, lui_i, lui_o, jr_i, jr_o, RegW_i, RegW_o, Branch_i, Branch_o, jump_i, jump_o, DWen_i, DWen_o, DRen_o, DRen_i, ALUsource_i, ALUsource_o, BNE_i, BNE_o, halt_i, halt_o;
   logic [1:0] Mem_i, Mem_o, RegDest_i, RegDest_o;
   aluop_t ALUop_i, ALUop_i;
   opcode_t opcode_i, opcode_o;
   
   
   

   modport de(
	      input  flush, rdat2_i, rdat1_i, extout_i, Jaddr_i, Rd_i, Rs_i, Rt_i, npc_i, lui_i, jr_i, RegW_i, Branch_i, jump_i, DWen_i, DRen_i, ALUsource_i, BNE_i, halt_i
	      output rdat1_o, rdat2_o, extout_o, Jaddr_o, Rd_o, Rs_o, Rt_o, npc_o, lui_o, jr_o, RegW_o, Branch_o, jump_o, DWen_o, DRen_o, ALUsource_o, BNE_o, halt_o
	      );
endinterface // idex_if

`endif
