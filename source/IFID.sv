/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  Instruction Fetch/Instruction Decode for Pipeline
*/


`include "cpu_types_pkg.vh"
`include "ifid_if.vh"

module ifid
(
 input logic CLK,
 input logic nRST,
	     ifid_if.fd ifd
 );

   import cpu_types_pkg::*;
   
   always_ff @(posedge CLK, negedge nRST) begin
      if (!nRST) begin
	 ifd.npc_o <= 0;
	 ifd.iload_o <= 0;		   
      end
      else begin
	 if (ifd.flush) begin
	    ifd.npc_o <= 0;
	    ifd.iload_o <= 0;
	 end
	 else  begin
	    if(ifd.iien) begin
	       ifd.npc_o <= ifd.npc_i;
	       ifd.iload_o <= ifd.iload_i;
	    end
	    else begin
	       ifd.npc_o <= ifd.npc_o;
	       ifd.iload_o <= ifd.iload_o;
	    end
	 end
      end
   end
   
endmodule
