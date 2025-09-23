`timescale 1ns / 1ps
module top_tb;

 // Inputs
 reg clk;
 reg reset;
 parameter data_size=4;
 
 reg [data_size-1:0] a1;
 reg [data_size-1:0] a2;
 reg [data_size-1:0] a3;
 reg [data_size-1:0] b1;
 reg [data_size-1:0] b2;
 reg [data_size-1:0] b3;

 // Outputs
 wire [2*data_size:0] c1;
 wire [2*data_size:0] c2;
 wire [2*data_size:0] c3;
 wire [2*data_size:0] c4;
 wire [2*data_size:0] c5;
 wire [2*data_size:0] c6;
 wire [2*data_size:0] c7;
 wire [2*data_size:0] c8;
 wire [2*data_size:0] c9;

 // Instantiate the Unit Under Test (UUT)
 top uut (
  .clk(clk), 
  .reset(reset), 
  .a1(a1), 
  .a2(a2), 
  .a3(a3), 
  .b1(b1), 
  .b2(b2), 
  .b3(b3), 
  .c1(c1), 
  .c2(c2), 
  .c3(c3), 
  .c4(c4), 
  .c5(c5), 
  .c6(c6), 
  .c7(c7), 
  .c8(c8), 
  .c9(c9)
 );

 initial begin
  // Initialize Inputs
  clk = 0;
  reset = 0;
  a1 = 0;
  a2 = 0;
  a3 = 0;
  b1 = 0;
  b2 = 0;
  b3 = 0;

  // Wait 100 ns for global reset to finish
  
  
  
  //a11                     b11
  //a12 a21                 b21 b12
  //a13 a22 a31             b31 b22 b13
  //    a23 a32                 b32 b13
  //        a33                     b33
 
  #5 reset = 1;
  #5 reset = 0;
  #5;  a1 = 1; a2 = 0; a3 = 0; b1 = 2; b2 = 0; b3 = 0;
  #10; a1 = 1; a2 = 1; a3 = 0; b1 = 1; b2 = 3; b3 = 0;
  #10; a1 = 1; a2 = 1; a3 = 1; b1 = 3; b2 = 1; b3 = 2;
  #10; a1 = 0; a2 = 1; a3 = 1; b1 = 0; b2 = 3; b3 = 1;
  #10; a1 = 0; a2 = 0; a3 = 1; b1 = 0; b2 = 0; b3 = 1;
  #10; a1 = 0; a2 = 0; a3 = 0; b1 = 0; b2 = 0; b3 = 0;
  #100;
  $stop;

 end
 
 initial begin
  forever #5 clk = ~clk;
 end
      
endmodule
