/*
  Javier Gonzalez Souto && Cyrus Sutaria
  gonzal88@purdue.edu
  csutaria@purdue.edu 

  Icache, obtains instructions that are sent to the datapath
  Direct mapped, 1 word per block
 */

`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

module icache (
  input logic CLK, nRST,
  datapath_cache_if.icache dcif,
  cache_control_if.icache ccif
);
  import cpu_types_pkg::*;

  typedef enum logic {IDLE, UPDATE} ReadStateType;
  ReadStateType curr_read_state;
  ReadStateType next_read_state;

  icachef_t icache_sel;

  word_t block_data[15:0];
  word_t next_block_data;
  logic [ITAG_W-1:0] block_tag[15:0]; //May have to switch these index dimension orderings. Pretty sure from SV spec its fine.
  logic [ITAG_W-1:0] next_block_tag;
  logic block_valid[15:0];
  logic next_block_valid;

  logic update_block, hit;

  assign icache_sel = icachef_t'(dcif.imemaddr); //'
  assign hit = ((icache_sel.tag == block_tag[icache_sel.idx]) && (block_valid[icache_sel.idx]) && (dcif.imemREN)) ? ~ccif.iwait : 1'b0 ;

  always_ff @(posedge CLK or negedge nRST) begin
    if(!nRST) begin
      block_data <= '{default:32'b0};
      block_tag <= '{default:26'b0};
      block_valid <= '{default:1'b0};
      curr_read_state <= IDLE;
    end else begin
      block_data[icache_sel.idx] <= next_block_data;
      block_tag[icache_sel.idx] <= next_block_tag;
      block_valid[icache_sel.idx] <= next_block_valid;
      curr_read_state <= next_read_state;
    end
  end // always_ff @

  always_comb begin
     update_block = 1'b1;
     
    next_block_data = block_data[icache_sel.idx];
    next_block_tag = block_tag[icache_sel.idx];
    next_block_valid = block_valid[icache_sel.idx];

    next_read_state = curr_read_state;

    casez (curr_read_state)
      IDLE: begin
        update_block = 1'b0;

        next_block_data = block_data[icache_sel.idx];
        next_block_tag = block_tag[icache_sel.idx];
        next_block_valid = block_valid[icache_sel.idx];

        if (!hit && dcif.imemREN) begin // cache miss!
          next_read_state = UPDATE;
        end else begin
          next_read_state = IDLE;
        end
      end

      UPDATE: begin
        update_block = 1'b1;
	
        if (!ccif.iwait) begin // no longer waiting for RAM
          next_block_data = ccif.iload;
          next_block_tag = icache_sel.tag;
          next_block_valid = 1'b1;

          next_read_state = IDLE;
        end else if (!dcif.imemREN) begin
	   next_read_state = IDLE;
	end else begin // else keep waiting for the RAM
          next_read_state = UPDATE;
        end
      end

    endcase
  end

  assign dcif.imemload = block_data[icache_sel.idx];
  assign dcif.ihit = hit;

  assign ccif.iREN = update_block;
  assign ccif.iaddr = dcif.imemaddr;

endmodule
