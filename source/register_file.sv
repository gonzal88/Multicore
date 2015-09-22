`include "cpu_types_pkg.vh"
`include "register_file_if.vh"

 

module register_file
   import cpu_types_pkg::*;
(
    input logic CLK,
    input logic nRST,
    register_file_if.rf rfif
);
    word_t array[31:0];

    always_ff @(negedge CLK or negedge nRST) begin     
        if (!nRST) begin
           array <= '{default:0};         
        end
        else begin
	   if ((rfif.WEN == 1'b1) && rfif.wsel) begin
	      array[rfif.wsel] <= rfif.wdat;
           end              
        end
    end

    assign rfif.rdat1 = array[rfif.rsel1];
    assign rfif.rdat2 = array[rfif.rsel2];

endmodule
