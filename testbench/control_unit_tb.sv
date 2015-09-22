`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

module control_unit_tb;
   import cpu_types_pkg::*;
   
   parameter PERIOD = 10;
   logic CLK = 0;
   
   always #(PERIOD/2) CLK++;
   
   //interface
   control_unit_if cuif ();
   
   test PROG (cuif, CLK);
   
`ifndef MAPPED
   control_unit DUT(cuif);
`else
   control_unit DUT(
  		    .\cuif.opcode (cuif.opcode),
  		    .\cuif.funct (cuif.funct),
  		    .\cuif.zero_flag (cuif.zero_flag),
		    .\cuif.over_flag (cuif.over_flag),
  		    .\cuif.halt (cuif.halt),
  		    .\cuif.IRen (cuif.IRen),
  		    .\cuif.DWen (cuif.DWen),
  		    .\cuif.DRen (cuif.DRen),
  		    .\cuif.jump (cuif.jump),
		    .\cuif.jr (cuif.jr),
		    .\cuif.lui (cuif.lui),
  		    .\cuif.Branch (cuif.Branch),
  		    .\cuif.opcode_ALU (cuif.opcode_ALU),
  		    .\cuif.RegW (cuif.RegW),
  		    .\cuif.ExtSel (cuif.ExtSel),
  		    .\cuif.Mem (cuif.Mem),
  		    .\cuif.ALUsource (cuif.ALUsource),
  		    .\cuif.regDest (cuif.regDest),
		    .\cuif.BNE (cuif.BNE),
  		    );
`endif
   
   
endmodule

program test
  
  (
   control_unit_if.control cuif,
   input logic CLK
   );
   import cpu_types_pkg::*;
   
   parameter PERIOD = 10;
   
   initial begin
      @(posedge CLK); 
      $display("RTYPE - SLL");
      cuif.opcode = RTYPE;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_SLL && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("SLL PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
            
      @(posedge CLK);
      $display("RTYPE - SRL");
      cuif.opcode = RTYPE;
      cuif.funct = SRL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_SRL && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("SRL PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("RTYPE - JR");
      cuif.opcode = RTYPE;
      cuif.funct = JR;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b1 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_ADD && cuif.RegW == 1'b0 && cuif.lui == 1'b0 && cuif.jr == 1'b1) begin
	 $display("JR PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("RTYPE - ADD");
      cuif.opcode = RTYPE;
      cuif.funct = ADD;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_ADD && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("ADD PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("RTYPE - ADDU");
      cuif.opcode = RTYPE;
      cuif.funct = ADDU;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_ADD && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("ADDU PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("RTYPE - SUB");
      cuif.opcode = RTYPE;
      cuif.funct = SUB;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_SUB && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("SUB PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("RTYPE - SUBU");
      cuif.opcode = RTYPE;
      cuif.funct = SUBU;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_SUB && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("SUBU PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("RTYPE - AND");
      cuif.opcode = RTYPE;
      cuif.funct = AND;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_AND && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("AND PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("RTYPE - OR");
      cuif.opcode = RTYPE;
      cuif.funct = OR;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_OR && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("OR PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("RTYPE - XOR");
      cuif.opcode = RTYPE;
      cuif.funct = XOR;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_XOR && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("XOR PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("RTYPE - NOR");
      cuif.opcode = RTYPE;
      cuif.funct = NOR;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_NOR && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("NOR PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("RTYPE - SLT");
      cuif.opcode = RTYPE;
      cuif.funct = SLT;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_SLT && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("SLT PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("RTYPE - SLTU");
      cuif.opcode = RTYPE;
      cuif.funct = SLTU;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_SLTU && cuif.RegW == 1'b1 && cuif.regDest == 2'b00 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("SLTU PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("J");
      cuif.opcode = J;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b1 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_ADD && cuif.RegW == 1'b0 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("J PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("JAL");
      cuif.opcode = JAL;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b1 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b10 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_ADD && cuif.RegW == 1'b1 && cuif.regDest == 2'b10 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("JAL PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("BEQ");
      cuif.opcode = BEQ;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b1 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_SUB && cuif.RegW == 1'b0 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("BEQ PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("BNE");
      cuif.opcode = BNE;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b1 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_SUB && cuif.RegW == 1'b0 && cuif.lui == 1'b0 && cuif.jr == 1'b0 && cuif.BNE == 1'b1) begin
	 $display("BNE PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("ADDI");
      cuif.opcode = ADDI;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b1 && cuif.opcode_ALU == ALU_ADD && cuif.RegW == 1'b1 && cuif.ExtSel == 2'b01 && cuif.regDest == 2'b01 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("ADDI PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("ADDIU");
      cuif.opcode = ADDIU;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b1 && cuif.opcode_ALU == ALU_ADD && cuif.RegW == 1'b1 && cuif.ExtSel == 2'b01 && cuif.regDest == 2'b01 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("ADDIU PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("SLTI");
      cuif.opcode = SLTI;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b1 && cuif.opcode_ALU == ALU_SLT && cuif.RegW == 1'b1 && cuif.ExtSel == 2'b01 && cuif.regDest == 2'b01 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("SLTI PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("SLTIU");
      cuif.opcode = SLTIU;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b1 && cuif.opcode_ALU == ALU_SLTU && cuif.RegW == 1'b1 && cuif.ExtSel == 2'b01 && cuif.regDest == 2'b01 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("SLTIU PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      
      @(posedge CLK); 
      $display("ANDI");
      cuif.opcode = ANDI;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b1 && cuif.opcode_ALU == ALU_AND && cuif.RegW == 1'b1 && cuif.ExtSel == 2'b00 && cuif.regDest == 2'b01 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("ANDI PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("ORI");
      cuif.opcode = ORI;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b1 && cuif.opcode_ALU == ALU_OR && cuif.RegW == 1'b1 && cuif.ExtSel == 2'b00 && cuif.regDest == 2'b01 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("ORI PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("XORI");
      cuif.opcode = XORI;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b1 && cuif.opcode_ALU == ALU_XOR && cuif.RegW == 1'b1 && cuif.ExtSel == 2'b00 && cuif.regDest == 2'b01 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("XORI PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("LUI");
      cuif.opcode = LUI;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b1 && cuif.opcode_ALU == ALU_ADD && cuif.RegW == 1'b1 && cuif.ExtSel == 2'b10 && cuif.regDest == 2'b01 && cuif.lui == 1'b1 && cuif.jr == 1'b0) begin
	 $display("LUI PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("LW");
      cuif.opcode = LW;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b1 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b01 && cuif.ALUsource == 1'b1 && cuif.opcode_ALU == ALU_ADD && cuif.RegW == 1'b1 && cuif.ExtSel == 2'b01 && cuif.regDest == 2'b01 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("LW PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("SW");
      cuif.opcode = SW;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b1 && cuif.Iren == 1'b1 && cuif.halt == 1'b0 && cuif.Mem == 2'b00 && cuif.ALUsource == 1'b1 && cuif.opcode_ALU == ALU_ADD && cuif.RegW == 1'b0 && cuif.ExtSel == 2'b01 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("SW PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      @(posedge CLK); 
      $display("HALT");
      cuif.opcode = HALT;
      cuif.funct = SLL;
      cuif.over_flag = 1'b0;
      cuif.zero_flag = 1'b0;
      #(PERIOD)
      if(cuif.jump == 1'b0 && cuif.Branch == 1'b0 && cuif.Dren == 1'b0 && cuif.Dwen == 1'b0 && cuif.Iren == 1'b0 && cuif.halt == 1'b1 && cuif.ALUsource == 1'b0 && cuif.opcode_ALU == ALU_ADD && cuif.RegW == 1'b0 && cuif.lui == 1'b0 && cuif.jr == 1'b0) begin
	 $display("HALT PASSED");
      end
      else begin
	 $display("FAILED");
      end
      
      $finish;
      
   end
   
endprogram
