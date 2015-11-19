// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

//ram interface
`include "cpu_ram_if.vh"

`timescale 1 ns / 1 ns
module memory_control_tb ;
   
   import cpu_types_pkg::*;
   parameter CPUS = 2;
   parameter PERIOD = 10;
   logic CLK = 0, nRST;

   always #(PERIOD/2) CLK++;
   
   //inerface
   cache_control_if ccif();
   cpu_ram_if ramif();

   ram RAM (CLK, nRST, ramif);

   //test program
   test PROG (CLK, nRST, ccif, ramif);
   memory_control DUT(CLK, nRST, ccif);


   assign ramif.ramaddr = ccif.ramaddr;
   assign ccif.ramload = ramif.ramload;
   assign ramif.ramstore = ccif.ramstore;
   assign ccif.ramstate = ramif.ramstate;
   assign ramif.ramREN = ccif.ramREN;
   assign ramif.ramWEN = ccif.ramWEN;
endmodule

program test
(
 input logic CLK,
 output logic nRST,
 cache_control_if ccif,
 cpu_ram_if  ramif
 );
   
   parameter PERIOD = 10;
   int        n = 0;
   
   import cpu_types_pkg::*;
  
   initial begin
      
      nRST = 1'b0;
      #(PERIOD)
      nRST = 1'b1;
      #(PERIOD)
      
      ccif.iREN[0] = 1'b1;
      ccif.dREN[0] = 1'b0;
      ccif.dWEN[0] = 1'b0;
      ccif.dstore[0] = 32'b0;
      ccif.daddr[0] = 32'b0;
      ccif.iaddr[0] = 32'h0000;
      
      //Fetching
      n = 1'b0;
      while (n <= 20)
      begin  
     @(negedge ccif.iwait[0]);
     if (ccif.iload[0] == ccif.ramload) begin
            //$display("Instr Fetch PASSED!\n");
     end
     else begin
            $error("Instr Fetch FAILED!\n");
     end
     #(PERIOD)
     ccif.iaddr[0] = ccif.iaddr[0]  + 4;
     n += 1;
     
      end // while (n <= 20)
      //Reading
      
      ccif.iREN[0] = 1'b1;
      ccif.dREN[0] = 1'b1;
      ccif.dWEN[0] = 1'b0;
      ccif.dstore[0] = 32'h0000;
      ccif.daddr[0] = 32'h0000;
      ccif.iaddr[0] = 32'h0000;
      
      n = 1'b0;
      while (n <= 20)
      begin
     ccif.dREN[0] = 1'b1;
     @(negedge ccif.dwait[0]);
     if (ccif.dload[0] == ccif.ramload) begin
            //$display("Read Test PASSED!\n");
     end
     else begin
            $error("Read Test FAILED!\n");
     end
     
     ccif.dREN[0] = 1'b0;
     @(negedge ccif.iwait[0]);
     if (ccif.iload[0] != ccif.ramload) begin
            $display("Read Test FAILED!\n");
     end
     else begin
            //$error("Read Test PASED!\n");
     end
     
     #(PERIOD)
     ccif.iaddr[0] = ccif.iaddr[0] + 4;
     ccif.daddr[0] = ccif.daddr[0] + 4;
     n += 1;
      end // while (n <= 20)
      
      //Writting
      ccif.iREN[0] = 1'b1;
      ccif.dREN[0] = 1'b0;
      ccif.dWEN[0] = 1'b1;
      ccif.dstore[0] = 32'h0000;
      ccif.daddr[0] = 32'h0000;
      ccif.iaddr[0] = 32'h0000;
      
      n = 1'b0;
      while (n <= 20)
      begin
     ccif.dstore[0] = n;
     ccif.dWEN[0] = 1'b1;
     @(negedge ccif.dwait[0]);
     if (ccif.dload[0] != ccif.ramload) begin
            $display("Write Test FAILED!\n");
     end
     else begin
            //$error("Write Test PASSED!\n");
     end
     
     #(PERIOD)
     ccif.dWEN[0] = 1'b0;
     @(negedge ccif.iwait[0]);
     if (ccif.iload[0] != ccif.ramload) begin
            $display("Write Test FAILED!\n");
     end
     else begin
            //$error("Write Test PASSED!\n");
     end
     
     #(PERIOD)
     ccif.daddr[0] = ccif.daddr[0] + 4;
     ccif.dstore[0] = ccif.dstore[0] << 1;
     ccif.iaddr[0] = ccif.iaddr[0] + 4;
     
     n += 1;
      end // while (n <= 20)
      
      dump_memory();
      $finish;
   end // initial begin
   
   task automatic dump_memory();
      string filename = "memcpu.hex";
      int    file_open;

      ccif.daddr[0] = 0;
      ccif.dWEN[0] = 0;
      ccif.dREN[0] = 0;
      
      file_open = $fopen(filename,"w");
      if (file_open)
    begin
       $display("Starting memory dump.");
    end
      else
    begin $display("opening file was corrupt %s.",filename); 
       $finish;
    end
      n = 1'b0;
      
      for (int unsigned n = 0; file_open && n < 16384; n++)
    begin
       int total = 0;
       bit [7:0][7:0] values;
       string     ihex;

       ccif.daddr[0] = n << 2;
       ccif.dREN[0] = 1;
       repeat (4) @(posedge CLK);
       if (ccif.dload[0] === 0)
             continue;
       values = {8'h04,16'(n),8'h00,ccif.ramload};
       foreach (values[j])
         total += values[j];
         //$display("total = %h\n", total);
             
       total = 256 - total;
       ihex = $sformatf(":04%h00%h%h",16'(n),ccif.ramload,8'(total));
       $fdisplay(file_open,"%s",ihex.toupper());
       //$display("n = %h, ccif.daddr[0] = %h values = %h total = %h\n\n", n, ccif.daddr[0], values, total);
       
    end // for (int unsigned n = 0; file_open && n < 16384; n++)
      if (file_open)
    begin
       ccif.dREN[0] = 0;
       $fdisplay(file_open,":00000001FF");
       $fclose(file_open);
    end
   endtask // automatic
   
endprogram 
