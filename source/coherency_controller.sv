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

    always_comb begin
        next_cpu_sel = cpu_sel;
        casez (curr_state)
            IDLE: begin
                if (ccif.iREN[0] || ccif.iREN[1]) begin
                    next_state = IST;
                end else if (ccif.dWEN[0]) begin
                    next_state = WST;
                end else if (ccif.dREN[0]) begin
                    next_state = SNOOP;
                end else begin
                    next_state = IDLE;
                end
            end

            IST: begin
                if (ccif.iREN[cpu_sel]) begin
                    next_state = IST;
                end else begin
                    next_state = IDLE;
                    next_cpu_sel = !cpu_sel;
                end
            end

            WST: begin
                if (ccif.dWEN[0]) begin
                    next_state = WST;
                end else begin
                    next_state = IDLE;
                end
            end

            SNOOP: begin
                if (!ccif.dREN[1]) begin
                    next_state = M2C;
                end else begin
                    next_state = C2C;
                end
            end

            M2C: begin
                if (ccif.dREN[0]) begin
                    next_state = M2C;
                end else begin
                    next_state = IDLE;
                end
            end

            C2C: begin
                if (ccif.dREN[0]) begin
                    next_state = C2C;
                end else begin
                    next_state = IDLE;
                end
            end


        endcase
    end

    always_comb begin
        ccif.ccwait = 0;
        ccif.ccinv = 0;
        ccif.ccsnoopaddr = 0;
        ccif.ramstore = 0;
        ccif.ramaddr = 0;
        ccif.ramWEN = 0;
        ccif.ramREN = 0;
        ccif.iwait = 0;
        ccif.dwait = 0;
        ccif.iload = 0;
        ccif.dload = 0;
        casez (curr_state)
            IDLE: begin
                
            end

            IST: begin
                if (ccif.iREN[0] && ccif.iREN[1]) begin
                    ccif.ramaddr = ccif.iaddr[cpu_sel];
                    ccif.ramREN = ccif.iREN[cpu_sel];
                    ccif.iload[cpu_sel] = ccif.ramload;
                    if (ccif.ramstate == ACCESS) begin //RAMSTATES == ACCESS
                        ccif.iwait[cpu_sel] = 1'b0;
                    end else if (ccif.ramstate == FREE) begin //FREE
                        ccif.iwait[cpu_sel] = 1'b0;
                    end else begin //BUSY, ERROR and default
                        ccif.iwait[cpu_sel] = 1'b1;
                    end
                end else begin
                    ccif.ramaddr = ccif.iaddr[0];
                    ccif.ramREN = ccif.iREN[0];
                    ccif.iload[0] = ccif.ramload;
                    if (ccif.ramstate == ACCESS) begin //RAMSTATES == ACCESS
                        ccif.iwait[0] = 1'b0;
                    end else if (ccif.ramstate == FREE) begin //FREE
                        ccif.iwait[0] = 1'b0;
                    end else begin //BUSY, ERROR and default
                        ccif.iwait[0] = 1'b1;
                    end
                end
            end

            WST: begin
                ccif.ramstore = ccif.dstore[0];
                ccif.ramWEN = ccif.dWEN[0];
                ccif.ramaddr = ccif.daddr[0];
                if (ccif.ramstate == ACCESS) begin //RAMSTATES == ACCESS
                    ccif.dwait[0] = 1'b0;
                end else if (ccif.ramstate == FREE) begin //FREE
                    ccif.dwait[0] = 1'b0;
                end else begin //BUSY, ERROR and default
                    ccif.dwait[0] = 1'b1;
                end
            end

            SNOOP: begin
                ccif.ccwait[1] = 1;
                ccif.ccinv[1] = ccif.ccwrite[0];
                ccif.ccsnoopaddr[1] = ccif.daddr[0]; 
            end

            C2C: begin
                ccif.dload[0] = ccif.dload[1];
                ccif.dwait[1] = !(ccif.ramstate == ACCESS);
                ccif.dwait[0] = !(ccif.ramstate == ACCESS);
                ccif.ramaddr = ccif.daddr[1];
                ccif.ramREN = ccif.dREN[1];
            end

            M2C: begin
                ccif.dload[0] = ccif.ramload;
                ccif.dwait[1] = 1'b1;
                ccif.ramaddr = ccif.daddr[0];
                ccif.ramREN = ccif.dREN[0];
                if (ccif.ramstate == ACCESS) begin //RAMSTATES == ACCESS
                    ccif.dwait[0] = 1'b0;
                end else if (ccif.ramstate == FREE) begin //FREE
                    ccif.dwait[0] = 1'b0;
                end else begin //BUSY, ERROR and default
                    ccif.dwait[0] = 1'b1;
                end
            end

        endcase
    end
endmodule
