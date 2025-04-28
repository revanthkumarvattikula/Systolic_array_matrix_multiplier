
`timescale 1ns / 1ps
module pe_generic(clk,reset,in_a,in_b,out_a,out_b,out_c);

 parameter data_size=4;
 input wire reset,clk;
 input wire signed [data_size-1:0] in_a,in_b;
 output reg signed [2*data_size:0] out_c;
 output reg signed [data_size-1:0] out_a,out_b;

 always @(posedge clk)begin
    if(reset) begin
      out_a=0;
      out_b=0;
      out_c=0;
    end
    else begin  
      out_c=out_c + in_a * in_b;  // Signed multiplication
      out_a=in_a;
      out_b=in_b;
    end
 end
 
endmodule
