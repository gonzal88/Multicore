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
   word_t      extout2, memREGdata, JumpAddr, next_PC, npc, jump_out, A_out;
   logic     branch_out, branchd, hazard_enable, check, memfwA, memfwB, wbfwA, wbfwB;
   logic [1:0] fwrdA, fwrdB;
   
   
   //Instruction FETCH
   
   assign npc = pcif.PCcurr + 4;
   
   assign rtype = r_t'(ifid.iload_o);
   assign jtype = j_t'(ifid.iload_o);
   assign itype = i_t'(ifid.iload_o);

   assign  ifid.iload_i = dpif.imemload;
   
   always_comb begin
      if((cuif.jump || cuif.jr) && !(branch_out && (idex.opcode_o == BEQ || idex.opcode_o == BNE))) begin
	 next_PC = (rtype.opcode == RTYPE && rtype.funct == JR) ? rfif.rdat1 : ((itype.opcode == J || itype.opcode == JAL) ? {npc[31:28], jtype.addr, 2'b0} : npc);
      end
      else if (branch_out) begin
	 next_PC = idex.braPC_o;
      end
      else begin
	 next_PC = npc;
      end
   end // always_comb
   

   
   
   assign ifid.iien = !hazard_enable ? dpif.ihit: dpif.dhit;
   //assign ifid.iien = !hazard_enable ? dpif.ihit : 1'b0;
   
   //assign ifid.flush = (cuif.jump || branch_out || cuif.jr) ? dpif.ihit : 1'b0;
   assign ifid.flush = (cuif.jump || branch_out || cuif.jr) ? dpif.ihit : dpif.dhit;
   assign ifid.npc_i = npc;
   assign ifid.dload_i = dpif.dmemload;
   assign pcif.PCen = (dpif.ihit || branch_out) && !hazard_enable;
   
   assign dpif.imemaddr = pcif.PCcurr;
   assign pcif.PCnext = next_PC;
   //assign dpif.halt = mem.halt_o;
   always_ff @(posedge CLK or negedge nRST) begin
      if (!nRST) begin
	 dpif.halt <= 1'b0;
      end
      else if( mem.halt_o == 1'b1) begin
	 dpif.halt <= 1'b1;
      end
   end
   
   //////////////////////////////////////////////////////////////
   //DATAPATH
   assign dpif.imemREN = 1'b1;
   
   
   ///////////////////////////////////////////////////////////////////
   
   //Instruction DECODE
   assign idex.braPC_i = {{14{ifid.iload_o[15]}}, ifid.iload_o[15:0], 2'b00} + ifid.npc_o;
   assign cuif.opcode = opcode_t'(ifid.iload_o[31:26]);
   assign cuif.funct = funct_t'(ifid.iload_o[5:0]);
   assign rfif.rsel1 = rtype.rs;
   assign rfif.rsel2 = rtype.rt;
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
   //assign idex.rdat2_i = rfif.rdat2;
   assign idex.rdat1_i = rfif.rdat1;
   assign idex.rs_i = rtype.rs;
   assign idex.rd_i = rtype.rd;
   assign idex.rt_i = rtype.rt;
   assign idex.shamt_i = rtype.shamt;
   assign idex.dload_i = ifid.dload_o;
   assign idex.enable = (exme.opcode_o == LW || exme.opcode_o == SW) ? dpif.dhit : dpif.ihit; 
   //assign idex.flush = (hazard_enable);
   assign idex.flush = (hazard_enable || branch_out) && (dpif.ihit && !dpif.dhit);
   
   
   always_comb begin
	 if(mem.RegDest_o == 2'b10) begin
	    RegDst_out = 31;
	 end
	 else if (mem.RegDest_o == 2'b01) begin
	    RegDst_out = mem.rt_o;
	 end
	 else if (mem.RegDest_o == 2'b00) begin
	    RegDst_out = mem.rd_o;
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
	 else 
	   begin
	      MtR_out = mem.npc_o;
	   end
   end // always_comb


   ///////////////////////////////////////////////////////////////////
   //EXECUTE

   assign alif.portA = Mux_lui;
   assign alif.portB = ALUSrc_out;
   assign alif.aluop = idex.ALUop_o;
   assign exme.braPC_i = 0;
   assign exme.opcode_i = idex.opcode_o;
   assign exme.rdat1_i = idex.rdat1_o;
   assign exme.zero_i = alif.zero_flag;
   assign exme.alu_out_i = alif.outport; 
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
   //assign exme.Jaddr_i = idex.Jaddr_o;
   assign exme.npc_i = idex.npc_o;
   assign exme.extout_i = {idex.extout_o, 2'b00} + idex.npc_o;
   assign exme.rs_i = idex.rs_o;
   assign exme.rd_i = idex.rd_o;
   assign exme.ALUsource_i = idex.ALUsource_o;
   assign exme.rt_i = idex.rt_o;
   assign exme.dload_i = idex.dload_o;
   assign exme.enable = (exme.opcode_o == LW || exme.opcode_o == SW) ? dpif.dhit : dpif.ihit;
   assign exme.target_i = idex.target_o;
   


   //enable signals
   /*
   always_comb begin
      exme.enable = 1'b1;
      mem.enable = 1'b1;
      if (exme.opcode_o == LW || exme.opcode_o == SW) begin
	 exme.enable = dpif.dhit;//dpif.ihit || dpif.dhit;
	 mem.enable = dpif.dhit;
      end
      else begin
	 exme.enable = 1'b1;
	 mem.enable = 1'b1;
      end
   end
*/
   
   always_comb begin
      if(idex.lui_o == 1'b1) begin
	 Mux_lui = 0;
      end
      else begin
	 Mux_lui = A_out;
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
   assign dpif.dmemREN = exme.DRen_o;
   assign dpif.dmemWEN = exme.DWen_o;
   assign mem.dload_i = dpif.dmemload;
   assign mem.ALUsource_i = exme.ALUsource_o;
   assign mem.enable = (exme.opcode_o == LW || exme.opcode_o == SW) ? dpif.dhit : dpif.ihit;
   assign mem.target_i = exme.target_o;
   assign mem.Addr_i = exme.Jaddr_o;
   
   
   
   
   

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
      //$display("opcode: %s \t\trd = %d \t\trt = %d \t\trs = %d", mem.opcode_o, mem.rd_o, mem.rt_o, mem.rs_o);
      
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
      if(idex.jump_o == 1'b1) begin
	 jump_out = idex.Jaddr_o;
      end
      else begin
	 jump_out = Baddr;
      end
   end

   always_comb begin
      if(idex.jr_o == 1'b0) begin
	 exme.Jaddr_i = jump_out;
      end
      else begin
	 exme.Jaddr_i = idex.rdat1_o;
      end
   end

   //--------------------------------------------------------
   //FORWARDING LOGIC
   //--------------------------------------------------------



   always_comb begin
      memfwA = 0;
      memfwB = 0;
      wbfwA = 0;
      wbfwB = 0;
      hazard_enable = idex.DRen_o  && (idex.rt_o == rtype.rs || idex.rt_o == rtype.rt);
      
      
      
      if(idex.halt_o || exme.halt_o || mem.halt_o) begin
	 memfwA = 0;
	 memfwB = 0;
	 wbfwA = 0;
	 wbfwB = 0;
      end
      else if(exme.opcode_o != JAL || mem.opcode_o != JAL) begin
	 //RTYPE-RTYPE
	 if(exme.rd_o == idex.rs_o && (exme.rd_o != 0) && (idex.opcode_o == RTYPE && exme.opcode_o == RTYPE)) begin
	    memfwA = 1;
	 end
	 if(exme.rd_o == idex.rt_o && (exme.rd_o != 0) && (idex.opcode_o == RTYPE && exme.opcode_o == RTYPE)) begin
	    memfwB = 1;
	 end
	 if(mem.rd_o == idex.rs_o && (mem.rd_o != 0) && (idex.opcode_o == RTYPE && mem.opcode_o == RTYPE)) begin
	    wbfwA = 1;
	 end
	 if(mem.rd_o == idex.rt_o && (mem.rd_o != 0) && (idex.opcode_o == RTYPE && mem.opcode_o == RTYPE)) begin
	    wbfwB = 1;
	 end
	 
	 
	 //RTYPE-ITYPE
	 if(exme.rd_o == idex.rs_o && (exme.rd_o != 0) && (idex.opcode_o != RTYPE && exme.opcode_o == RTYPE)) begin
	    memfwA = 1;
	 end
	 if(exme.rd_o == idex.rt_o && (exme.rd_o != 0) && (idex.opcode_o != RTYPE && exme.opcode_o == RTYPE)) begin
	    memfwB = 1;
	 end
	 if(mem.rd_o == idex.rs_o && (mem.rd_o != 0) && (idex.opcode_o != RTYPE && mem.opcode_o == RTYPE)) begin
	    wbfwA = 1;
	 end
	 if(mem.rd_o == idex.rt_o && (mem.rd_o != 0) && (idex.opcode_o != RTYPE && mem.opcode_o == RTYPE)) begin
	    wbfwB = 1;
	 end
	 
	 //ITYPE-RTYPE
	 if(exme.rt_o == idex.rs_o && (exme.rt_o != 0) && (idex.opcode_o == RTYPE && exme.opcode_o != RTYPE)) begin
	    memfwA = 1;
	 end
	 if(exme.rt_o == idex.rt_o && (exme.rt_o != 0) && (idex.opcode_o == RTYPE && exme.opcode_o != RTYPE)) begin
	    memfwB = 1;
	 end
	 if(mem.rt_o == idex.rs_o && (mem.rt_o != 0) && (idex.opcode_o == RTYPE && mem.opcode_o != RTYPE)) begin
	    wbfwA = 1;
	 end
	 if(mem.rt_o == idex.rt_o && (mem.rt_o != 0) && (idex.opcode_o == RTYPE && mem.opcode_o != RTYPE)) begin
	    wbfwB = 1;
	 end
	 
	 //ITYPE-ITYPE
	 
	 if(exme.rt_o == idex.rs_o && (exme.rt_o != 0) && (idex.opcode_o != RTYPE && exme.opcode_o != RTYPE)) begin
	    memfwA = 1;
	 end
	 if(exme.rt_o == idex.rt_o && (exme.rt_o != 0) && (idex.opcode_o != RTYPE && exme.opcode_o != RTYPE)) begin
	    memfwB = 1;
	 end
	 if(mem.rt_o == idex.rs_o && (mem.rt_o != 0) && (idex.opcode_o != RTYPE && mem.opcode_o != RTYPE)) begin
	    wbfwA = 1;
	 end
	 if(mem.rt_o == idex.rt_o && (mem.rt_o != 0) && (idex.opcode_o != RTYPE && mem.opcode_o != RTYPE)) begin
	    wbfwB = 1;
	 end
      end // if (exme.opcode_o != JAL || mem.opcode_o != JAL)
      else if (exme.opcode_o == JAL) begin
	 if(idex.rs_o == 31) begin
	    memfwA = 1;
	 end
	 else if(idex.rt_o == 31 && idex.opcode_o == RTYPE) begin
	    memfwB = 1;
	 end
      end
      else begin
	 if(idex.rs_o == 31) begin
	    wbfwA = 1;
	 end
	 else if(idex.rt_o == 31 && idex.opcode_o == RTYPE) begin
	    wbfwB = 1;
	 end
      end // else: !if(idex.rt_o == 31 && idex.opcode_o == RTYPE)
   end // always_comb

   always_comb begin
      dpif.dmemstore = exme.rdat2_o;
      exme.rdat2_i = idex.rdat2_o;
      idex.rdat2_i = rfif.rdat2;
      if(memfwB) begin

	 if(exme.opcode_o == LW) begin
	    exme.rdat2_i = dpif.dmemload;
	    if(idex.ALUsource_o == 1) begin
	       ALUSrc_out = idex.extout_o;
	    end
	    else if(idex.ALUsource_o == 0) begin
	       ALUSrc_out = dpif.dmemload;//exme.dload_o;
	    end
	    else begin
	       ALUSrc_out = idex.shamt_o;
	    end
	 end // if (mem.opcode_o == LW)
	 else begin
	    exme.rdat2_i = exme.alu_out_o;
	    if(idex.ALUsource_o == 1) begin
	       ALUSrc_out = idex.extout_o;
	    end
	    else if(idex.ALUsource_o == 0) begin
	       ALUSrc_out = exme.alu_out_o;
	    end
	    else begin
	       ALUSrc_out = idex.shamt_o;
	    end
	 end // else: !if(mem.opcode_o == LW)



	 
      end // if (memfwB)
      else if (wbfwB) begin
	 if(mem.opcode_o == LW) begin
	    exme.rdat2_i = mem.dload_o;
	    if(idex.ALUsource_o == 1) begin
	       ALUSrc_out = idex.extout_o;
	    end
	    else if(idex.ALUsource_o == 0) begin
	       ALUSrc_out = mem.dload_o;
	       exme.rdat2_i = mem.dload_o;
	    end
	    else begin
	       ALUSrc_out = idex.shamt_o;
	    end
	 end // if (mem.opcode_o == LW)
	 else begin
	    exme.rdat2_i = mem.alu_out_o;
	    if(idex.ALUsource_o == 1) begin
	       ALUSrc_out = idex.extout_o;
	    end
	    else if(idex.ALUsource_o == 0) begin
	       ALUSrc_out = mem.alu_out_o;
	       exme.rdat2_i = mem.alu_out_o;
	    end
	    else begin
	       ALUSrc_out = idex.shamt_o;
	    end
	 end // else: !if(mem.opcode_o == LW)
      end // if (wbfwB)
      else begin
	 if(idex.ALUsource_o == 1) begin
	    ALUSrc_out = idex.extout_o;
	 end
	 else if(idex.ALUsource_o == 0) begin
	    ALUSrc_out = idex.rdat2_o;
	 end
	 else begin
	    ALUSrc_out = idex.shamt_o;
	 end
      end // else: !if(memfwB)




      if(memfwA) begin
	 //A_out = exme.alu_out_o;
	 if(exme.opcode_o == LW) begin
	    A_out = dpif.dmemload;
	 end
	 else begin
	    A_out = exme.alu_out_o;
	 end
      end
      else if(wbfwA) begin
	 if(mem.opcode_o == LW) begin
	    A_out = mem.dload_o;
	 end
	 else begin
	    A_out = mem.alu_out_o;
	 end
      end
      else begin
	 A_out = idex.rdat1_o;
      end // else: !if(wbfwA)
   end // always_comb
   

   
endmodule // datapath
