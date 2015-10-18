/*
  Javier Gonzalez Souto && Cyrus Sutaria
  gonzal88@purdue.edu 

  Icache, obtains instructions that are sent to the datapath
 */

`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

module icache (
	       input logic CLK, nRST,
	       datapath_cache_if icif,
	       cache_control_if ccif
   );
   import cpu_types_pkg::*;

   typedef enum 	   logic {IDLE, FETCH} StateType;
   StateType curr_State;
   StateType next_State;

   icachef_t icache_iaddr;

   word_t[15:0] WordBlk, next_WordBlk;
   logic [ITAG_W-1:0][15:0] Tag, nextTag;
   int 	      i;
   logic 	      next_valid;

   assign icache_iaddr = icif.imemaddr;
   assign icif.ihit = ((icache_iaddr.tag == Tag[icache_iaddr.idx]) && icif.imemREN && Valid[icache_iaddr.idx]) ? 1'b1 : 1'b0;

   always_ff @(posedge CLK or negedge nRST) begin
      if(!nRST) begin
	 icif.imemload = 0;
	 ccif.iREN = 1'b0;
	 ccif.iaddr = 0;
	 for (i=0, i<16, i++) begin
	    Tag[i] = 0;
	    WordBlk = 0;
	 end
      end
   end // always_ff @
endmodule
	    

   

   
   
   
   
