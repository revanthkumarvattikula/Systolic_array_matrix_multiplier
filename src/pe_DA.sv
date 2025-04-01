`timescale 1ns / 1ps
module pe_DA(clk, reset, in_a, in_b, out_a, out_b, out_c);

  parameter data_size = 8; // Adjust as needed (smaller sizes yield smaller LUTs)
  
  input wire reset, clk;
  input wire [data_size-1:0] in_a, in_b;
  output reg [2*data_size:0] out_c;
  output reg [data_size-1:0] out_a, out_b;
  
  // LUT-based DA multiplier:
  // LUT dimensions: (2^data_size) x (2^data_size), each entry holds a product of two data_size-bit numbers.
  // The product is 2*data_size bits wide.
  reg [(2*data_size)-1:0] lut [0:(1<<data_size)-1][0:(1<<data_size)-1];
  reg [(2*data_size)-1:0] mult_result;
  
  integer i, j;
  
  // Preload the LUT with multiplication results
  initial begin
    for (i = 0; i < (1 << data_size); i = i + 1) begin
      for (j = 0; j < (1 << data_size); j = j + 1) begin
        lut[i][j] = i * j;
      end
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      out_a <= 0;
      out_b <= 0;
      out_c <= 0;
    end
    else begin
      // Retrieve product using the DA LUT
      mult_result = lut[in_a][in_b];
      // Accumulate the product; mult_result is zero-extended to match out_c's width
      out_c <= out_c + mult_result;
      // Propagate the input values as in your original PE (for systolic array operation)
      out_a <= in_a;
      out_b <= in_b;
    end
  end

endmodule
