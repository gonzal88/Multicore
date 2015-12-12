/*
    Javier Gonzalez Souto && Cyrus Sutaria
    gonzal88@purdue.edu
    csutaria@purdue.edu 

    Cache coherency controller
 */

`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

module coherency_controller (
    input logic CLK, nRST,
    cache_control_if.cc ccif
);
    import cpu_types_pkg::*;

    typedef enum logic [2:0] {IDLE, IST, WST, SNOOP, C2C, M2C} StateType;
    StateType curr_state;
    StateType next_state;

    logic cpu_sel, next_cpu_sel;

    always_ff @(posedge CLK or negedge nRST) begin
        if (!nRST) begin
            curr_state <= IDLE;
            cpu_sel <= 0;
        end else begin
            curr_state <= next_state;
            cpu_sel <= next_cpu_sel;
        end
    end

    always @ * begin
        next_cpu_sel = cpu_sel;
        casez (curr_state)
            IDLE: begin
                // modify so that cpu_sel has priority but if only ~cpu_sel has a request that should work too.
                if (ccif.cctrans[cpu_sel] && ccif.dREN[cpu_sel]) begin
                    next_state = SNOOP;
                end else if (ccif.cctrans[~cpu_sel] && ccif.dREN[~cpu_sel]) begin
                    next_cpu_sel = ~cpu_sel; //Now cpu_sel is always the requestor once out of IDLE
                    next_state = SNOOP;
                end else if (ccif.dWEN[cpu_sel]) begin
                    next_state = WST;
                end else if (ccif.dWEN[~cpu_sel]) begin
                    next_cpu_sel = ~cpu_sel; //Now cpu_sel is always the requestor once out of IDLE
                    next_state = WST;
		end else if (ccif.iREN[cpu_sel]) begin
                    next_state = IST;
                end else if (ccif.iREN[~cpu_sel]) begin
                    next_cpu_sel = ~cpu_sel; //Now cpu_sel is always the requestor once out of IDLE. works for 2 cores but with more we could do so with small changes. (cpu_sel + 1) ??? should we do that? would overflow and wrap around properly?
                    next_state = IST;
                end else begin
                    next_state = IDLE;
                end
            end

            IST: begin
                if (!ccif.iREN[cpu_sel]) begin //since cpu_sel is the requestor in this state this is now correct again. only was checking for cpu_sel.
                    next_state = IDLE;
                    next_cpu_sel = ~cpu_sel; //switch arbitrarily whenever we go back to idle
                end else begin
                    next_state = IST;
                end
            end

            WST: begin
                if (!ccif.dWEN[cpu_sel]) begin //// add &&((ramstate == ACCESS) || (ramstate == FREE)) or somehting like that?
                    next_state = IDLE;
                    next_cpu_sel = ~cpu_sel;
                end else begin
                    next_state = WST;
		        end
            end

            SNOOP: begin
                if (ccif.dWEN[~cpu_sel] && ccif.ccwrite[~cpu_sel]) begin //dWEN and ccwrite are high if the responder is writing back to bus
                    next_state = C2C; // actually transferring the data _INSIDE_ C2C state
                end else if (~ccif.dWEN[~cpu_sel] && ccif.ccwrite[~cpu_sel]) begin //otherwise the data is coming from memory
                    next_state = M2C;
                end else begin // 
                    next_state = SNOOP;
                end
            end

            C2C: begin
                if (!ccif.dREN[cpu_sel]) begin // actually want to trigger after word 2. add a counter or add states
                    next_state = IDLE;
                    next_cpu_sel = ~cpu_sel;
                end else begin
                    next_state = C2C;
                end
            end

            M2C: begin
                if (!ccif.dREN[cpu_sel]) begin // actually want to trigger after word 2. add a counter or add states
                    next_state = IDLE;
                    next_cpu_sel = ~cpu_sel;
                end else begin
                    next_state = M2C;
		        end
            end

        endcase
    end

    //change all the outputs for the states. because now outside of idle cpu_sel is requestor ~cpu_sel is responder
    always @ * begin
        ccif.ccwait = 0;
        ccif.ccinv = 0;
        ccif.ccsnoopaddr = 0;
        ccif.ramstore = 0;
        ccif.ramaddr = 0;
        ccif.ramWEN = 0;
        ccif.ramREN = 0;
        ccif.iwait = 2'b11;
        ccif.dwait = 2'b11;
        ccif.iload = 0;
        ccif.dload = 0;
        casez (curr_state)
            IDLE: begin
               
            end

            IST: begin
                ccif.ramaddr = ccif.iaddr[cpu_sel];
                ccif.ramREN = 1'b1;
                ccif.iload[cpu_sel] = ccif.ramload;
                if (ccif.ramstate == ACCESS) begin //RAMSTATES == ACCESS
                    ccif.iwait[cpu_sel] = 1'b0;
                end else if (ccif.ramstate == FREE) begin //FREE
                    ccif.iwait[cpu_sel] = 1'b1;
                end else begin //BUSY, ERROR and default
                    ccif.iwait[cpu_sel] = 1'b1;
                end
            end

            WST: begin
                ccif.ramstore = ccif.dstore[cpu_sel];
                ccif.ramWEN = ccif.dWEN[cpu_sel];
                ccif.ramaddr = ccif.daddr[cpu_sel];
                if (ccif.ramstate == ACCESS) begin //RAMSTATES == ACCESS
                    ccif.dwait[cpu_sel] = 1'b0;
                end else if (ccif.ramstate == FREE) begin //FREE
                    ccif.dwait[cpu_sel] = 1'b1;
                end else begin //BUSY, ERROR and default
                    ccif.dwait[cpu_sel] = 1'b1;
                end
            end

            SNOOP: begin
                ccif.ccwait[~cpu_sel] = 1;
                ccif.ccinv[~cpu_sel] = ccif.ccwrite[cpu_sel];
                ccif.ccsnoopaddr[~cpu_sel] = ccif.daddr[cpu_sel]; 
            end

            C2C: begin
                ccif.dload[cpu_sel] = ccif.dstore[~cpu_sel];
                ccif.dwait[~cpu_sel] = !(ccif.ramstate == ACCESS);
                ccif.dwait[cpu_sel] = !(ccif.ramstate == ACCESS);
                ccif.ramaddr = ccif.daddr[cpu_sel];
                ccif.ramstore = ccif.dstore[~cpu_sel];
                ccif.ramWEN = 1'b1;
                ccif.ccinv[~cpu_sel] = ccif.ccwrite[cpu_sel];
                ccif.ccsnoopaddr[~cpu_sel] = ccif.daddr[cpu_sel]; 
            end

            M2C: begin
                ccif.dload[cpu_sel] = ccif.ramload;
                ccif.dwait[~cpu_sel] = 1'b1;
                ccif.ramaddr = ccif.daddr[cpu_sel];
                ccif.ramREN = ccif.dREN[cpu_sel];
                ccif.ccinv[~cpu_sel] = ccif.ccwrite[cpu_sel];
                if (ccif.ramstate == ACCESS) begin //RAMSTATES == ACCESS
                    ccif.dwait[cpu_sel] = 1'b0;
                end else if (ccif.ramstate == FREE) begin //FREE
                    ccif.dwait[cpu_sel] = 1'b1;
                end else begin //BUSY, ERROR and default
                    ccif.dwait[cpu_sel] = 1'b1;
                end
            end

        endcase
    end
endmodule


//cctrans is 1 when going to update 1 from IDLE and WB2
//Use cctrans && dren on bus control?
