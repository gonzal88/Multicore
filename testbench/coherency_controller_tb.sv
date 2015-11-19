/*
  Javier Gonzalez Souto && Cyrus Sutaria
  gonzal88@purdue.edu
  csutaria@purdue.edu 

  Coherency testbench
 */


`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns /1 ns

module coherency_controller_tb;
    import cpu_types_pkg::*;

    parameter PERIOD = 20;
    logic nRST;
    logic CLK = 0;
    always #(PERIOD/2) CLK++;

    cache_control_if ccif ();
    coherency_controller DUT (CLK, nRST, ccif);
    test PROG (CLK, nRST, ccif);

endmodule


program test (
    input logic CLK, 
    output logic nRST,
    cache_control_if.cc ccif

);
    import cpu_types_pkg::*;
    parameter PERIOD = 20;
    initial begin

    

    nRST = 0;
    #(PERIOD)
    nRST = 1;
    #(PERIOD)

    ccif.iREN[0] = 0;
    ccif.dREN[0] = 0;
    ccif.dWEN[0] = 0;
    ccif.dstore[0] = 32'h0;
    ccif.iaddr[0] = 32'h0;
    ccif.daddr[0] = 32'h0;
    ccif.ramload = 32'h0;
    ccif.ramstate = FREE;
    ccif.ccwrite[0] = 0;
    ccif.cctrans[0] = 0;
    ccif.iREN[1] = 0;
    ccif.dREN[1] = 0;
    ccif.dWEN[1] = 0;
    ccif.dstore[1] = 0;
    ccif.iaddr[1] = 32'h0;
    ccif.daddr[1] = 32'h0;
    ccif.ccwrite[1] = 0;
    ccif.cctrans[1] = 0;

    #(PERIOD)

    //Case 1 Core 0 iread
    ccif.iREN[0] = 1;
    ccif.iaddr[0] = 32'hAAAA;
    ccif.ramload = 32'hBBBB;
    ccif.ramstate = ACCESS;

    #(PERIOD)

    if ((ccif.ramaddr == 32'hAAAA) && (ccif.ramREN == 1'b1) && (ccif.iload[0] == 32'hBBBB) && (ccif.iload[1] == 32'h0) && (ccif.iwait[0] == 0)) begin
        $display("Pass core 0 iread 0");
    end else begin
        $display("FAIL core 0 iread 0");
    end

    #(PERIOD)

    ccif.iREN[0] = 1;
    ccif.iaddr[0] = 32'hAAAA;
    ccif.ramload = 32'hBBBB;
    ccif.ramstate = BUSY;

    #(PERIOD)

    if ((ccif.ramaddr == 32'hAAAA) && (ccif.ramREN == 1'b1) && (ccif.iload[0] == 32'hBBBB) && (ccif.iload[1] == 32'h0) && (ccif.iwait[0] == 1)) begin
        $display("Pass core 0 iread 1");
    end else begin
        $display("FAIL core 0 iread 1");
    end

    #(PERIOD)

    ccif.iREN[0] = 0;
    ccif.dREN[0] = 0;
    ccif.dWEN[0] = 0;
    ccif.dstore[0] = 32'h0;
    ccif.iaddr[0] = 32'h0;
    ccif.daddr[0] = 32'h0;
    ccif.ramload = 32'h0;
    ccif.ramstate = FREE;
    ccif.ccwrite[0] = 0;
    ccif.cctrans[0] = 0;

    #(PERIOD)

    //Case 2 core 0 dwrite
    ccif.iREN[0] = 0;
    ccif.dREN[0] = 0;
    ccif.dWEN[1] = 1;
    ccif.dstore[1] = 32'hAAAA;
    ccif.iaddr[1] = 32'h0;
    ccif.daddr[1] = 32'hCCCC;
    ccif.ramload = 32'h0;
    ccif.ramstate = FREE;
    ccif.ccwrite[1] = 0;
    ccif.cctrans[1] = 0;

    #(PERIOD)

    if ((ccif.ramaddr == 32'hCCCC) && (ccif.ramWEN == 1'b1) && (ccif.ramREN == 1'b0) && (ccif.dwait[1] == 0)) begin
        $display("Pass core 0 dwrite 0");
    end else begin
        $display("FAIL core 0 dwrite 0");
    end

    #(PERIOD)

    ccif.ramstate = BUSY;

    #(PERIOD)

    if ((ccif.ramaddr == 32'hCCCC) && (ccif.ramWEN == 1'b1) && (ccif.ramREN == 1'b0) && (ccif.dwait[1] == 1)) begin
        $display("Pass core 0 dwrite 1");
    end else begin
        $display("FAIL core 0 dwrite 1");
    end

    #(PERIOD)

    ccif.iREN[0] = 0;
    ccif.dREN[0] = 0;
    ccif.dWEN[1] = 0;
    ccif.dstore[1] = 32'h0;
    ccif.iaddr[1] = 32'h0;
    ccif.daddr[1] = 32'h0;
    ccif.ramload = 32'h0;
    ccif.ramstate = FREE;
    ccif.ccwrite[1] = 0;
    ccif.cctrans[1] = 0;

    #(PERIOD)

    ccif.iREN[0] = 0;
    ccif.dREN[0] = 1;
    ccif.dWEN[0] = 0;
    ccif.dstore[0] = 32'h0;
    ccif.iaddr[0] = 32'h0;
    ccif.daddr[0] = 32'hABCD;
    ccif.ramload = 32'h0;
    ccif.ramstate = FREE;
    ccif.ccwrite[0] = 1;
    ccif.cctrans[0] = 0;
    ccif.iREN[1] = 0;
    ccif.dREN[1] = 1;
    ccif.dWEN[1] = 0;;
    ccif.dstore[1] = 32'hA1A1;
    ccif.iaddr[1] = 32'h0;
    ccif.daddr[1] = 32'hABBB;
    ccif.ccwrite[1] = 1;
    ccif.cctrans[1] = 0;

    #(PERIOD)

    if ((ccif.ccwait[1] == 1'b1) && (ccif.ccinv[1] == 1) && (ccif.ccsnoopaddr[1] == 32'hABCD)) begin
        $display("Pass core 0 dread 0");
    end else begin
        $display("FAIL core 0 dread 0");
    end

    #(PERIOD)

    ccif.dWEN[1] = 1;

    #(PERIOD)

    if ((ccif.dload[0] == 32'h0) && (ccif.dwait[1] == 1) && (ccif.ramaddr == 32'hABCD) && (ccif.ramREN == 1)) begin
        $display("Pass core 0 dread 1");
    end else begin
        $display("FAIL core 0 dread 1");
    end

    #(PERIOD)

    ccif.dREN[0] = 0;
    ccif.dWEN[1] = 0;
       

    #(PERIOD)

    ccif.dREN[0] = 1;
    ccif.dREN[1] = 0;
       
    ccif.ccwrite[0] = 0;
    ccif.dstore[1] = 32'hAEAE;

    #(PERIOD)

    if ((ccif.ccwait[1] == 1'b1) && (ccif.ccinv[1] == 0) && (ccif.ccsnoopaddr[1] == 32'hABCD)) begin
        $display("Pass core 0 dread 2");
    end else begin
        $display("FAIL core 0 dread 2");
    end

    #(PERIOD)
    ccif.dREN[0] = 0;
       
    ccif.dWEN[1] = 1;
       

    if ((ccif.dload[0] == 32'h0) && (ccif.dwait[1] == 1) && (ccif.ramaddr == 32'hABBB) && (ccif.ramREN == 1)) begin
        $display("Pass core 0 dread 3");
    end else begin
        $display("FAIL core 0 dread 3");
    end

    end

endprogram
