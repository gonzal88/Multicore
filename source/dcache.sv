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
    
    assign hit = (((dcache_sel.tag == block1_tag[dcache_sel.idx]) && block1_valid[dcache_sel.idx]) || ((dcache_sel.tag == block2_tag[dcache_sel.idx]) && block2_valid[dcache_sel.idx])) ? 1'b1 : 1'b0 ;
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
            recent_block <= '{default:1'b1};
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
        casez (curr_state)
            IDLE: begin
                if (!hit && !(block1_dirty[dcache_sel.idx] || block2_dirty[dcache_sel.idx])) begin //miss and not dirty
                    hit_counter_next = hit_counter - 1;
                    next_state =  UPDATE1;
                end else if (!hit && (block1_dirty[dcache_sel.idx] || block2_dirty[dcache_sel.idx])) begin //miss and dirty
                    hit_counter_next = hit_counter - 1;
                    next_state = WB1;
                end else if (dcif.halt) begin
                    hit_counter_next = hit_counter;
                    next_state = FLUSHW1;
                end else begin
                    if (hit && (dcif.dmemWEN || dcif.dmemREN) begin
                        hit_counter_next = hit_counter + 1; // how to increment only on an initial hit? we can always increment in idle but decrement if we miss. but then the count maybe inflated if the data request doesn't change
                    end else begin
                        hit_counter_next = hit_counter;
                    end
                    next_state = IDLE;
                end
            end

            UPDATE1: begin
                hit_counter_next = hit_counter;
                if (!ccif.dwait[0]) begin
                    next_state = UPDATE2;
                end else begin
                    next_state = UPDATE1;
                end
            end

            UPDATE2: begin
                hit_counter_next = hit_counter;
                if (!ccif.dwait[0]) begin
                    next_state = IDLE;
                end else begin
                    next_state = UPDATE2;
                end
            end

            WB1: begin
                hit_counter_next = hit_counter;
                if (!ccif.dwait[0]) begin
                    next_state = WB2;
                end else begin
                    next_state = WB1;
                end
            end

            WB2: begin
                hit_counter_next = hit_counter;
                if (!ccif.dwait[0]) begin
                    next_state = UPDATE1;
                end else begin
                    next_state = WB2;
                end
            end

            FLUSHW1: begin
                hit_counter_next = hit_counter;
                if (!ccif.dwait[0]) begin
                    next_state = FLUSHW2;
                end else begin
                    next_state = FLUSHW1;
                end
            end

            FLUSHW2: begin
                hit_counter_next = hit_counter;
                if ((flush_count != 0) && (!ccif.dwait[0])) begin 
                    next_state = FLUSHW1;
                end else if ((flush_count == 0) && (!ccif.dwait[0])) begin //flush_count or flush_count_next?
                    next_state = FLUSHW_HIT;
                end else begin
                    next_state = FLUSHW2;
                end
            end

            FLUSHW_HIT: begin
                hit_counter_next = hit_counter;
                if (!ccif.dwait[0]) begin
                    next_state = IDLE;
                end else begin
                    next_state = FLUSHW_HIT;
                end
            end
        endcase
    end

    always_comb begin
        casez(curr_state)
            IDLE: begin
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

                next_recent_block = recent_block[dcache_sel.idx]; // value 0 means block 1 used most recently, value 1 means block 2 used most recently

                flush_count_next = flush_count;
            end

            UPDATE1: begin
                ccif.dREN = 1;
                ccif.dWEN = 0;
                ccif.dstore = 0;
                ccif.daddr = {dcif.dmemaddr[WORD_W-1:3], 1'b0, 1'b00}; // Could possibly also just leave byte offset as 00
                dcif.flushed = 0;

                if (recent_block[dcache_sel.idx] == 1) begin // if block 2 used most recently, evict block 1
                    next_block1_data1 = ccif.dload[0];
                    next_block1_data2 = block1_data2[dcache_set.idx];
                    next_block2_data1 = block2_data1[dcache_sel.idx];
                    next_block2_data2 = block2_data2[dcache_sel.idx];

                    next_block1_tag = block1_tag[dcache_sel.idx];
                    next_block2_tag = block2_tag[dcache_sel.idx];

                    next_block1_valid = 0;//Correct,right?  Don't want to switch to hit in the middle of block (can also just not update tag until UPDATE2. or both.)
                    next_block2_valid = block2_valid[dcache_sel.idx];
                end else begin // else if block 1 used most recently evict block 2
                    next_block1_data1 = block1_data1[dcache_sel.idx];
                    next_block1_data2 = block1_data2[dcache_set.idx];
                    next_block2_data1 = ccif.dload[0];
                    next_block2_data2 = block2_data2[dcache_sel.idx];

                    next_block1_tag = block1_tag[dcache_sel.idx];
                    next_block2_tag = block2_tag[dcache_sel.idx];

                    next_block1_valid = block1_valid[dcache_sel.idx];
                    next_block2_valid = 0;
                end     

                next_block1_dirty = block1_dirty[dcache_sel.idx];
                next_block2_dirty = block2_dirty[dcache_sel.idx];

                next_recent_block = recent_block[dcache_sel.idx];

                flush_count_next = flush_count;
            end

            UPDATE2: begin
                ccif.dREN = 1;
                ccif.dWEN = 0;
                ccif.dstore = 0;
                ccif.daddr = {dcif.dmemaddr[WORD_W-1:3], 1'b1, 1'b00}; // Could possibly also just leave byte offset as 00
                dcif.flushed = 0;

                if (recent_block[dcache_sel.idx] == 1) begin // if block 2 used most recently, evict block 1
                    next_block1_data1 = block1_data1[dcache_set.idx];
                    next_block1_data2 = ccif.dload[0];
                    next_block2_data1 = block2_data1[dcache_sel.idx];
                    next_block2_data2 = block2_data2[dcache_sel.idx];

                    next_block1_tag = dcache_sel.tag;
                    next_block2_tag = block2_tag[dcache_sel.idx];

                    next_block1_valid = 1;
                    next_block2_valid = block2_valid[dcache_sel.idx];
                end else begin // else if block 1 used most recently, evict block 2
                    next_block1_data1 = block1_data1[dcache_sel.idx];
                    next_block1_data2 = block1_data2[dcache_set.idx];
                    next_block2_data1 = block2_data2[dcache_sel.idx];
                    next_block2_data2 = ccif.dload[0];

                    next_block1_tag = block1_tag[dcache_sel.idx];
                    next_block2_tag = dcache_sel.tag;

                    next_block1_valid = block1_valid[dcache_sel.idx];
                    next_block2_valid = 1;
                end     

                next_block1_dirty = block1_dirty[dcache_sel.idx];
                next_block2_dirty = block2_dirty[dcache_sel.idx];

                next_recent_block = recent_block[dcache_sel.idx];

                flush_count_next = flush_count;
            end

            WB1: begin
                ccif.dREN = 0;
                ccif.dWEN = 1;
                dcif.flushed = 0;

                next_block1_data1 = block1_data1[dcache_sel.idx];
                next_block1_data2 = block1_data2[dcache_set.idx];
                next_block2_data1 = block2_data1[dcache_sel.idx];
                next_block2_data2 = block2_data2[dcache_sel.idx];

                next_block1_tag = block1_tag[dcache_sel.idx];
                next_block2_tag = block2_tag[dcache_sel.idx];

                next_block1_valid = block1_valid[dcache_sel.idx];
                next_block2_valid = block2_valid[dcache_sel.idx];

                if (recent_block[dcache_sel.idx] == 1) begin // if block 2 used most recently, wb block 1 WORD 1
                    ccif.dstore = block1_data1[dcache_sel.idx]; //curr block 1 WORD 1
                    ccif.daddr = {block1_tag[dcache_sel.idx], dcache_sel.idx, 1'b0, 1'b00}; //curr index block 1 tag + dcache_sel.idx + 1'b0 + byteoffset
                    next_block1_dirty = block1_dirty[dcache_sel.idx];
                    next_block2_dirty = block2_dirty[dcache_sel.idx];
                end else begin // else if block 1 used most recently, wb block 2 WORD 1
                    ccif.dstore = block2_data1[dcache_sel.idx]; //curr block 2 WORD1
                    ccif.daddr = {block2_tag[dcache_sel.idx], dcache_sel.idx, 1'b0, 1'b00}; //curr index block 2 tag + dcache_sel.idx + 1'b0 + byteoffset
                    next_block1_dirty = block1_dirty[dcache_sel.idx];
                    next_block2_dirty = block2_dirty[dcache_sel.idx];
                end

                next_recent_block = recent_block[dcache_sel.idx];

                flush_count_next = flush_count;
            end

            WB2: begin
                ccif.dREN = 0;
                ccif.dWEN = 1;
                dcif.flushed = 0;

                next_block1_data1 = block1_data1[dcache_sel.idx];
                next_block1_data2 = block1_data2[dcache_set.idx];
                next_block2_data1 = block2_data1[dcache_sel.idx];
                next_block2_data2 = block2_data2[dcache_sel.idx];

                next_block1_tag = block1_tag[dcache_sel.idx];
                next_block2_tag = block2_tag[dcache_sel.idx];

                next_block1_valid = block1_valid[dcache_sel.idx];
                next_block2_valid = block2_valid[dcache_sel.idx];

                if (recent_block[dcache_sel.idx] == 1) begin // if block 2 used most recently, wb block 1 WORD 2
                    ccif.dstore = block1_data2[dcache_sel.idx]; //curr block 1 WORD 2
                    ccif.daddr = {block1_tag[dcache_sel.idx], dcache_sel.idx, 1'b1, 1'b00}; //curr index block 1 tag + dcache_sel.idx + 1'b1 + byteoffset
                    next_block1_dirty = 0;
                    next_block2_dirty = block2_dirty[dcache_sel.idx];
                end else begin // else if block 1 used most recently, wb block 2 WORD 1
                    ccif.dstore = block2_data1[dcache_sel.idx]; //curr block 2 WORD1
                    ccif.daddr = {block2_tag[dcache_sel.idx], dcache_sel.idx, 1'b1, 1'b00}; //curr index block 2 tag + dcache_sel.idx + 1'b1 + byteoffset
                    next_block1_dirty = block1_dirty[dcache_sel.idx];
                    next_block2_dirty = 0;
                end

                next_recent_block = recent_block[dcache_sel.idx];

                flush_count_next = flush_count;
            end

            FLUSHW1: begin
            end

            FLUSHW2: begin
            end

            FLUSHW_HIT: begin
            end

            default: begin
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

                flush_count_next = flush_count;
            end

        endcase
    end

    //assign next_recent_block and remove from above
    //assign ccif.dmemload

endmodule
