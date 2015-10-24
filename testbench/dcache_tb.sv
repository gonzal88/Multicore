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
    datapath_cache_if dcif,
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
        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'hAAAAAAA0;
        dcif.dmemstore = 32'hAAAAAAAA;
        @(posedge dcif.dhit) // Will eventually resolve to a hit after missing see waveform to check timing
	dcif.dmemWEN = 0;
	#(PERIOD)

        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'hDDDDDDD4;
        dcif.dmemstore = 32'hDDDDDDDD;
        @(posedge dcif.dhit)
	dcif.dmemWEN = 0;
	#(PERIOD)


        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'hBBBBBBB8;
        dcif.dmemstore = 32'hBBBBBBBB;
        @(posedge dcif.dhit)
	dcif.dmemWEN = 0;
	#(PERIOD)

        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'hCCCCCCCC;
        dcif.dmemstore = 32'hCCCCCCCC;
        @(posedge dcif.dhit)
        dcif.dmemWEN = 0;
	#(PERIOD)



        // Write some hits
        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'hAAAAAAA0;
        dcif.dmemstore = 32'hAAAAAAAB;
        //@(posedge dcif.dhit) 
	dcif.dmemWEN = 0;
	#(PERIOD*5)

        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'hDDDDDDD4;
        dcif.dmemstore = 32'hDDDDDDDB;
        //@(posedge dcif.dhit)
	dcif.dmemWEN = 0;
	#(PERIOD*5)

        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'hBBBBBBB8;
        dcif.dmemstore = 32'hBBBBBBBC;
        //@(posedge dcif.dhit)
	dcif.dmemWEN = 0;
	#(PERIOD*5)

        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'hCCCCCCCC;
        dcif.dmemstore = 32'hCCCCCCCB;
        //@(posedge dcif.dhit)
        dcif.dmemWEN = 0;
	#(PERIOD*5)



        /*// Read hits
        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'hAAAAAAA0;
        //@(posedge dcif.dhit)
	#(PERIOD*5)

        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'hDDDDDDD4;
        //@(posedge dcif.dhit)
	#(PERIOD*5)

        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'hBBBBBBB8;
        //@(posedge dcif.dhit)
	#(PERIOD*5)

        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'hCCCCCCCC;
        //@(posedge dcif.dhit)
        dcif.dmemREN = 0;
	#(PERIOD*5)



        // Read misses
        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'h1111AAA0;
        @(posedge dcif.dhit)
	#(PERIOD)

        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'h1111DDD4;
        @(posedge dcif.dhit)
	#(PERIOD)

        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'h11BBBBB8;
        @(posedge dcif.dhit)
	#(PERIOD)

        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'h11CCCCCC;
        @(posedge dcif.dhit)
        dcif.dmemREN = 0;
	#(PERIOD)



        // Write some conflict misses
        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'h1AAAAAA0;
        dcif.dmemstore = 32'hA123AAAB;
        @(posedge dcif.dhit) // Will eventually resolve to a hit after missing see waveform to check timing
	dcif.dmemWEN = 0;
	#(PERIOD)

        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'h1DDDDDD4;
        dcif.dmemstore = 32'hD123DDDB;
        @(posedge dcif.dhit)
	dcif.dmemWEN = 0;
	#(PERIOD)

        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'h1BBBBBB8;
        dcif.dmemstore = 32'hB123BBBC;
        @(posedge dcif.dhit)
	dcif.dmemWEN = 0;
	#(PERIOD)

        dcif.dmemWEN = 1;
        dcif.dmemaddr = 32'h1CCCCCCC;
        dcif.dmemstore = 32'hC123CCCB;
        @(posedge dcif.dhit)
        dcif.dmemWEN = 0;
	#(PERIOD)



        // Read and verify the conflict misses
        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'hAAAAAAA0;
        @(posedge dcif.dhit)
	#(PERIOD)

        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'hDDDDDDD4;
        @(posedge dcif.dhit)
	#(PERIOD)

        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'hBBBBBBB8;
        @(posedge dcif.dhit)
	#(PERIOD)

        dcif.dmemREN = 1;
        dcif.dmemaddr = 32'hCCCCCCCC;
        @(posedge dcif.dhit)
        dcif.dmemREN = 0;
	#(PERIOD) */



        // Go for some capacity miss writes
        /*for (i = 0; i < 2048; i += 4) begin
            dcif.dmemWEN = 1;
            dcif.dmemaddr = i;
            dcif.dmemstore = 32'h12345678;
            @(posedge dcif.dhit);
	    dcif.dmemWEN = 0;
	    #(PERIOD);
        end
        dcif.dmemWEN = 0;



        // Read and verify the capacity miss writes
        for (i = 0; i < 2048; i += 4) begin
            dcif.dmemREN = 1;
            dcif.dmemaddr = i;
            @(posedge dcif.dhit);
            #(PERIOD);
        end
        dcif.dmemREN = 0;*/

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
