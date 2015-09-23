/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  MEMWB interface
 */

`include "cpu_types_pkg.vh"
`include "memwb_if.vh"

module memwb
  (
   input logic CLK,
   input logic nRST,
   memwb_if.me mwif
   );
   
   import cpu_types_pkg::*;
   
   always_ff @(posedge CLK, negedge nRST) begin
      if (!nRST) begin
	 mwif.npc_o <= 0;
	 mwif.Addr_o <= 0;
	 mwif.Mem_o <= 0;
	 mwif.RegW_o <= 0;
	 mwif.RegDest_o <= 0;
	 mwif.halt_o <= 0;
	 mwif.alu_out_o <= 0;
	 mwif.opcode_o <= RTYPE;
      end
      
      else begin
	 if (mwif.flush) begin
	    mwif.npc_o <= mwif.npc_i;
	    mwif.Addr_o <= mwif.Addr_i;
	    mwif.Mem_o <= mwif.Mem_i;
	    mwif.RegW_o <= mwif.RegW_i;
	    mwif.RegDest_o <= mwif.RegDest_i;
	    mwif.halt_o <= mwif.halt_i;
	    mwif.alu_out_o <= mwif.alu_out_i;
	    mwif.opcode_o <= mwif.opcode_i;
	 end
	 else begin
	    mwif.npc_o <= 0;
	 mwif.Addr_o <= 0;
	 mwif.Mem_o <= 0;
	 mwif.RegW_o <= 0;
	 mwif.RegDest_o <= 0;
	 mwif.halt_o <= 0;
	 mwif.alu_out_o <= 0;
	 mwif.opcode_o <= RTYPE;
	 end
      end
   end

endmodule
