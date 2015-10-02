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
	 mwif.rs_o <= 0;
	 mwif.rd_o <= 0;
	 mwif.rt_o <= 0;
	 mwif.dload_o <= 0;
     mwif.target_o <= 0;
	 
      end
      
      else begin
	 if (mwif.enable) begin
	    mwif.npc_o <= mwif.npc_i;
	    mwif.Addr_o <= mwif.Addr_i;
	    mwif.Mem_o <= mwif.Mem_i;
	    mwif.RegW_o <= mwif.RegW_i;
	    mwif.RegDest_o <= mwif.RegDest_i;
	    mwif.halt_o <= mwif.halt_i;
	    mwif.alu_out_o <= mwif.alu_out_i;
	    mwif.opcode_o <= mwif.opcode_i;
	    mwif.rs_o <= mwif.rs_i;
	    mwif.rd_o <= mwif.rd_i;
	    mwif.rt_o <= mwif.rt_i;
	    mwif.dload_o <= mwif.dload_i;
        mwif.target_o <= mwif.target_i;
	 end
      end
   end

endmodule
