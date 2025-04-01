`timescale 1ns / 1ps

module tb_pe;
  
  parameter data_size = 8;
  reg clk, reset;
  reg [data_size-1:0] in_a, in_b;
  wire [data_size-1:0] out_a, out_b;
  wire [2*data_size:0] out_c;

  // Instantiate DA LUT-based PE
  pe_generic #(data_size) UUT (
    .clk(clk), .reset(reset), .in_a(in_a), .in_b(in_b),
    .out_a(out_a), .out_b(out_b), .out_c(out_c)
  );

  // Clock Generation
  always #5 clk = ~clk;

  initial begin
    $dumpfile("tb_pe_DA.vcd");
    $dumpvars(0, tb_pe_DA);

    clk = 0; reset = 1;
    in_a = 0; in_b = 0;
    
    // Apply Reset
    #10 reset = 0;

    // Apply Test Values
    #10 in_a = 5; in_b = 3;
    #10 in_a = 2; in_b = 4;
    #10 in_a = 7; in_b = 6;

    // Observe Results
    #30 $finish;
  end

endmodule
