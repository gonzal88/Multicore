/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"
`include "alu_if.vh"
`include "extender_if.vh"
`include "program_counter_if.vh"
`include "register_file_if.vh"
`include "ifid_if.vh"
`include "idex_if.vh"
`include "exmem_if.vh"
`include "memwb_if.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
   import cpu_types_pkg::*;
   control_unit_if cuif();
   register_file_if rfif();
   alu_if alif();
   program_counter_if pcif();
   extender_if eif();
   ifid_if ifid();
   idex_if idex();
   exmem_if exme();
   memwb_if mem();
   
   
   
   
   register_file rf (CLK, nRST, rfif);
   alu au (alif);
   control_unit control (cuif);
   program_counter pc (pcif, CLK, nRST);
   extender ext (eif);
   ifid fd (CLK, nRST, ifid);
   idex de (CLK, nRST, idex);
   exmem ex (CLK, nRST, exme);
   memwb me (CLK, nRST, mem);
   
   
   
     
   
   // pc init
   parameter PC_INIT = 0;
   word_t      MtR_out;               //MemiftoReg mux output
   word_t      ALUSrc_out;            //ALUSrc mux output
   word_t      Mux_lui;
   word_t      Baddr;                 //Branch mux output
   regbits_t   RegDst_out;            //RegDst mux output
   word_t      extout2, memREGdata, JumpAddr, PC_in, npc, jump_out;
   logic     branch_out, branchd;
   
   
   //Instruction FETCH
   assign npc = pcif.PCcurr + 4;
   assign ifid.iload_i = dpif.dhit ? 0: dpif.imemload;
   assign ifid.iien = dpif.ihit && !dpif.dhit;
   assign ifid.flush = cuif.jump || branchd;
   assign ifid.npc_i = npc;
   assign pcif.PCen = ((dpif.ihit && !dpif.dhit) || branchd || cuif.jump);
   assign dpif.imemaddr = pcif.PCcurr;
   
   
   ///////////////////////////////////////////////////////////////////
   
   //Instruction DECODE
   
   assign cuif.opcode = opcode_t'(ifid.iload_o[31:26]);
   assign cuif.funct = funct_t'(ifid.iload_o[5:0]);
   assign rfif.rsel1 = regbits_t'(ifid.iload_o[25:21]);
   assign rfif.rsel2 = regbits_t'(ifid.iload_o[20:16]);
   assign rfif.WEN = mem.RegW_o;
   assign rfif.wsel = RegDst_out;
   assign rfif.wdat = MtR_out;
   assign eif.imm = dpif.imemload[15:0];
   assign eif.ExtSel = cuif.ExtSel;
   assign idex.Jaddr_i = {ifid.npc_o[31:28], ifid.iload_o[25:0], 2'b00};
   assign idex.npc_i = ifid.npc_o;
   assign idex.extout_i = eif.extout;
   assign idex.halt_i = cuif.halt;
   assign idex.Branch_i = cuif.Branch;
   assign idex.jump_i = cuif.jump;
   assign idex.DRen_i = cuif.Dren;
   assign idex.DWen_i = cuif.Dwen;
   assign idex.jr_i = cuif.jr;
   assign idex.ALUsource_i = cuif.ALUsource;
   assign idex.ALUop_i = cuif.opcode_ALU;
   assign idex.lui_i = cuif.lui;
   assign idex.RegW_i = cuif.RegW;
   assign idex.RegDest_i = cuif.regDest;
   assign idex.Mem_i = cuif.Mem;
   assign idex.BNE_i = cuif.BNE;
   assign idex.opcode_i = opcode_t'(ifid.iload_o[31:26]);
   assign idex.rdat2_i = rfif.rdat2;
   assign idex.rdat1_i = rfif.rdat1;
   assign idex.flush = (ifid.iload_o == 0) || branchd;
   
   
   always_comb begin
      assign branchd = (idex.opcode_i == BEQ && alif.zero_flag == 1) || (idex.opcode_i == BNE && alif.zero_flag == 0);
   end
   
   always_comb begin
      if(mem.RegDest_o == 2'b10) begin
	 RegDst_out = 31;
      end
      else if (mem.RegDest_o == 2'b01) begin
	 RegDst_out = regbits_t'(ifid.iload_o[15:11]);
      end
      else begin
	 RegDst_out = regbits_t'(ifid.iload_o[20:16]);
      end
   end // always_comb

   always_comb begin
      if(mem.Mem_o == 2'b00) begin
	 MtR_out = mem.alu_out_o;
      end
      else if(mem.Mem_o == 2'b01) begin
	 MtR_out = dpif.dmemload;
      end
      else begin
	 MtR_out = mem.npc_o;
      end
   end // always_comb


   ///////////////////////////////////////////////////////////////////
   //EXECUTE

   assign alif.portA = Mux_lui;
   assign alif.portB = ALUSrc_out;
   assign alif.aluop = idex.ALUop_o;
   assign exme.opcode_i = idex.opcode_o;
   assign exme.rdat1_i = idex.rdat1_o;
   assign exme.zero_i = alif.zero_flag;
   assign exme.alu_out_i = alif.outport;
   assign exme.rdat2_i = idex.rdat2_o;
   assign exme.BNE_i = idex.BNE_o;
   assign exme.jr_i = idex.jr_o;
   assign exme.jump_i = idex.jump_o;
   assign exme.halt_i = idex.halt_o;
   assign exme.RegDest_i = idex.RegDest_o;
   assign exme.RegW_i = idex.RegW_o;
   assign exme.DWen_i = idex.DWen_o;
   assign exme.DRen_i = idex.DRen_o;
   assign exme.Branch_i = idex.Branch_o;
   assign exme.Mem_i = idex.Mem_o;
   assign exme.Jaddr_i = idex.Jaddr_o;
   assign exme.npc_i = idex.npc_o;
   assign exme.extout_i = {idex.extout_o, 2'b00} + idex.npc_o;
   assign exme.enable = 1'b1;
   


   always_comb begin
      if(cuif.ALUsource == 1'b1) begin
	 ALUSrc_out = extout2;
      end
      else begin
	 ALUSrc_out = rfif.rdat2;
      end
   end
   
   always_comb begin
      if(cuif.lui == 1'b1) begin
	 Mux_lui = 0;
      end
      else begin
	 Mux_lui = rfif.rdat1;
      end
   end


   /////////////////////////////////////////////////////////////////
   //MEM

   assign mem.npc_i = exme.npc_o;
   assign mem.alu_out_i = exme.alu_out_o;
   assign mem.halt_i = exme.halt_o;
   assign mem.Mem_i = exme.Mem_o;
   assign mem.RegW_i = exme.RegW_o;
   assign mem.RegDest_i = exme.RegDest_o;
   assign mem.opcode_i = exme.opcode_o;
   assign mem.enable = 1'b1;
   assign dpif.dmemaddr = exme.alu_out_o;
   assign dpif.dmemstore = exme.rdat2_o;
   assign dpif.dmemREN = exme.DRen_o;
   assign dpif.dmemWEN = exme.DWen_o;
   
   

   always_comb begin
      if(exme.zero_o == 1'b1 && exme.Branch_o == 1'b1) begin
	 branch_out = 1'b1;
      end
      else if(exme.zero_o == 1'b0 && exme.BNE_o == 1'b1) begin
	 branch_out = 1'b1;
      end
      else
	begin
	   branch_out = 1'b0;
	end
   end
   
   always_comb begin
      if(branch_out == 1'b0) begin
	 Baddr = npc;
      end
      else begin
	 Baddr = exme.extout_o;
      end
   end

   always_comb begin
      if(exme.jump_o == 1'b1) begin
	 jump_out = exme.Jaddr_o;
      end
      else begin
	 jump_out = Baddr;
      end
   end

   always_comb begin
      if(exme.jr_o == 1'b0) begin
	 mem.Addr_i = jump_out;
      end
      else begin
	 mem.Addr_i = exme.rdat1_o;
      end
   end


   //////////////////////////////////////////////////////////////
   //MEM

   
   assign pcif.PCnext = mem.Addr_o;
   assign dpif.halt = mem.halt_o;
   
   //////////////////////////////////////////////////////////////
   //DATAPATH
   assign dpif.imemREN = 1'b1;
    
   
   
endmodule // datapath
