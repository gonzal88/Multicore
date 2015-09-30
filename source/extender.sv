/*
  Javier Gonzalez Souto
  gonzal88@purdue.edu

  Extender for Single Cycle
*/
`include "extender_if.vh"

module extender (
	extender_if.ext eif
	);

always_comb begin
   casez (eif.ExtSel)//Coming from the control Unit
     2'b01://sign ext
       if (eif.imm[15] == 1'b0) begin
	  eif.extout = {16'b0000000000000000, eif.imm};
       end
     
       else begin
	  eif.extout = {16'b1111111111111111, eif.imm};
	  
       end
     2'b00:	//zero-extend
       eif.extout = {16'b0000000000000000, eif.imm};

     2'b10:
       eif.extout = {eif.imm, 16'b0000000000000000};
     
     default:  			//zero-extend
       eif.extout = {16'b0000000000000000, eif.imm};
     
   endcase // casez (eif.ExtSel)
end // always_comb begin
   
endmodule
