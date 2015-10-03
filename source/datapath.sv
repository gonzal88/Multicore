/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

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
   
   r_t rtype;
   i_t itype;
   j_t jtype;
   
   
   
     
   
   // pc init
   parameter PC_INIT = 0;
   word_t      MtR_out;               //MemiftoReg mux output
   word_t      ALUSrc_out;            //ALUSrc mux output
   word_t      Mux_lui;
   word_t      Baddr;                 //Branch mux output
   regbits_t   RegDst_out;            //RegDst mux output
   word_t      extout2, memREGdata, JumpAddr, next_PC, npc, jump_out, mux_fwrdA, mux_fwrdB;
   logic     branch_out, branchd, hazard_enable, check;
   logic [1:0] fwrdA, fwrdB;
   
   
   //Instruction FETCH
   
   assign npc = pcif.PCcurr + 4;
   
   //assign pcif.PCnext = pcif.PCcurr + 4;
   /*always_ff @(posedge CLK, negedge nRST) begin
      if(nRST == 1'b0) begin
	 ifid.iload_i = 0;
	 rtype = r_t'(0);
      end
      else begin
	 rtype = dpif.dhit ? r_t'(0) : r_t'(dpif.imemload);
	 ifid.iload_i = dpif.dhit ? 0: dpif.imemload;
      end
   end*/ // UNMATCHED !!
   assign rtype = r_t'(ifid.iload_o);
   assign jtype = j_t'(ifid.iload_o);
   assign itype = i_t'(ifid.iload_o);
   
   assign ifid.iload_i = dpif.dhit ? 0: dpif.imemload;

   

	
	 
   always_comb begin
      if(cuif.jump) begin
	 next_PC = (rtype.opcode == RTYPE && rtype.funct == JR) ? rfif.rdat1 : ((itype.opcode == J || itype.opcode == JAL) ? {npc[31:28], jtype.addr, 2'b0} : npc);
      end
      else if (branch_out) begin
	 next_PC = {{14{idex.dload_o[15]}}, idex.dload_o[15:0], 2'b00} + idex.npc_o;
      end
      else begin
	 next_PC = npc;
      end
   end // always_comb



   always_comb begin
      if(fwrdA == 2'b00) begin
	 mux_fwrdA = mem.dload_o;
      end
      else if(fwrdA == 2'b01) begin
	 mux_fwrdA = exme.alu_out_o;
      end
      else if(fwrdA == 2'b10) begin
	 mux_fwrdA = idex.rdat1_o;
      end
      else begin
	mux_fwrdA = idex.rdat1_o;
      end

      if(fwrdB == 2'b00) begin
	 mux_fwrdB = mem.dload_o;
      end
      else if(fwrdB == 2'b01) begin
	 mux_fwrdB = exme.alu_out_o;
      end
      else if(fwrdB == 2'b10) begin
	 mux_fwrdB = idex.rdat2_o;
      end
      else begin
	mux_fwrdB = idex.rdat2_o;
      end
   end // always_comb
   


   
   
   assign ifid.iien = !hazard_enable;
//dpif.ihit && !dpif.dhit;
	
   assign ifid.flush = cuif.jump || branch_out;
//dpif.dhit;
   assign ifid.npc_i = npc;
   assign ifid.dload_i = dpif.dmemload;
   
   assign pcif.PCen = ((dpif.ihit && !dpif.dhit) || branch_out || cuif.jump) && !hazard_enable;
   assign dpif.imemaddr = pcif.PCcurr;

   assign pcif.PCnext = next_PC;
//npc;//mem.Addr_o;
   assign dpif.halt = mem.halt_o;
   
   //////////////////////////////////////////////////////////////
   //DATAPATH
   assign dpif.imemREN = 1'b1;
   
   
   ///////////////////////////////////////////////////////////////////
   
   //Instruction DECODE
   
   assign cuif.opcode = opcode_t'(ifid.iload_o[31:26]);
   assign cuif.funct = funct_t'(ifid.iload_o[5:0]);
   assign rfif.rsel1 = rtype.rs;
//mem.rs_o;
   assign rfif.rsel2 = rtype.rt;
//mem.rd_o;
   assign rfif.WEN = mem.RegW_o;
   assign rfif.wsel = RegDst_out;
   assign idex.target_i = RegDst_out;
   assign rfif.wdat = MtR_out;
   assign eif.imm = ifid.iload_o[15:0];
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
   assign idex.rs_i = rtype.rs;
   assign idex.rd_i = rtype.rd;
   assign idex.rt_i = rtype.rt;
   assign idex.shamt_i = rtype.shamt;
   assign idex.dload_i = ifid.iload_o;
   assign idex.enable = dpif.dhit || dpif.ihit;//!(branch_out && dpif.dmemREN != 1);
   assign idex.flush = (ifid.iload_o == 0) || hazard_enable || branch_out;
   
   
   
   
   always_comb begin
      if(cuif.regDest == 2'b10) begin
	 RegDst_out = 31;
      end
      else if (cuif.regDest == 2'b01) begin
	 RegDst_out = mem.rt_o;//
//rtype.rt;

      end
      else if (cuif.regDest == 2'b00) begin
	 RegDst_out = mem.rd_o;//
//rtype.rs;
      end
      else begin
	 RegDst_out = 0;
      end
   end // always_comb

   always_comb begin
      if(mem.Mem_o == 2'b10) begin
	 MtR_out = mem.alu_out_o;
      end
      else if(mem.Mem_o == 2'b00) begin
	 MtR_out = mem.dload_o;
      end
      else //if(mem.Mem_o == 2'b10) 
	begin
	   MtR_out = mem.npc_o;
	end
      /*else begin
	 MtR_out = mem.npc_o;
      end*/
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
   assign exme.rs_i = idex.rs_o;
   assign exme.rd_i = idex.rd_o;
   assign exme.rt_i = idex.rt_o;
   assign exme.dload_i = idex.dload_o;
   assign exme.enable = dpif.dhit || dpif.ihit;
   assign exme.target_i = idex.target_o;
   
   
   
   


   always_comb begin
      if(idex.ALUsource_o == 1'b1) begin
	 ALUSrc_out = idex.extout_o;
      end
      else if (idex.ALUsource_o == 1'b0)begin
	 ALUSrc_out = mux_fwrdB;
      end
      else begin
	 ALUSrc_out = idex.shamt_o;
      end
   end
   
   always_comb begin
      if(idex.lui_o == 1'b1) begin
	 Mux_lui = 0;
      end
      else begin
	 Mux_lui = mux_fwrdA;
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
   assign mem.rs_i = exme.rs_o;
   assign mem.rd_i = exme.rd_o;
   assign mem.rt_i = exme.rt_o;
   assign dpif.dmemaddr = exme.alu_out_o;
   assign dpif.dmemstore = exme.rdat2_o;
   assign dpif.dmemREN = exme.DRen_o;
   assign dpif.dmemWEN = exme.DWen_o;
   assign mem.dload_i = dpif.dmemload;
//exme.dload_o;
   assign mem.enable = dpif.dhit || dpif.ihit;
   assign mem.target_i = exme.target_o;
   
   
      
   

   always_comb begin
      if(alif.zero_flag == 1'b1 && idex.Branch_o == 1'b1) begin
	 branch_out = 1'b1;
      end
      else if(alif.zero_flag == 1'b0 && idex.BNE_o == 1'b1) begin
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
	 Baddr = idex.extout_o;
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

   //--------------------------------------------------------
   //FORWARDING LOGIC
   //--------------------------------------------------------

   always_comb begin
      hazard_enable = idex.DRen_o && (idex.target_o == rtype.rs || idex.target_o == rtype.rt);
      fwrdA = 2'b10;
      fwrdB = 2'b10;

      if(!idex.DRen_o) begin
	 if(exme.DRen_o && (exme.target_o == rtype.rs || exme.target_o == rtype.rt)) begin
	    if(exme.DRen_o && (exme.target_o == rtype.rs && exme.target_o == rtype.rt)) begin
	       fwrdA = 2'b00;
	       fwrdB = 2'b00;
	    end
	    else if (exme.DRen_o && (exme.target_o == rtype.rs)) begin
	       fwrdA = 2'b00;
	       fwrdB = 2'b10;
	    end
	    else begin
	       fwrdA = 2'b10;
	       fwrdB = 2'b00;
	    end
	 end // if (exme.DRen_o && (exme.target_o == rtype.rs || exme.target_o == rtype.rt))
	 else if (idex.target_o == rtype.rs || idex.target_o == rtype.rt) begin
	    if(idex.target_o == rtype.rs && idex.target_o == rtype.rt) begin
	       fwrdA = 2'b01;
	       fwrdB = 2'b01;
	    end
	    else if(idex.target_o == rtype.rs) begin
	       fwrdA = 2'b01;
	       fwrdB = 2'b10;
	    end
	    else begin
	       fwrdA = 2'b10;
	       fwrdB = 2'b01;
	    end
	 end // if (idex.target_o == rtype.rs || idex.target_o == rtype.rt)
	 else if (exme.target_o == rtype.rs || exme.target_o == rtype.rt) begin
	    if(exme.target_o == rtype.rs && exme.target_o == rtype.rt) begin
	       fwrdA = 2'b01;
	       fwrdB = 2'b01;
	    end
	    else if(exme.target_o == rtype.rs) begin
	       fwrdA = 2'b01;
	       fwrdB = 2'b10;
	    end
	    else begin
	       fwrdA = 2'b10;
	       fwrdB = 2'b01;
	    end
	 end // if (exme.target_o == rtype.rs || exme.target_o == rtype.rt)
	 else begin
	    fwrdA = 2'b10;
	    fwrdB = 2'b10;
	 end // else: !if(exme.target_o == rtype.rs || exme.target_o == rtype.rt)
      end // if (!idex.DRen_o)
       
   end // always_comb

   
endmodule // datapath
