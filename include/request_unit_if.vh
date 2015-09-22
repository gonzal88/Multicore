`ifndef REQUEST_UNIT_IF_VH
 `define REQUEST_UNIT_IF_VH

 `include "cpu_types_pkg.vh"

interface request_unit_if;
   import cpu_types_pkg::*;
   
   logic DWen, DRen, IRen, dhit, ihit, dREN, dWEN, iREN, PCen, halt;

   
   
   modport re (
	       input  DWen, DRen, IRen, dhit, ihit, halt,
	       output dREN, dWEN, iREN, PCen
	       );

endinterface
`endif
