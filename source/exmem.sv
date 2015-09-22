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
	 //exme.bnpc_o <= 0;
	 exme.Jaddr_o <= 0;
	 exme.rdat2_o <= 0;
	 exme.aluout_o <= 0;
	 exme.extout_o <= 0;
	 exme.Mem_o <= 0;
	 exme.ALUSource_o <= 0;
	 exme.Branch_o <= 0;
	 exme.DRen_o <= 0;
	 exme.DWen_o <= 0;
	 exme.RegW_o <= 0;
	 exme.RegDest_o <= 0;
	 exme.halt_o <= 0;
	 exme.Rd_o <= 0;
	 exme.Rt_o <= 0;
	 exme.opcode_o <= RTYPE;
	 exme.jump_o <= 0;
	 exme.lui_o <= 0;
	 exme.jr_o <= 0;
	 exme.BNE_o <= 0;
      end
      
      else begin
	 if (exme.flush) begin
	    exme.npc_o <= exme.npc_i;
	    //exme.bnpc_o <= exme.bnpc_i;
	    exme.Jaddr_o <= exme.Jaddr_i;
	    exme.rdat2_o <= exme.rdat2_i;
	    exme.aluout_o <= exme.aluout_i;
	    exme.extout_o <= exme.extout_i;
	    exme.Mem_o <= exme.Mem_i;
	    exme.ALUSource_o <= exme.ALUSource_i;
	    exme.Branch_o <= exme.Branch_i;
	    exme.DRen_o <= exme.DRen_i;
	    exme.DWen_o <= exme.DWen_i;
	    exme.RegW_o <= exme.RegW_i;
	    exme.RegDest_o <= exme.RegDest_i;
	    exme.halt_o <= exme.halt_i;
	    exme.Rd_o <= exme.Rd_i;
	    exme.Rt_o <= exme.Rt_i;
	    exme.opcode_o <= exme.opcode_i;
	    exme.jump_o <= exme.jump_i;
	    exme.lui_o <= exme.lui_i;
	    exme.jr_o <= exme.jr_i;
	    exme.BNE_o <= exme.BNE_i;
	 end
	 else begin
	    exme.npc_o <= 0;
	    //exme.bnpc_o <= 0;
	    exme.Jaddr_o <= 0;
	    exme.rdat2_o <= 0;
	    exme.aluout_o <= 0;
	    exme.extout_o <= 0;
	    exme.Mem_o <= 0;
	    exme.ALUSource_o <= 0;
	    exme.Branch_o <= 0;
	    exme.DRen_o <= 0;
	    exme.DWen_o <= 0;
	    exme.RegW_o <= 0;
	    exme.RegDest_o <= 0;
	    exme.halt_o <= 0;
	    exme.Rd_o <= 0;
	    exme.Rt_o <= 0;
	    exme.opcode_o <= RTYPE;
	    exme.jump_o <= 0;
	    exme.lui_o <= 0;
	    exme.jr_o <= exme.jr_i;
	    exme.BNE_o <= exme.BNE_i;
	 end
      end
   end
   
endmodule

