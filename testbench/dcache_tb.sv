/*
  Javier Gonzalez Souto && Cyrus Sutaria
  gonzal88@purdue.edu
  csutaria@purdue.edu 

  Dcache testbench
 */

`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"
`include "cpu_ram_if.vh"

`timescale 1 ns /1 ns

module dcache_tb;
    import cpu_types_pkg::*;
   
    parameter PERIOD = 20;
    logic nRST;
    logic CLK = 0;
    logic  CPUCLK = 0;
   
    always #(PERIOD) CPUCLK++;
    always #(PERIOD/2) CLK++;

    datapath_cache_if dcif ();
    cache_control_if ccif ();
    cpu_ram_if ramif ();
    memory_control MEM (CLK, nRST, ccif);//
   

    test PROG (CLK, nRST, dcif, ccif, ramif);
    dcache DUT(CPUCLK, nRST, dcif, ccif);
    ram RAM (CLK, nRST, ramif);

    assign ramif.ramREN = ccif.ramREN;//ccif.iREN
    assign ramif.ramWEN = ccif.ramWEN;//1'b0
    assign ramif.ramaddr = ccif.ramaddr;//ccif.iaddr
    assign ramif.ramstore = ccif.ramstore;//0
    assign ccif.ramload = ramif.ramload;
    assign ccif.ramstate = ramif.ramstate;
   
    

endmodule

program test (
    input logic CLK,
    output logic nRST,
    datapath_cache_if.dp dcif,
    cache_control_if.cc ccif,
    cpu_ram_if.ram ramif
);
    import cpu_types_pkg::*;
    parameter PERIOD = 16;
    dcachef_t dcache_sel;


    int i;
    initial begin

        //Reset
        dcif.halt = 0;
        dcif.dmemREN = 0;
        dcif.dmemWEN = 0;
        dcif.dmemaddr = 0;
        dcif.dmemstore = 0;
        nRST = 0;
        #(PERIOD)
        nRST = 1;
        #(PERIOD)

        // Write a few compulsory misses

        // Write some hits

        // Read hits

        // Read misses

        // Write some conflict misses

        // Read and verify the conflict misses

        // Go for some capacity miss writes

        // Read and verify the capacity miss writes

        dcif.halt = 1;
        $display("dcif.flushed should be asserted.\n");
        @(posedge dcif.flushed);
        $display("dcif.flushed was asserted!\n");
        dump_memory();
        $finish;
    end

    task automatic dump_memory();
        string filename = "memcpu.hex";
        int file_open = $fopen(filename, "w");

        ccif.daddr[0] = 0;
        ccif.dWEN[0] = 0;
        ccif.dREN[0] = 0;

        if(file_open) begin
            $display("Starting Memory Dump.");
        end else begin
            $display("file was corrupt %s.", filename);
            $finish;
        end

        i = 1'b0;

        for (int unsigned i=0; file_open && i < 16384; i++) begin
            int total = 0;
            bit [7:0][7:0] val;
            string ihex;

            ccif.daddr[0] = i << 2;
            ccif.dREN[0] = 1;
            repeat (4) @(posedge CLK);
            if (ccif.dload[0] == 0)
                continue;
            val = {8'h04, 16'(i), 8'h00, ccif.ramload};
            foreach (val[j])
                total += val[j];
                //$display("total = %h\n", total);
            total =  256 - total;
            ihex = $sformatf(":04%h00%h%h", 16'(i), ccif.ramload, 8'(total));
            $fdisplay(file_open, "%s", ihex.toupper());
            //$display("n = %h, ccif.daddr[0] = %h val = %h total = %h\n\n", n, ccif.daddr[0], val, total);
        end
        if(file_open) begin
            ccif.dREN[0] = 0;
            $fdisplay(file_open, ":00000001FF");
            $fclose(file_open);
            $display("Finished memory Dump.");
        end 
        

    endtask //automatic

endprogram