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
`include "request_unit_if.vh"
`include "alu_if.vh"
`include "extender_if.vh"
`include "program_counter_if.vh"
`include "register_file_if.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
   import cpu_types_pkg::*;
   control_unit_if cuif();
   request_unit_if ruif();
   register_file_if rfif();
   alu_if alif();
   program_counter_if pcif();
   extender_if eif();
   
   
   register_file rf (CLK, nRST, rfif);
   alu au (alif);
   control_unit control (cuif);
   request_unit re (CLK, nRST, ruif);
   program_counter pc (pcif, CLK, nRST);
   extender ext (eif);
   
     
   
   // pc init
   parameter PC_INIT = 0;
   word_t      MtR_out;               //MemiftoReg mux output
   word_t      ALUSrc_out;            //ALUSrc mux output
   word_t      Mux_lui;
   word_t      Baddr;                 //Branch mux output
   regbits_t   RegDst_out;            //RegDst mux output
   word_t      extout2, memREGdata, JumpAddr, PC_in, npc, jump_out;
   logic     branch_out;
   
   
   //Request Unit IO
   //input
   assign ruif.dhit = dpif.dhit;
   assign ruif.ihit = dpif.ihit;
   assign ruif.DWen = cuif.Dwen;
   assign ruif.DRen = cuif.Dren;
   assign ruif.IRen = cuif.Iren;
   assign ruif.halt = cuif.halt;
   //output
   assign dpif.halt = ruif.halt;
   assign dpif.imemREN = ruif.IRen;
   assign dpif.dmemREN = ruif.DRen;
   assign dpif.dmemWEN = ruif.DWen;
   assign pcif.PCen = ruif.PCen;
   


   //Control UNIT IO
   //input
   assign cuif.opcode = opcode_t'(dpif.imemload[31:26]);
   assign cuif.funct = funct_t'(dpif.imemload[5:0]);

   assign dpif.dmemaddr = alif.outport;
   assign dpif.dmemstore = rfif.rdat2;
   assign dpif.imemaddr = pcif.PCcurr;
   assign memREGdata = dpif.dmemload;
   

   
   //PC		
   assign npc = pcif.PCcurr + 4;
   


   //Register File 
   assign rfif.rsel1 = regbits_t'(dpif.imemload[25:21]);
   assign rfif.rsel2 = regbits_t'(dpif.imemload[20:16]);
   assign rfif.WEN = cuif.RegW;
   assign rfif.wsel = RegDst_out;
   assign rfif.wdat = MtR_out;


   always_comb begin
      if(cuif.regDest == 2'b10) begin
	 RegDst_out = 31;
      end
      else if (cuif.regDest == 2'b01) begin
	 RegDst_out = regbits_t'(dpif.imemload[15:11]);
      end
      else begin
	 RegDst_out = regbits_t'(dpif.imemload[20:16]);
	 
      end
   end // always_comb

   

   always_comb begin
      if(cuif.Mem == 2'b00) begin
	 MtR_out = alif.outport;
      end
      else if(cuif.Mem == 2'b01) begin
	 MtR_out = memREGdata;
      end
      else begin
	 MtR_out = npc;
      end
   end // always_comb

   
   always_comb begin
      if(cuif.lui == 1'b1) begin
	 Mux_lui = 0;
      end
      else begin
	 Mux_lui = rfif.rdat1;
      end
   end

   assign extout2 = (dpif.imemload[15]) ? {16'b1111111111111111, dpif.imemload[15:0]} : {16'b0000000000000000, dpif.imemload[15:0]};

   always_comb begin
      if(cuif.ALUsource == 1'b1) begin
	 ALUSrc_out = extout2;
      end
      else begin
	 ALUSrc_out = rfif.rdat2;
      end
   end
   
   assign alif.portA = Mux_lui;
   assign alif.portB = ALUSrc_out;
   assign alif.aluop = cuif.opcode_ALU;
     


   assign eif.imm = dpif.imemload[15:0];
   assign eif.ExtSel = cuif.ExtSel;
   
   
   
   
   
   
   always_comb begin
      if(alif.zero_flag == 1'b1 && cuif.Branch == 1'b1) begin
	 branch_out = 1'b1;
      end
      else if(alif.zero_flag == 1'b0 && cuif.BNE == 1'b1) begin
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
	 Baddr = {eif.extout[29:0], 2'b00} + npc;
      end
   end

   always_comb begin
      if(cuif.jump == 1'b1) begin
	 jump_out = {npc[31:28], dpif.imemload[25:0], 2'b00};
      end
      else begin
	 jump_out = Baddr;
      end
   end

   always_comb begin
      if(cuif.jr == 1'b0) begin
	 pcif.PCnext = jump_out;
      end
      else begin
	 pcif.PCnext = rfif.rdat1;
      end
   end
   
		      
   
   
   
endmodule // datapath
