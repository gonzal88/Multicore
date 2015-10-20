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

  typedef enum logic [3:0] {IDLE, WRITE, WRITE1, WRITE2, READ, READ1, READ2, LAST_WRITE} StateType;
  StateType curr_state;
  StateType next_state;

  dcachef_t dcache_sel;
  word_t block1_data1 [7:0], block1_data2 [7:0], block2_data1 [7:0], block2_data2 [7:0];
  word_t next_block1_data1, next_block1_data2, next_block2_data1, next_block2_data2;
  logic [DTAG_W-1:0] block1_tag [7:0];
  logic [DTAG_W-1:0] next_block1_tag;
  logic [DTAG_W-1:0] block2_tag [7:0];
  logic [DTAG_W-1:0] next_block2_tag;
  logic block1_valid [7:0];
  logic next_block1_valid;
  logic block2_valid [7:0];
  logic next_block2_valid;
  logic block1_dirty [7:0];
  logic next_block1_dirty;
  logic block2_dirty [7:0];
  logic next_block2_dirty;
  logic block1_recent[7:0];
  logic next_block1_recent;
  logic block2_recent[7:0];
  logic next_block2_recent;
  logic update_block1, update_block2, hit;
  word_t hit_counter, hit_counter_next;

  assign dcache_sel = dcachef_t'(dcif.dmemaddr); //'
  assign hit = (((dcache_sel.tag == block1_tag[dcache_sel.idx]) && block1_valid) || ((dcache_sel.tag == block2_tag[dcache_sel.idx]) && block2_valid)) ? 1'b1 : 1'b0 ;
  assign dcif.dhit = hit;

  always_ff @(posedge CLK or negedge nRST) begin
    if (!nRST) begin
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
      block1_recent <= '{default:1'b0};
      block2_recent <= '{default:1'b0};
      curr_state <= IDLE;
      hit_counter <= 32'b0;
    end else begin
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
      block1_recent[dcache_sel.idx] <= next_block1_recent;
      block2_recent[dcache_sel.idx] <= next_block2_recent;
      curr_state <= next_state;
      hit_counter <= hit_counter_next;
    end
  end // always_ff @

  always_comb begin
    casez (curr_state)
      IDLE: begin
        if (dcif.dmemREN) begin
          next_state = READ;
        end
        else if (dcif.dmemWEN) begin
          next_state = WRITE;
        end else begin
          next_state = IDLE;
        end
      end

      READ: begin
        if(hit) begin
          next_state = IDLE;
        end
        else if (!dhit && ((block1_dirty[dcache_sel.idx] && !block1_recent[dcache_sel.idx]) || (block2_dirty[dcache_sel.idx] && !block2_recent[dcache_sel.idx])) begin
          next_state = WRITE1;
        end
        else if (!dhit) begin      
          next_state = READ1;
        end else begin
          next_state = READ;
        end
      end

      READ1: begin
        if (!ccif.dwait) begin
          next_state = READ2;
        end else begin
          next_state = READ1;
        end
      end

      READ2: begin
        if (!ccif.dwait) begin
          next_state = IDLE;
        end else begin
          next_state = READ2;
        end
      end

      WRITE: begin
        if (hit) begin
          next_state = IDLE;
        end
        else if (!dhit && (block1_dirty[dcache_sel.idx] || block2_dirty[dcache_sel.idx])) begin
          next_state = LAST_WRITE;
        end
        else if (!dhit && (!block1_dirty[dcache_sel.idx] && !block2_dirty[dcache_sel.idx])) begin
          next_state = WRITE1;
        end
        else begin
          next_state = WRITE;
        end
      end

      WRITE1: begin
        if (!ccif.dwait) begin
          next_state = WRITE2;
        end else begin
          next_state = WRITE1;
        end
      end

      WRITE2: begin
        if (!ccif.dwait && dcif.dmemWEN) begin
          next_state = LAST_WRITE;
        end
        else if(!ccif.dwait && dcif.dmemREN) begin
          next_state = READ1;
        end
        else begin
          next_state = WRITE2;
        end
      end

      LAST_WRITE: begin
        if(hit) begin
          next_state = IDLE;
        end else begin
          next_state = LAST_WRITE;
        end
      end
    endcase
  end

  always_comb begin
    
  end

endmodule
