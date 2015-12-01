
`include "cpu_types_pkg.vh"
`include "program_counter_if.vh"

module program_counter(
	  program_counter_if.pc pcif,
	  input logic CLK, 	
	  input logic nRST
	  );
   
   import cpu_types_pkg::*;
   parameter PC_INIT = 0;
   
   always_ff @(posedge CLK or negedge nRST) begin
      
      if (!nRST) begin
	 pcif.PCcurr <= PC_INIT;
      end
      
      else begin
	 if (pcif.PCen) begin
	    pcif.PCcurr <= pcif.PCnext;
	 end
      end      
   end // always_ff @ (posedge CLK or negedge nRST)
   
endmodule
