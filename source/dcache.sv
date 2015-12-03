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
    datapath_cache_if dcif,
    cache_control_if ccif
);
    import cpu_types_pkg::*;
/////////////////////////////////////////////////////////////////////////////////////////
    typedef enum logic [3:0] {IDLE, WB1, WB2, UPDATE1, UPDATE2, SNOOP1, SNOOP2, FLUSHB1W1, FLUSHB1W2, FLUSHB2W1, FLUSHB2W2} StateType;
/////////////////////////////////////////////////////////////////////////////////////////
    StateType curr_state;
    StateType next_state;
    StateType saved_state;
    StateType cc_saved_state;
    
    parameter CPUID = 0;
    dcachef_t dcache_sel;
    dcachef_t snoop_sel;

    word_t block1_data1 [7:0], block1_data2 [7:0], block2_data1 [7:0], block2_data2 [7:0];
    word_t next_block1_data1, next_block1_data2, next_block2_data1, next_block2_data2;
    logic [DTAG_W-1:0] block1_tag [7:0];
    /////////////////////////////////////////////////////////////////////////////////////////
    logic [DTAG_W-1:0] snoop1_tag [7:0];
    logic [DTAG_W-1:0] snoop2_tag [7:0];
    logic [DTAG_W-1:0] next_snoop1_tag;
    logic [DTAG_W-1:0] next_snoop2_tag;
    logic [7:0] snoop1_valid;
    logic next_snoop1_valid;
    logic next_snoop2_valid;
    logic [7:0] snoop2_valid;
    logic [7:0] snoop1_dirty;
    logic next_snoop1_dirty;
    logic next_snoop2_dirty;
    logic [7:0] snoop2_dirty;
    /////////////////////////////////////////////////////////////////////////////////////////
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
    logic hit1;
    logic hit2;

    logic snoop_hit, snoop_hit1, snoop_hit2;
   
    //word_t hit_counter, hit_counter_next;
    logic [2:0] flush_idx_count;
    logic [2:0] flush_idx_count_next;

    assign dcache_sel = dcachef_t'(dcif.dmemaddr); //'
    /////////////////////////////////////////////////////////////////////////////////////////
    assign snoop_sel = dcachef_t'(ccif.ccsnoopaddr); //'
    /////////////////////////////////////////////////////////////////////////////////////////
    
    assign hit1 = ((dcache_sel.tag == block1_tag[dcache_sel.idx]) && block1_valid[dcache_sel.idx]) ? 1'b1 : 1'b0; // || ((dcache_sel.tag == block2_tag[dcache_sel.idx]) && block2_valid[dcache_sel.idx])) ? 1'b1 : 1'b0 ;
    assign dcif.dhit = hit && (dcif.dmemWEN || dcif.dmemREN);
    assign hit = hit1 || hit2;
   
    assign hit2 = ((dcache_sel.tag == block2_tag[dcache_sel.idx]) && block2_valid[dcache_sel.idx]) ? 1'b1 : 1'b0;
   
    assign snoop_hit = snoop_hit1 || snoop_hit2;

    assign snoop_hit1 = ((snoop1_tag[snoop_sel.idx] == snoop_sel.tag) && snoop1_valid[snoop_sel.idx] ) && snoop1_dirty[snoop_sel.idx];
    assign snoop_hit2 = ((snoop2_tag[snoop_sel.idx] == snoop_sel.tag) && snoop2_valid[snoop_sel.idx] ) && snoop2_dirty[snoop_sel.idx];

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
            /////////////////////////////////////////////////////////////////////////////////////////
            snoop1_tag <= '{default:26'b0};
            snoop2_tag <= '{default:26'b0};
            snoop1_dirty <= '{default:1'b0};
            snoop2_dirty <= '{default:1'b0};
            snoop1_valid <= '{default:1'b0};
            snoop2_valid <= '{default:1'b0};
            /////////////////////////////////////////////////////////////////////////////////////////
            recent_block <= '{default:1'b1};
            flush_idx_count <= 3'd0;
            cc_saved_state <= IDLE;
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
            /////////////////////////////////////////////////////////////////////////////////////////
            snoop1_tag[snoop_sel.idx] <= next_snoop1_tag;
            snoop2_tag[snoop_sel.idx] <= next_snoop2_tag;
            snoop1_valid[snoop_sel.idx] <= next_snoop1_valid;
            snoop2_valid[snoop_sel.idx] <= next_snoop2_valid;
            snoop1_dirty[snoop_sel.idx] <= next_snoop1_dirty;
            snoop2_dirty[snoop_sel.idx] <= next_snoop2_dirty;
            /////////////////////////////////////////////////////////////////////////////////////////
            recent_block[dcache_sel.idx] <= next_recent_block;
            flush_idx_count <= flush_idx_count_next;
            cc_saved_state <= saved_state;
        end
    end // always_ff @

    always @ * begin
        flush_idx_count_next = flush_idx_count;
        casez (curr_state)
          IDLE: begin
            /////////////////////////////////////////////////////////////////////////////////////////
                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    next_state = SNOOP1;

                    saved_state = IDLE;
                end else if (hit && (dcif.dmemWEN ) && !((block1_dirty[dcache_sel.idx] && recent_block[dcache_sel.idx]) || (block2_dirty[dcache_sel.idx] && !recent_block[dcache_sel.idx]))) begin //miss and not dirty
                    next_state =  UPDATE1;
            /////////////////////////////////////////////////////////////////////////////////////////
                end else if (!hit && (dcif.dmemWEN || dcif.dmemREN) && !((block1_dirty[dcache_sel.idx] && recent_block[dcache_sel.idx]) || (block2_dirty[dcache_sel.idx] && !recent_block[dcache_sel.idx]))) begin //miss and not dirty
                    next_state =  UPDATE1;
                end else if (!hit && (dcif.dmemWEN || dcif.dmemREN) && (block1_dirty[dcache_sel.idx] && recent_block[dcache_sel.idx]) || (block2_dirty[dcache_sel.idx] && !recent_block[dcache_sel.idx])) begin //miss and dirty
                    next_state = WB1;
                end else if (dcif.halt) begin
                    next_state = FLUSHB1W1;
                end else begin
                    next_state = IDLE;
                end
            end

            UPDATE1: begin
            /////////////////////////////////////////////////////////////////////////////////////////
                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    next_state = SNOOP1;
                    saved_state = UPDATE1;
            /////////////////////////////////////////////////////////////////////////////////////////
                end else if (!ccif.dwait[CPUID]) begin
                    next_state = UPDATE2;
                end else begin
                    next_state = UPDATE1;
                end
            end

            UPDATE2: begin
            /////////////////////////////////////////////////////////////////////////////////////////
                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    next_state = SNOOP1;
                    saved_state = UPDATE2;
            /////////////////////////////////////////////////////////////////////////////////////////
                end else if (!ccif.dwait[CPUID]) begin
                    next_state = IDLE;
                end else begin
                    next_state = UPDATE2;
                end
            end

            WB1: begin
            /////////////////////////////////////////////////////////////////////////////////////////
                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    next_state = SNOOP1;
                    saved_state = WB1;
            /////////////////////////////////////////////////////////////////////////////////////////
                end else if (!ccif.dwait[CPUID]) begin
                    next_state = WB2;
                end else begin
                    next_state = WB1;
                end
            end

            WB2: begin
            /////////////////////////////////////////////////////////////////////////////////////////
                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    next_state = SNOOP1;
                    saved_state = WB2;
            /////////////////////////////////////////////////////////////////////////////////////////
                end else if (!ccif.dwait[CPUID]) begin
                    next_state = UPDATE1;
                end else begin
                    next_state = WB2;
                end
            end

            /////////////////////////////////////////////////////////////////////////////////////////
            SNOOP1: begin
                if (!ccif.dwait[CPUID]) begin
                    next_state = SNOOP2;
                end else begin
                    next_state = SNOOP1;
                end
            end

            SNOOP2: begin
                if (!ccif.dwait[CPUID]) begin
                    next_state = cc_saved_state;
                end else begin
                    next_state = SNOOP2;
                end
            end
            /////////////////////////////////////////////////////////////////////////////////////////


            FLUSHB1W1: begin
            /////////////////////////////////////////////////////////////////////////////////////////
                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    next_state = SNOOP1;
                    saved_state = FLUSHB1W1;
            /////////////////////////////////////////////////////////////////////////////////////////
                end else if (!(block1_valid[flush_idx_count] && block1_dirty[flush_idx_count])) begin
                    next_state = FLUSHB2W1;
                end else if (!ccif.dwait[CPUID]) begin
                    next_state = FLUSHB1W2;
                end else begin
                    next_state = FLUSHB1W1;
                end
            end

            FLUSHB1W2: begin
            /////////////////////////////////////////////////////////////////////////////////////////
                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    next_state = SNOOP1;
                    saved_state = FLUSHB1W2;
            /////////////////////////////////////////////////////////////////////////////////////////
                end else if (!ccif.dwait[CPUID]) begin
                    next_state = FLUSHB2W1;
                end else begin
                    next_state = FLUSHB1W2;
                end
            end

            FLUSHB2W1: begin
            /////////////////////////////////////////////////////////////////////////////////////////
                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    next_state = SNOOP1;
                    saved_state = FLUSHB2W1;
            /////////////////////////////////////////////////////////////////////////////////////////
                end else if (!(block2_valid[flush_idx_count] && block2_dirty[flush_idx_count])) begin
                    next_state = FLUSHB2W2;
                end else if (!ccif.dwait[CPUID]) begin
                    next_state = FLUSHB2W2;
                end else begin
                    next_state = FLUSHB2W1;
                end
            end

            FLUSHB2W2: begin
            /////////////////////////////////////////////////////////////////////////////////////////
                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    next_state = SNOOP1;
                    saved_state = FLUSHB2W2;
            /////////////////////////////////////////////////////////////////////////////////////////
                end else if (!(block2_valid[flush_idx_count] && block2_dirty[flush_idx_count])) begin
                    if (flush_idx_count != 3'd7) begin
                        next_state = FLUSHB1W1;
                        flush_idx_count_next = flush_idx_count + 3'd1;
                    end else begin
                        next_state = IDLE;
                    end
                end else if ((flush_idx_count != 3'd7) && (!ccif.dwait[CPUID])) begin 
                    next_state = FLUSHB1W1;
                    flush_idx_count_next = flush_idx_count + 3'd1;
                end else if ((flush_idx_count == 3'd7) && (!ccif.dwait[CPUID])) begin //flush_count or flush_count_next?
                    next_state = IDLE;
                end else begin
                    next_state = FLUSHB2W2;
                end
            end
        endcase
    end

    always @ * begin
        ccif.dREN[CPUID] = 0;
        ccif.dWEN[CPUID] = 0;
        ccif.dstore[CPUID] = 0;
        ccif.daddr[CPUID] = 0;
        ccif.cctrans[CPUID] = 0;
        ccif.ccwrite[CPUID] = 0;


        next_block1_data1 = block1_data1[dcache_sel.idx];
        next_block1_data2 = block1_data2[dcache_sel.idx];
        next_block2_data1 = block2_data1[dcache_sel.idx];
        next_block2_data2 = block2_data2[dcache_sel.idx];

        next_block1_tag = block1_tag[dcache_sel.idx];
        next_block2_tag = block2_tag[dcache_sel.idx];

        next_block1_valid = block1_valid[dcache_sel.idx];
        next_block2_valid = block2_valid[dcache_sel.idx];

        next_block1_dirty = block1_dirty[dcache_sel.idx];
        next_block2_dirty = block2_dirty[dcache_sel.idx];

        casez(curr_state)
            IDLE: begin
                ccif.dREN[CPUID] = 0;
                ccif.dWEN[CPUID] = 0;
                ccif.dstore[CPUID] = 0;
                ccif.daddr[CPUID] = 0;

                next_block1_tag = block1_tag[dcache_sel.idx];
                next_block2_tag = block2_tag[dcache_sel.idx];

                next_block1_valid = block1_valid[dcache_sel.idx];
                next_block2_valid = block2_valid[dcache_sel.idx];

                if (dcif.dmemWEN && ((dcache_sel.tag == block1_tag[dcache_sel.idx]) && block1_valid[dcache_sel.idx]) && (block1_dirty[dcache_sel.idx])) begin //block 1 hit
                    if (dcache_sel.blkoff == 1'b0) begin // word 1
                        next_block1_data1 = dcif.dmemstore;
                        next_block1_data2 = block1_data2[dcache_sel.idx];
                        next_block2_data1 = block2_data1[dcache_sel.idx];
                        next_block2_data2 = block2_data2[dcache_sel.idx];
                        next_block1_dirty = 1'b1;
                        next_block2_dirty = block2_dirty[dcache_sel.idx];
                    end else begin // word 2
                        next_block1_data1 = block1_data1[dcache_sel.idx];
                        next_block1_data2 = dcif.dmemstore;
                        next_block2_data1 = block2_data1[dcache_sel.idx];
                        next_block2_data2 = block2_data2[dcache_sel.idx];
                        next_block1_dirty = 1'b1;
                        next_block2_dirty = block2_dirty[dcache_sel.idx];
                    end
                    
                end else if (dcif.dmemWEN && ((dcache_sel.tag == block2_tag[dcache_sel.idx]) && block2_valid[dcache_sel.idx]) && (block2_dirty[dcache_sel.idx])) begin //block 2 hit
                    if (dcache_sel.blkoff == 1'b0) begin // word 1
                        next_block1_data1 = block1_data1[dcache_sel.idx];
                        next_block1_data2 = block1_data2[dcache_sel.idx];
                        next_block2_data1 = dcif.dmemstore;
                        next_block2_data2 = block2_data2[dcache_sel.idx];
                        next_block1_dirty = block1_dirty[dcache_sel.idx];
                        next_block2_dirty = 1'b1;
                    end else begin // word 2
                        next_block1_data1 = block1_data1[dcache_sel.idx];
                        next_block1_data2 = block1_data2[dcache_sel.idx];
                        next_block2_data1 = block2_data1[dcache_sel.idx];
                        next_block2_data2 = dcif.dmemstore;
                        next_block1_dirty = block1_dirty[dcache_sel.idx];
                        next_block2_dirty = 1'b1;
                    end
                end else begin //retain values
                    next_block1_data1 = block1_data1[dcache_sel.idx];
                    next_block1_data2 = block1_data2[dcache_sel.idx];
                    next_block2_data1 = block2_data1[dcache_sel.idx];
                    next_block2_data2 = block2_data2[dcache_sel.idx];
                    next_block1_dirty = block1_dirty[dcache_sel.idx];
                    next_block2_dirty = block2_dirty[dcache_sel.idx];
                end

                /////////////////////////////////////////////////////////////////////////////////////////
                /*
                if (~block1_dirty[dcache_sel.idx]) begin
                    ccif.cctrans[CPUID] = 1'b1;
                    ccif.ccwrite[CPUID] = 1'b1;
                end
                if (~block2_dirty[dcache_sel.idx]) begin
                    ccif.cctrans[CPUID] = 1'b1;
                    ccif.ccwrite[CPUID] = 1'b1;
                end
                */
                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b1;
                    ccif.ccwrite[CPUID] = 1'b1;
                end else if (ccif.ccwait[CPUID] && !snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b0;
                    ccif.ccwrite[CPUID] = 1'b1;
                end 

                /////////////////////////////////////////////////////////////////////////////////////////
                
            end

/////////////////////////////////////////////////////////////////////////////////////////
            SNOOP1: begin
                ccif.dREN[CPUID] = 1'b0;
                ccif.dWEN[CPUID] = 1'b0; ////////should not always be high only if need to write back to bus
                

                if ((snoop1_tag[snoop_sel.idx] == snoop_sel.tag) && snoop1_valid[snoop_sel.idx] ) begin
                    ccif.daddr[CPUID] = {ccif.ccsnoopaddr[CPUID][WORD_W-1:3], 1'b0, 2'b00};
                    ccif.dstore[CPUID] = block1_data1[snoop_sel.idx];
                    ccif.dWEN[CPUID] = 1'b1;
                    if(snoop1_dirty[snoop_sel.idx]) begin
                        ccif.ccwrite[CPUID] = 1'b1;
                        ccif.cctrans[CPUID] = 1'b1;
                    end else begin
                        if(ccif.ccinv[CPUID]) begin
                            ccif.ccwrite[CPUID] = 1'b1;
                            ccif.cctrans[CPUID] = 1'b1;
                        end else begin
                            ccif.ccwrite[CPUID] = 1'b1;
                            ccif.cctrans[CPUID] = 1'b0;
                        end
                    end
                end else if ((snoop2_tag[snoop_sel.idx] == snoop_sel.tag) && snoop2_valid[snoop_sel.idx]) begin
                    ccif.daddr[CPUID] = {ccif.ccsnoopaddr[CPUID][WORD_W-1:3], 1'b0, 2'b00};
                    ccif.dstore[CPUID] = block2_data1[snoop_sel.idx];
                    ccif.dWEN[CPUID] = 1'b1;
                    if(snoop2_dirty[snoop_sel.idx]) begin
                        ccif.ccwrite[CPUID] = 1'b1;
                        ccif.cctrans[CPUID] = 1'b1;
                    end else begin
                        if(ccif.ccinv[CPUID]) begin
                            ccif.ccwrite[CPUID] = 1'b1;
                            ccif.cctrans[CPUID] = 1'b1;
                        end else begin
                            ccif.ccwrite[CPUID] = 1'b1;
                            ccif.cctrans[CPUID] = 1'b0;
                        end
                    end
                end else begin
                    ccif.dWEN[CPUID] = 1'b0;
                    ccif.daddr[CPUID] = 0;
                    ccif.dstore[CPUID] = 0;
                    ccif.ccwrite[CPUID] = 1'b0;
                    ccif.cctrans[CPUID] = 1'b0;
                end
            end

            SNOOP2: begin//change dWEN here too
                ccif.dREN[CPUID] = 1'b0;
                ccif.dWEN[CPUID] = 1'b0;
                if ((snoop1_tag[snoop_sel.idx] == snoop_sel.tag) && snoop1_valid[snoop_sel.idx] ) begin
                    ccif.daddr[CPUID] = {ccif.ccsnoopaddr[CPUID][WORD_W-1:3], 1'b1, 2'b00};
                    ccif.dstore[CPUID] = block1_data2[snoop_sel.idx];
                    ccif.dWEN[CPUID] = 1'b1;
                    if(snoop1_dirty[snoop_sel.idx]) begin
                        ccif.ccwrite[CPUID] = 1'b1;
                        ccif.cctrans[CPUID] = 1'b1;
                    end else begin
                        if(ccif.ccinv[CPUID]) begin
                            ccif.ccwrite[CPUID] = 1'b1;
                            ccif.cctrans[CPUID] = 1'b1;
                        end else begin
                            ccif.ccwrite[CPUID] = 1'b1;
                            ccif.cctrans[CPUID] = 1'b0;
                        end
                    end
                end else if ((snoop2_tag[snoop_sel.idx] == snoop_sel.tag) && snoop2_valid[snoop_sel.idx]) begin
                    ccif.daddr[CPUID] = {ccif.ccsnoopaddr[CPUID][WORD_W-1:3], 1'b1, 2'b00};
                    ccif.dstore[CPUID] = block2_data2[snoop_sel.idx];
                    ccif.dWEN[CPUID] = 1'b1;
                    if(snoop2_dirty[snoop_sel.idx]) begin
                        ccif.ccwrite[CPUID] = 1'b1;
                        ccif.cctrans[CPUID] = 1'b1;
                    end else begin
                        if(ccif.ccinv[CPUID]) begin
                            ccif.ccwrite[CPUID] = 1'b1;
                            ccif.cctrans[CPUID] = 1'b1;
                        end else begin
                            ccif.ccwrite[CPUID] = 1'b1;
                            ccif.cctrans[CPUID] = 1'b0;
                        end
                    end
                end else begin
                    ccif.dWEN[CPUID] = 1'b0;
                    ccif.daddr[CPUID] = 0;
                    ccif.dstore[CPUID] = 0;
                    ccif.ccwrite[CPUID] = 1'b0;
                    ccif.cctrans[CPUID] = 1'b0;
                end
            end
/////////////////////////////////////////////////////////////////////////////////////////

            UPDATE1: begin
                ccif.dREN[CPUID] = 1;
                ccif.dWEN[CPUID] = 0;
                ccif.dstore[CPUID] = 0;
                ccif.daddr[CPUID] = {dcif.dmemaddr[WORD_W-1:3], 1'b0, 2'b00}; // Could possibly also just leave byte offset as 00

                if (recent_block[dcache_sel.idx] == 1) begin // if block 2 used most recently, evict block 1
                    if (!ccif.dwait[CPUID]) begin
                        next_block1_data1 = ccif.dload[CPUID];
                    end else begin
                        next_block1_data1 = block1_data1[dcache_sel.idx];
                    end

                    next_block1_data2 = block1_data2[dcache_sel.idx];
                    next_block2_data1 = block2_data1[dcache_sel.idx];
                    next_block2_data2 = block2_data2[dcache_sel.idx];

                    next_block1_tag = block1_tag[dcache_sel.idx];
                    next_block2_tag = block2_tag[dcache_sel.idx];

                    next_block1_valid = block1_valid[dcache_sel.idx];
                    next_block2_valid = block2_valid[dcache_sel.idx];
                end else begin // else if block 1 used most recently evict block 2
                    next_block1_data1 = block1_data1[dcache_sel.idx];
                    next_block1_data2 = block1_data2[dcache_sel.idx];
                    
                    if (!ccif.dwait[CPUID]) begin
                        next_block2_data1 = ccif.dload[CPUID];
                    end else begin
                        next_block2_data1 = block2_data1[dcache_sel.idx];
                    end
                    next_block2_data2 = block2_data2[dcache_sel.idx];

                    next_block1_tag = block1_tag[dcache_sel.idx];
                    next_block2_tag = block2_tag[dcache_sel.idx];

                    next_block1_valid = block1_valid[dcache_sel.idx];
                    next_block2_valid = block1_valid[dcache_sel.idx];
                end     

                next_block1_dirty = block1_dirty[dcache_sel.idx];
                next_block2_dirty = block2_dirty[dcache_sel.idx];

/////////////////////////////////////////////////////////////////////////////////////////
                ccif.cctrans[CPUID] = 1'b1;
                if (dcif.dmemWEN) begin
                    ccif.ccwrite[CPUID] = 1'b1;
                end else begin
                    ccif.ccwrite[CPUID] = 1'b0;
                end
/////////////////////////////////////////////////////////////////////////////////////////
                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b1;
                    ccif.ccwrite[CPUID] = 1'b1;
                end else if (ccif.ccwait[CPUID] && !snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b0;
                    ccif.ccwrite[CPUID] = 1'b1;
                end 

            end

            UPDATE2: begin
                ccif.dREN[CPUID] = 1;
                ccif.dWEN[CPUID] = 0;
                ccif.dstore[CPUID] = 0;
                ccif.daddr[CPUID] = {dcif.dmemaddr[WORD_W-1:3], 1'b1, 2'b00}; // Could possibly also just leave byte offset as 00
                next_block1_dirty = block1_dirty[dcache_sel.idx];
                next_block2_dirty = block2_dirty[dcache_sel.idx];

                if (recent_block[dcache_sel.idx] == 1) begin // if block 2 used most recently, evict block 1
                    next_block1_data1 = block1_data1[dcache_sel.idx];

                    if (!ccif.dwait[CPUID]) begin
                        next_block1_data2 = ccif.dload[CPUID];
                        next_block1_tag = dcache_sel.tag;
                        next_block1_valid = 1;
                        next_block1_dirty = 1;
                    end else begin
                        next_block1_data2 = block1_data2[dcache_sel.idx];
                        next_block1_tag = block1_tag[dcache_sel.idx];
                        next_block1_valid = block1_valid[dcache_sel.idx];
                    end

                    next_block2_data1 = block2_data1[dcache_sel.idx];
                    next_block2_data2 = block2_data2[dcache_sel.idx];

                    next_block2_tag = block2_tag[dcache_sel.idx];

                    next_block2_valid = block2_valid[dcache_sel.idx];
                end else begin // else if block 1 used most recently, evict block 2
                    next_block1_data1 = block1_data1[dcache_sel.idx];
                    next_block1_data2 = block1_data2[dcache_sel.idx];
                    next_block2_data1 = block2_data1[dcache_sel.idx];
                    if (!ccif.dwait[CPUID]) begin
                        next_block2_data2 = ccif.dload[CPUID];
                        next_block2_tag = dcache_sel.tag;
                        next_block2_valid = 1;
                        next_block2_dirty = 1;
                    end else begin
                        next_block2_data2 = block2_data2[dcache_sel.idx];
                        next_block2_tag = block2_tag[dcache_sel.idx];
                        next_block2_valid = block2_valid[dcache_sel.idx];
                    end

                    next_block1_tag = block1_tag[dcache_sel.idx];

                    next_block1_valid = block1_valid[dcache_sel.idx];
                end

                
////////////////////////////////////////////////////////////////////////
                ccif.cctrans[CPUID] = 1'b1;
                if (dcif.dmemWEN) begin
                    ccif.ccwrite[CPUID] = 1'b1;
                end else begin
                    ccif.ccwrite[CPUID] = 1'b0;
                end
////////////////////////////////////////////////////////////////////////
            end

            WB1: begin
                ccif.dREN[CPUID] = 0;
                ccif.dWEN[CPUID] = 1;

                next_block1_data1 = block1_data1[dcache_sel.idx];
                next_block1_data2 = block1_data2[dcache_sel.idx];
                next_block2_data1 = block2_data1[dcache_sel.idx];
                next_block2_data2 = block2_data2[dcache_sel.idx];

                next_block1_tag = block1_tag[dcache_sel.idx];
                next_block2_tag = block2_tag[dcache_sel.idx];

                next_block1_valid = block1_valid[dcache_sel.idx];
                next_block2_valid = block2_valid[dcache_sel.idx];

                if (recent_block[dcache_sel.idx] == 1) begin // if block 2 used most recently, wb block 1 WORD 1
                    ccif.dstore[CPUID] = block1_data1[dcache_sel.idx]; //curr block 1 WORD 1
                    ccif.daddr[CPUID] = {block1_tag[dcache_sel.idx], dcache_sel.idx, 1'b0, 2'b00}; //curr index block 1 tag + dcache_sel.idx + 1'b0 + byteoffset
                end else begin // else if block 1 used most recently, wb block 2 WORD 1
                    ccif.dstore[CPUID] = block2_data1[dcache_sel.idx]; //curr block 2 WORD1
                    ccif.daddr[CPUID] = {block2_tag[dcache_sel.idx], dcache_sel.idx, 1'b0, 2'b00}; //curr index block 2 tag + dcache_sel.idx + 1'b0 + byteoffset
                end
                next_block1_dirty = block1_dirty[dcache_sel.idx];
                next_block2_dirty = block2_dirty[dcache_sel.idx];

                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b1;
                    ccif.ccwrite[CPUID] = 1'b1;
                end else if (ccif.ccwait[CPUID] && !snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b0;
                    ccif.ccwrite[CPUID] = 1'b1;
                end 

            end

            WB2: begin
                ccif.dREN[CPUID] = 0;
                ccif.dWEN[CPUID] = 1;

                next_block1_data1 = block1_data1[dcache_sel.idx];
                next_block1_data2 = block1_data2[dcache_sel.idx];
                next_block2_data1 = block2_data1[dcache_sel.idx];
                next_block2_data2 = block2_data2[dcache_sel.idx];

                next_block1_tag = block1_tag[dcache_sel.idx];
                next_block2_tag = block2_tag[dcache_sel.idx];

                next_block1_valid = block1_valid[dcache_sel.idx];
                next_block2_valid = block2_valid[dcache_sel.idx];

                if (recent_block[dcache_sel.idx] == 1) begin // if block 2 used most recently, wb block 1 WORD 2
                    ccif.dstore[CPUID] = block1_data2[dcache_sel.idx]; //curr block 1 WORD 2
                    ccif.daddr[CPUID] = {block1_tag[dcache_sel.idx], dcache_sel.idx, 1'b1, 2'b00}; //curr index block 1 tag + dcache_sel.idx + 1'b1 + byteoffset
                    next_block1_dirty = 0;
                    next_block2_dirty = block2_dirty[dcache_sel.idx];
                end else begin // else if block 1 used most recently, wb block 2 WORD 2
                    ccif.dstore[CPUID] = block2_data2[dcache_sel.idx]; //curr block 2 WORD2
                    ccif.daddr[CPUID] = {block2_tag[dcache_sel.idx], dcache_sel.idx, 1'b1, 2'b00}; //curr index block 2 tag + dcache_sel.idx + 1'b1 + byteoffset
                    next_block1_dirty = block1_dirty[dcache_sel.idx];
                    next_block2_dirty = 0;
                end
            end

            FLUSHB1W1: begin
                ccif.dREN[CPUID] = 0;
                if (block1_valid[flush_idx_count] && block1_dirty[flush_idx_count]) begin
                    ccif.dWEN[CPUID] = 1;
                end else begin
                    ccif.dWEN[CPUID] = 0;
                end

                ccif.dstore[CPUID] = block1_data1[flush_idx_count];
                ccif.daddr[CPUID] = {block1_tag[flush_idx_count], flush_idx_count, 1'b0, 2'b00};

                next_block1_data1 = block1_data1[flush_idx_count];
                next_block1_data2 = block1_data2[flush_idx_count];
                next_block2_data1 = block2_data1[flush_idx_count];
                next_block2_data2 = block2_data2[flush_idx_count];

                next_block1_tag = block1_tag[flush_idx_count];
                next_block2_tag = block2_tag[flush_idx_count];

                next_block1_valid = block1_valid[flush_idx_count];
                next_block2_valid = block2_valid[flush_idx_count];

                next_block1_dirty = block1_dirty[flush_idx_count];
                next_block2_dirty = block2_dirty[flush_idx_count];     

                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b1;
                    ccif.ccwrite[CPUID] = 1'b1;
                end else if (ccif.ccwait[CPUID] && !snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b0;
                    ccif.ccwrite[CPUID] = 1'b1;
                end           
            end

            FLUSHB1W2: begin
                ccif.dREN[CPUID] = 0;
                if (block1_valid[flush_idx_count] && block1_dirty[flush_idx_count]) begin
                    ccif.dWEN[CPUID] = 1;
                end else begin
                    ccif.dWEN[CPUID] = 0;
                end

                ccif.dstore[CPUID] = block1_data2[flush_idx_count];
                ccif.daddr[CPUID] = {block1_tag[flush_idx_count], flush_idx_count, 1'b1, 2'b00};

                next_block1_data1 = block1_data1[flush_idx_count];
                next_block1_data2 = block1_data2[flush_idx_count];
                next_block2_data1 = block2_data1[flush_idx_count];
                next_block2_data2 = block2_data2[flush_idx_count];

                next_block1_tag = block1_tag[flush_idx_count];
                next_block2_tag = block2_tag[flush_idx_count];

                if (!ccif.dwait[CPUID]) begin
                    next_block1_valid = 0;
                end else begin
                    next_block1_valid = block1_valid[flush_idx_count];
                end
                next_block2_valid = block2_valid[flush_idx_count];

                next_block1_dirty = block1_dirty[flush_idx_count];
                next_block2_dirty = block2_dirty[flush_idx_count];

                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b1;
                    ccif.ccwrite[CPUID] = 1'b1;
                end else if (ccif.ccwait[CPUID] && !snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b0;
                    ccif.ccwrite[CPUID] = 1'b1;
                end
            end

            FLUSHB2W1: begin
                ccif.dREN[CPUID] = 0;
                if (block2_valid[flush_idx_count] && block2_dirty[flush_idx_count]) begin
                    ccif.dWEN[CPUID] = 1;
                end else begin
                    ccif.dWEN[CPUID] = 0;
                end

                ccif.dstore[CPUID] = block2_data1[flush_idx_count];
                ccif.daddr[CPUID] = {block2_tag[flush_idx_count], flush_idx_count, 1'b0, 2'b00};

                next_block1_data1 = block1_data1[flush_idx_count];
                next_block1_data2 = block1_data2[flush_idx_count];
                next_block2_data1 = block2_data1[flush_idx_count];
                next_block2_data2 = block2_data2[flush_idx_count];

                next_block1_tag = block1_tag[flush_idx_count];
                next_block2_tag = block2_tag[flush_idx_count];

                next_block1_valid = block1_valid[flush_idx_count];
                next_block2_valid = block2_valid[flush_idx_count];

                next_block1_dirty = block1_dirty[flush_idx_count];
                next_block2_dirty = block2_dirty[flush_idx_count]; 

                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b1;
                    ccif.ccwrite[CPUID] = 1'b1;
                end else if (ccif.ccwait[CPUID] && !snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b0;
                    ccif.ccwrite[CPUID] = 1'b1;
                end
            end

            FLUSHB2W2: begin
                ccif.dREN[CPUID] = 0;
                if (block2_valid[flush_idx_count] && block2_dirty[flush_idx_count]) begin
                    ccif.dWEN[CPUID] = 1;
                end else begin
                    ccif.dWEN[CPUID] = 0;
                end

                ccif.dstore[CPUID] = block2_data2[flush_idx_count];
                ccif.daddr[CPUID] = {block2_tag[flush_idx_count], flush_idx_count, 1'b1, 2'b00};

                next_block1_data1 = block1_data1[flush_idx_count];
                next_block1_data2 = block1_data2[flush_idx_count];
                next_block2_data1 = block2_data1[flush_idx_count];
                next_block2_data2 = block2_data2[flush_idx_count];

                next_block1_tag = block1_tag[flush_idx_count];
                next_block2_tag = block2_tag[flush_idx_count];

                next_block1_valid = block1_valid[flush_idx_count];
                if (!ccif.dwait[CPUID]) begin
                    next_block2_valid = 0;
                end else begin
                    next_block2_valid = block2_valid[flush_idx_count];
                end

                next_block1_dirty = block1_dirty[flush_idx_count];
                next_block2_dirty = block2_dirty[flush_idx_count];

                if (ccif.ccwait[CPUID] && snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b1;
                    ccif.ccwrite[CPUID] = 1'b1;
                end else if (ccif.ccwait[CPUID] && !snoop_hit) begin
                    ccif.dWEN[CPUID] = 1'b0;
                    ccif.ccwrite[CPUID] = 1'b1;
                end
            end
        endcase
        /////////////////////////////////////////////////////////////////////////////////////////
        next_snoop1_tag = next_block1_tag;
        next_snoop2_tag = next_block2_tag;
        next_snoop1_dirty = next_block1_dirty;
        next_snoop2_dirty = next_block2_dirty;
        next_snoop1_valid = next_block1_valid;
        next_snoop2_valid = next_block2_valid;
        /////////////////////////////////////////////////////////////////////////////////////////

    end

    //assign next_recent_block
    always_comb begin
        next_recent_block = recent_block[dcache_sel.idx];
        if (hit && (dcif.dmemREN || dcif.dmemWEN)) begin
            if ((block1_tag[dcache_sel.idx] == dcache_sel.tag) && block1_valid[dcache_sel.idx]) begin
                next_recent_block = 1'b0;
            end else if ((block2_tag[dcache_sel.idx] == dcache_sel.tag) && block2_valid[dcache_sel.idx]) begin
                next_recent_block = 1'b1;
            end else begin
                next_recent_block = recent_block[dcache_sel.idx];
            end
        end else begin
            next_recent_block = recent_block[dcache_sel.idx];
        end
    end

    //assign dcif.dmemload
    always_comb begin
        dcif.dmemload = block1_data1[dcache_sel.idx];
        if ((block2_tag[dcache_sel.idx] == dcache_sel.tag)) begin
            if (dcache_sel.blkoff == 1'b1) begin
                dcif.dmemload = block2_data2[dcache_sel.idx];
            end else begin
                dcif.dmemload = block2_data1[dcache_sel.idx];
            end
        end else begin
            if (dcache_sel.blkoff == 1'b1) begin
                dcif.dmemload = block1_data2[dcache_sel.idx];
            end else begin
                dcif.dmemload = block1_data1[dcache_sel.idx];
            end
        end
    end

   assign dcif.flushed = ((flush_idx_count == 3'd7) && (curr_state == IDLE)) ? 1'b1: 1'b0;

endmodule
