/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  IDEX interface
 */


`ifndef IDEX_IF_VH
 `define IDEX_IF_VH

 `include "cpu_types_pkg.vh"

interface idex_if;
   import cpu_types_pkg::*;

   word_t target_i, target_o, rdat2_o, rdat2_i, rdat1_i, rdat1_o, extout_i, extout_o, Jaddr_i, Jaddr_o, npc_o, npc_i, rs_i, rs_o, rd_i, rd_o, rt_i, rt_o, dload_o, dload_i, shamt_i, shamt_o;
   logic enable, flush, lui_i, lui_o, jr_i, jr_o, RegW_i, RegW_o, Branch_i, Branch_o, jump_i, jump_o, DWen_i, DWen_o, DRen_o, DRen_i, BNE_i, BNE_o, halt_i, halt_o;
   logic [1:0] Mem_i, Mem_o, RegDest_i, RegDest_o, ALUsource_i, ALUsource_o;
   aluop_t ALUop_i, ALUop_o;
   opcode_t opcode_i, opcode_o;
   funct_t funct_i, funct_o;
   
   
   
   

   modport de(
	      input  enable, flush, rdat2_i, shamt_i, rdat1_i, extout_i, Jaddr_i, npc_i, lui_i, jr_i, RegW_i, Branch_i, jump_i, DWen_i, DRen_i, ALUsource_i, BNE_i, funct_i, halt_i, ALUop_i, Mem_i, RegDest_i, opcode_i, rs_i, rd_i, rt_i, dload_i, target_i,
	      output rdat1_o, rdat2_o, extout_o, Jaddr_o, npc_o, lui_o, jr_o, RegW_o, Branch_o, jump_o, DWen_o, DRen_o, ALUsource_o, BNE_o, halt_o, ALUop_o, Mem_o, RegDest_o, funct_o, opcode_o, rs_o, rd_o, rt_o, dload_o, shamt_o, target_o
	      );
endinterface // idex_if

`endif
