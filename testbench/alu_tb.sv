`include "alu_if.vh"

`timescale 1 ns / 1 ns

module alu_tb;
   import cpu_types_pkg::*;
   parameter PERIOD = 10;

   logic CLK = 0;
   always #(PERIOD/2) CLK++;
   
   alu_if rfif ();
   test PROG (CLK, rfif);

`ifndef MAPPED
   alu DUT(rfif);
`else
   alu DUT(
	   ./rfif.portA (rfif.portA),
	   ./rfif.portB (rfif.portB),
	   ./rfif.aluop (rfif.aluop),
	   ./rfif.outport (rfif.outport),
	   ./rfif.neg_flag (rfif.neg_flag),
	   ./rfif.over_flag (rfif.over_flag),
	   ./rfif.zero_flag (rfif.zero_flag)
	   );
`endif // !`ifndef MAPPED
endmodule // alu_tb

program test
  import cpu_types_pkg::*;
   
  (
   input logic CLK,
   alu_if.tb rfif
   );
   parameter PERIOD = 10;
   
   initial begin

      @(posedge CLK);
      rfif.aluop = ALU_ADD;
      rfif.portA = 32'b01111111111111111111111111111111;
      rfif.portB = 2;
      
      #(PERIOD)
      #(PERIOD)

      if(rfif.outport == 171) begin
	 $display("\n\nAdding Success\n\n");
	 
      end
      else begin 
	 $display("\n\nOverflow %d \n\n", rfif.over_flag);
      end

      @(posedge CLK);
      rfif.aluop = ALU_SUB;
      rfif.portA = 32'b10001010000000000000000000000000;
      rfif.portB = 32'b01011000000000000000000000000000;
      #(PERIOD)
      #(PERIOD)

      if(rfif.outport == 4294967225) begin
	 $display("\n\nSubtracting Success\n\n");
      end
      else begin
	 $display("\n\nOverflow %d \n\n", rfif.over_flag);
      end

      @(posedge CLK);
      rfif.aluop = ALU_AND;
      rfif.portA = 50;
      rfif.portB = 121;
      #(PERIOD)
      #(PERIOD)

      if(rfif.outport == 48) begin
	 $display("\n\nAnding Success\n\n");
      end
      else begin
	 $display("\n\nFAIL\n\n");
      end

      @(posedge CLK);
      rfif.aluop = ALU_OR;
      rfif.portA = 50;
      rfif.portB = 121;
      #(PERIOD)
      #(PERIOD)

      if(rfif.outport == 123) begin
	 $display("\n\nOring Success\n\n");
      end
      else begin
	 $display("\n\nFAIL\n\n");
      end

      @(posedge CLK);
      rfif.aluop = ALU_XOR;
      rfif.portA = 50;
      rfif.portB = 121;
      #(PERIOD)
      #(PERIOD)

      if(rfif.outport == 75) begin
	 $display("\n\nX-oring Success\n\n");
      end
      else begin
	 $display("\n\nFAIL\n\n");
      end

      @(posedge CLK);
      rfif.aluop = ALU_NOR;
      rfif.portA = 50;
      rfif.portB = 121;
      #(PERIOD)
      #(PERIOD)

      if(rfif.outport == 4294967172) begin
	 $display("\n\nNoring Success\n\n");
      end
      else begin
	 $display("\n\nFAIL\n\n");
      end

      @(posedge CLK);
      rfif.aluop = ALU_SLT;
      rfif.portB = 500000;
      rfif.portA = 121;
      #(PERIOD)
      #(PERIOD)

      if(rfif.outport == 1) begin
	 $display("\n\SLT Success\n\n");
      end
      else begin
	 $display("\n\nFAIL\n\n");
      end

      @(posedge CLK);
      rfif.aluop = ALU_SLTU;
      rfif.portB = 500000;
      rfif.portA = 121;
      #(PERIOD)
      #(PERIOD)

      if(rfif.outport == 1) begin
	 $display("\n\nSLTU Success\n\n");
      end
      else begin
	 $display("\n\nFAIL\n\n");
      end

      @(posedge CLK);
      rfif.aluop = ALU_SLL;
      rfif.portB = 5000000;
      rfif.portA = 121;
      #(PERIOD)
      #(PERIOD)

      if(rfif.outport == 0) begin
	 $display("\n\nSLL Success\n\n");
      end
      else begin
	 $display("\n\nFAIL\n\n");
      end

      @(posedge CLK);
      rfif.aluop = ALU_SRL;
      rfif.portB = 500000;
      rfif.portA = 121;
      #(PERIOD)
      #(PERIOD)

      if(rfif.outport == 0) begin
	 $display("\n\nSRL Success\n\n");
      end
      else begin
	 $display("\n\nFAIL\n\n");
      end


      $finish;

   end
	   
endprogram // test
   
