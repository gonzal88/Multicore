/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  Instruction Decode/Execute for Pipeline
*/


`include "cpu_types_pkg.vh"
`include "exmem_if.vh"

module exmem
  (input logic CLK,
   input logic nRST,
   exmem_if.ex exme
   );

   import cpu_types_pkg::*;
   
   always_ff @(posedge CLK, negedge nRST) begin
      if (!nRST) begin
	 exme.npc_o <= 0;
	 exme.Jaddr_o <= 0;
	 exme.rdat2_o <= 0;
	 exme.rdat1_o <= 0;
	 exme.alu_out_o <= 0;
	 exme.extout_o <= 0;
	 exme.Mem_o <= 0;
	 exme.Branch_o <= 0;
	 exme.DRen_o <= 0;
	 exme.DWen_o <= 0;
	 exme.RegW_o <= 0;
	 exme.RegDest_o <= 0;
	 exme.halt_o <= 0;
	 exme.opcode_o <= RTYPE;
	 exme.funct_o <= exme.funct_i;
	 exme.jump_o <= 0;
	 exme.jr_o <= 0;
	 exme.BNE_o <= 0;
	 exme.zero_o <= 0;
	 exme.rs_o <= 0;
	 exme.rd_o <= 0;
	 exme.rt_o <= 0;
	 exme.dload_o <= 0;
	 
      end
      
      else begin
	 if (exme.enable) begin
	    exme.npc_o <= exme.npc_i;
	    exme.Jaddr_o <= exme.Jaddr_i;
	    exme.rdat2_o <= exme.rdat2_i;
	    exme.rdat1_o <= exme.rdat1_i;
	    exme.alu_out_o <= exme.alu_out_i;
	    exme.extout_o <= exme.extout_i;
	    exme.Mem_o <= exme.Mem_i;
	    exme.Branch_o <= exme.Branch_i;
	    exme.DRen_o <= exme.DRen_i;
	    exme.DWen_o <= exme.DWen_i;
	    exme.RegW_o <= exme.RegW_i;
	    exme.RegDest_o <= exme.RegDest_i;
	    exme.halt_o <= exme.halt_i;
	    exme.opcode_o <= exme.opcode_i;
	    exme.funct_o <= exme.funct_i;
	    exme.jump_o <= exme.jump_i;
	    exme.jr_o <= exme.jr_i;
	    exme.BNE_o <= exme.BNE_i;
	    exme.zero_o <= exme.zero_i;
	    exme.rs_o <= exme.rs_i;
	    exme.rd_o <= exme.rd_i;
	    exme.rt_o <= exme.rt_i;
	    exme.dload_o <= exme.dload_i;
	 end // if (exme.flush)
	 else begin
	    exme.npc_o <= 0;
	    exme.Jaddr_o <= 0;
	    exme.rdat2_o <= 0;
	    exme.rdat1_o <= 0;
	    exme.alu_out_o <= 0;
	    exme.extout_o <= 0;
	    exme.Mem_o <= 0;
	    exme.Branch_o <= 0;
	    exme.DRen_o <= 0;
	    exme.DWen_o <= 0;
	    exme.RegW_o <= 0;
	    exme.RegDest_o <= 0;
	    exme.halt_o <= 0;
	    exme.opcode_o <= RTYPE;
	    exme.funct_o <= exme.funct_i;
	    exme.jump_o <= 0;
	    exme.jr_o <= 0;
	    exme.BNE_o <= 0;
	    exme.zero_o <= 0;
	    exme.rs_o <= 0;
	    exme.rd_o <= 0;
	    exme.rt_o <= 0;
	    exme.dload_o <= 0;
	 end
      end // else: !if(!nRST || exme.flush)
   end // always_ff @
   
endmodule

