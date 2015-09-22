/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule



program test
  (
    input logic CLK,
    output logic nRST,
    register_file_if.tb rfif
  );


   parameter PERIOD = 10;

   initial begin

      @(posedge CLK);
       
      nRST = 1'b0;
      rfif.WEN = 1'b1;
      rfif.wsel = 5'b10000;
      #(PERIOD)

      @(posedge CLK);
      
      nRST = 1'b1;
      rfif.WEN = 1'b1;
      rfif.wsel = 5'b00000;
      rfif.wdat = 18;
      rfif.rsel1 = 5'b00000;
      #(PERIOD)

      #(PERIOD)
      
      @(posedge CLK);
      
      nRST = 1'b1;
      rfif.WEN = 1'b1;
      rfif.wsel = 5'b00101;
      rfif.wdat = 15;
      rfif.rsel1 = 5'b00101;
      rfif.rsel2 = 5'b00101;
      
      #(PERIOD)

      
      
      @(posedge CLK);
      
      nRST = 1'b0;
      rfif.WEN = 1'b1;
      rfif.wsel = 5'b10000;
      rfif.wdat = 15;
      #(PERIOD)
      
      $finish;
      
   end


endprogram

   
