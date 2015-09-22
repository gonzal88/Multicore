/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  Instruction Decode/Execute for Pipeline
*/


`include "cpu_types_pkg.vh"
`include "idex_if.vh"

module idex
  (
   input logic CLK,
   input logic nRST,
   idex_if.de ide
   );

   import cpu_types_pkg::*;

   always_ff @(posedge CLK, negedge nRST) begin
      if (!nRST) begin
	 ide.npc_o <= 0;
	 ide.Jaddr_o <= 0;
	 ide.rdat1_o <= 0;
	 ide.rdat2_o <= 0;
	 ide.extout_o <= 0;
	 ide.Mem_o <= 0;
	 ide.ALUsource_o <= 0;
	 ide.Branch_o <= 0;
	 ide.DRen_o <= 0;
	 ide.lui_o <= 0;
	 ide.jr_o <= 0;
	 ide.BNE <= 0;
	 ide.DWen_o <= 0;
	 ide.ALUop_o <= ALU_ADD;
	 ide.RegW_o <= 0;
	 ide.RegDest_o <= 0;
	 ide.halt_o <= 0;
	 ide.Rd_o <= 0;
	 ide.Rt_o <= 0;
	 ide.Rs_o <= 0;
	 ide.opcode_o <= RTYPE;
	 //ide.bnpc_o <= 0;
	 ide.jump_o <= 0;
      end // if (!nRST)
      else begin
	 if (!ide.flush) begin
	    ide.npc_o <= ide.npc_i;
	    ide.Jaddr_o <= ide.Jaddr_i;
	    ide.rdat1_o <= ide.rdat1_i;
	    ide.rdat2_o <= ide.rdat2_i;
	    ide.extout_o <= ide.extout_i;
	    ide.Mem_o <= ide.Mem_i;
	    ide.ALUsource_o <= ide.ALUsource_i;
	    ide.Branch_o <= ide.Branch_i;
	    ide.DRen_o <= ide.DRen_i;
	    ide.lui_o <= ide.lui_i;
	    ide.jr_o <= ide.jr_i;
	    ide.BNE <= ide.BNE_i;
	    ide.DWen_o <= ide.DWen_i;
	    ide.ALUop_o <= ALU_ADD;
	    ide.RegW_o <= ide.RegW_i;
	    ide.RegDest_o <= ide.RegDest_i;
	    ide.halt_o <= ide.halt_i;
	    ide.Rd_o <= ide.Rd_i;
	    ide.Rt_o <= ide.Rt_i;
	    ide.Rs_o <= ide.Rs_i;
	    ide.opcode_o <= RTYPE;
	    //ide.bnpc_o <= 0;
	    ide.jump_o <= ide.jump_i;
	 end // if (!ieif.flush)
	 else begin
	    ide.npc_o <= 0;
	    ide.Jaddr_o <= 0;
	    ide.rdat1_o <= 0;
	    ide.rdat2_o <= 0;
	    ide.extout_o <= 0;
	    ide.Mem_o <= 0;
	    ide.ALUsource_o <= 0;
	    ide.Branch_o <= 0;
	    ide.DRen_o <= 0;
	    ide.lui_o <= 0;
	    ide.jr_o <= 0;
	    ide.BNE <= 0;
	    ide.DWen_o <= 0;
	    ide.ALUop_o <= ALU_ADD;
	    ide.RegW_o <= 0;
	    ide.RegDest_o <= 0;
	    ide.halt_o <= 0;
	    ide.Rd_o <= 0;
	    ide.Rt_o <= 0;
	    ide.Rs_o <= 0;
	    ide.opcode_o <= RTYPE;
	    //ide.bnpc_o <= 0;
	    ide.jump_o <= 0;
	 end // else: !if(!ide.flush)
      end // else: !if(!nRST)
   end // always_ff @
   

endmodule // idex

