`timescale 1ns / 1ps

module tb_pe;
  
  parameter data_size = 4;
  reg clk, reset;
  reg signed [data_size-1:0] in_a, in_b;
  wire signed [data_size-1:0] out_a, out_b;
  wire signed [2*data_size:0] out_c;

  // Instantiate DA LUT-based PE
  pe_generic #(data_size) UUT (
    .clk(clk), .reset(reset), .in_a(in_a), .in_b(in_b),
    .out_a(out_a), .out_b(out_b), .out_c(out_c)
  );

  // Clock Generation
  always #5 clk = ~clk;

  initial begin
    $dumpfile("tb_pe.vcd");
    $dumpvars(0, tb_pe);

    clk = 0; reset = 1;
    in_a = 0; in_b = 0;
    
    // Apply Reset
    #10 reset = 0;
    
    // Print header
    $display("Time\tin_a\tin_b\tout_a\tout_b\tout_c");
    $display("--------------------------------------------------");

    // Apply Test Values (including negative numbers)
    #10 in_a = 5; in_b = 3;      // 5 * 3 = 15
    #5 $display("%0t\t%0d\t%0d\t%0d\t%0d\t%0d", $time, in_a, in_b, out_a, out_b, out_c);
    
    #5 in_a = -2; in_b = 4;     // -2 * 4 = -8
    #5 $display("%0t\t%0d\t%0d\t%0d\t%0d\t%0d", $time, in_a, in_b, out_a, out_b, out_c);
    
    #5 in_a = 3; in_b = -3;     // 3 * -3 = -9
    #5 $display("%0t\t%0d\t%0d\t%0d\t%0d\t%0d", $time, in_a, in_b, out_a, out_b, out_c);
    
    #5 in_a = -4; in_b = -2;    // -4 * -2 = 8
    #5 $display("%0t\t%0d\t%0d\t%0d\t%0d\t%0d", $time, in_a, in_b, out_a, out_b, out_c);
    
    #5 in_a = 7; in_b = 6;      // 7 * 6 = 42
    #5 $display("%0t\t%0d\t%0d\t%0d\t%0d\t%0d", $time, in_a, in_b, out_a, out_b, out_c);

    // Final display to show accumulated result
    #5 $display("--------------------------------------------------");
    #5 $display("Final accumulated result: %0d", out_c);
    #5 $finish;
  end

endmodule


