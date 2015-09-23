/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  Request Unit for Single Cycle
*/

`ifndef REQUEST_UNIT_VH
 `define REQUEST_UNIT_VH
 `include "control_unit_if.vh"

module request_unit (input logic CLK, nRst, request_unit_if.re ruif);
   import cpu_types_pkg::*;
   control_unit_if cuif();

   control_unit control (cuif);
   
 
   assign ruif.PCen = (ruif.ihit && !ruif.dhit);  
   
   
   always_ff @(posedge CLK or negedge nRst) 
     begin
	if (!nRst) 
	  begin
	     ruif.dWEN <= 1'b0;
	     ruif.dREN <= 1'b0;
	     ruif.iREN <= 1'b0;
	  end
	else begin
	   if (ruif.halt)
	     begin
		ruif.dWEN <= 1'b0;
		ruif.dREN <= 1'b0;
		ruif.iREN <= 1'b0;
	     end
	   else if (ruif.dhit) 
	     begin
		ruif.dWEN <= 1'b0;
		ruif.dREN <= 1'b0;
		ruif.iREN <= 1'b1;
	     end
	   else 
	     begin
		ruif.dWEN <= cuif.Dwen;
		ruif.dREN <= cuif.Dren;
		ruif.iREN <= 1'b1;
	     end
	end // else: !if(!nRst)
     end // always_ff @
			
endmodule // request
`endif
