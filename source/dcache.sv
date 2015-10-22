/*
  Javier Gonzalez Souto && Cyrus Sutaria
  gonzal88@purdue.edu
  csutaria@purdue.edu 

  Dcache, obtains data that is sent to the datapath
  1 kbit = 1024 bit = 32 word
  2-way assoc.
  2 words/block
  8 set of 2 blocks of 2 words
 */
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

module dcache (
  input logic CLK, nRST,
  datapath_cache_if.dcache dcif,
  cache_control_if.dcache ccif
);
  import cpu_types_pkg::*;

  typedef enum logic [3:0] {IDLE, WB1, WB2, UPDATE1, UPDATE2, FLUSHW1, FLUSHW2, FLUSHW_HIT} StateType;
  StateType curr_state;
  StateType next_state;

  dcachef_t dcache_sel;

  word_t block1_data1 [7:0], block1_data2 [7:0], block2_data1 [7:0], block2_data2 [7:0];
  word_t next_block1_data1, next_block1_data2, next_block2_data1, next_block2_data2;
  logic [DTAG_W-1:0] block1_tag [7:0];
  logic [DTAG_W-1:0] next_block1_tag;
  logic [DTAG_W-1:0] block2_tag [7:0];
  logic [DTAG_W-1:0] next_block2_tag;
  logic [7:0] block1_valid;
  logic next_block1_valid;
  logic [7:0] block2_valid;
  logic next_block2_valid;
  logic [7:0] block1_dirty;
  logic next_block1_dirty;
  logic [7:0] block2_dirty;
  logic next_block2_dirty;
  logic [7:0] recent_block;
  logic next_recent_block;

  logic hit;
  word_t hit_counter, hit_counter_next;
  logic [3:0] flush_count;
  logic flush_count_next;

  assign dcache_sel = dcachef_t'(dcif.dmemaddr); //'
  
  assign hit = (((dcache_sel.tag == block1_tag[dcache_sel.idx]) && block1_valid) || ((dcache_sel.tag == block2_tag[dcache_sel.idx]) && block2_valid)) ? 1'b1 : 1'b0 ;
  assign dcif.dhit = hit;

  always_ff @(posedge CLK or negedge nRST) begin
    if (!nRST) begin
      curr_state <= IDLE;
      block1_data1 <= '{default:32'b0};
      block1_data2 <= '{default:32'b0};
      block2_data1 <= '{default:32'b0};
      block2_data2 <= '{default:32'b0};
      block1_tag <= '{default:26'b0};
      block2_tag <= '{default:26'b0};
      block1_valid <= '{default:1'b0};
      block2_valid <= '{default:1'b0};
      block1_dirty <= '{default:1'b0};
      block2_dirty <= '{default:1'b0};
      recent_block <= '{default:1'b0};
      hit_counter <= 32'b0;
      flush_count <= 4'd8;
    end else begin
      curr_state <= next_state;
      block1_data1[dcache_sel.idx] <= next_block1_data1;
      block1_data2[dcache_sel.idx] <= next_block1_data2;
      block2_data1[dcache_sel.idx] <= next_block2_data1;
      block2_data2[dcache_sel.idx] <= next_block2_data2;
      block1_tag[dcache_sel.idx] <= next_block1_tag;
      block2_tag[dcache_sel.idx] <= next_block2_tag;
      block1_valid[dcache_sel.idx] <= next_block1_valid;
      block2_valid[dcache_sel.idx] <= next_block2_valid;
      block1_dirty[dcache_sel.idx] <= next_block1_dirty;
      block2_dirty[dcache_sel.idx] <= next_block2_dirty;
      recent_block[dcache_sel.idx] <= next_recent_block;
      hit_counter <= hit_counter_next;
      flush_count <= flush_count_next;
    end
  end // always_ff @

  always_comb begin
    hit_counter_next = hit_counter;
    casez (curr_state)
      IDLE: begin
        if (!hit && !(block1_dirty[dcache_sel.idx] || block2_dirty[dcache_sel.idx])) begin //miss and not dirty
          next_state =  UPDATE1;
        end else if (!hit && (block1_dirty[dcache_sel.idx] || block2_dirty[dcache_sel.idx])) begin //miss and dirty
          next_state = WB1;
        end else if (dcif.halt) begin
          next_state = FLUSHW1;
        end else begin
          next_state = IDLE;
        end
      end

      UPDATE1: begin
        if (!ccif.dwait[0]) begin
          next_state = UPDATE2;
        end else begin
          next_state = UPDATE1;
        end
      end

      UPDATE2: begin
        if (!ccif.dwait[0]) begin
          next_state = IDLE;
        end else begin
          next_state = UPDATE2;
        end
      end

      WB1: begin
        if (!ccif.dwait[0]) begin
          next_state = WB2;
        end else begin
          next_state = WB1;
        end
      end

      WB2: begin
        if (!ccif.dwait[0]) begin
          next_state = UPDATE1;
        end else begin
          next_state = WB2;
        end
      end

      FLUSHW1: begin
        if (!ccif.dwait[0]) begin
          next_state = FLUSHW2;
        end else begin
          next_state = FLUSHW1;
        end
      end

      FLUSHW2: begin
        if ((flush_count != 0) && (!ccif.dwait[0])) begin 
          next_state = FLUSHW1;
        end else if ((flush_count == 0) && (!ccif.dwait[0])) begin //flush_count or flush_count_next?
          next_state = FLUSHW_HIT;
        end else begin
          next_state = FLUSHW2;
        end
      end

      FLUSHW_HIT: begin
        if (!ccif.dwait[0]) begin
          next_state = IDLE;
        end else begin
          next_state = FLUSHW_HIT;
        end
      end
    endcase
  end

  always_comb begin
    ccif.dREN = 0;
    ccif.dWEN = 0;
    ccif.dstore = 0;
    ccif.daddr = 0;
    dcif.flushed = 0;
    next_block1_data1 = block1_data1[dcache_sel.idx];
    next_block1_data2 = block1_data2[dcache_set.idx];
    next_block2_data1 = block2_data1[dcache_sel.idx];
    next_block2_data2 = block2_data2[dcache_sel.idx];
    next_block1_tag = block1_tag[dcache_sel.idx];
    next_block2_tag = block2_tag[dcache_sel.idx];
    next_block1_valid = block1_valid[dcache_sel.idx];
    next_block2_valid = block2_valid[dcache_sel.idx];
    next_block1_dirty = block1_dirty[dcache_sel.idx];
    next_block2_dirty = block2_dirty[dcache_sel.idx];
    next_recent_block = recent_block[dcache_sel.idx];
    hit_counter_next = hit_counter;
    flush_count_next = flush_count;
    casez(curr_state)
      IDLE: begin
        
      end
    endcase
  end

  //assign ccif.dmemload

endmodule
