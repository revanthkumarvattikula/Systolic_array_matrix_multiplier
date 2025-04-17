`timescale 1ns / 1ps
module pe(clk, reset, in_a, in_b, out_a, out_b, out_c);

  parameter data_size = 8; // You can adjust this; note that large values increase LUT size exponentially.
  
  input  wire reset, clk;
  input  wire [data_size-1:0] in_a, in_b;
  output reg  [2*data_size:0] out_c;
  output reg  [data_size-1:0] out_a, out_b;
  
  // Define the offset value for converting offset-binary to signed.
  // For example, if data_size = 8, OFFSET = 2^(8-1) = 128.
  localparam integer OFFSET = 1 << (data_size - 1);
  
  // Reduced LUT: We only store products for numbers from 0 to OFFSET.
  // This creates a LUT with dimensions (OFFSET+1) x (OFFSET+1).
  reg [2*data_size-1:0] lut [0:OFFSET][0:OFFSET];
  
  integer i, j;
  // Precompute the products for the reduced range.
  initial begin
    for (i = 0; i <= OFFSET; i = i + 1) begin
      for (j = 0; j <= OFFSET; j = j + 1) begin
        lut[i][j] = i * j;
      end
    end
  end
  
  // Internal signals for the multiplication process:
  // Convert the offset-binary input to a signed value by subtracting OFFSET.
  reg signed [data_size:0] a_signed, b_signed;
  // Compute the absolute value (the LUT only stores nonnegative values).
  reg [data_size-1:0] a_abs, b_abs;
  // Flags to record if the signed value is negative.
  reg a_negative, b_negative;
  // The product of the absolute values from the LUT (2*data_size bits wide).
  reg signed [2*data_size-1:0] abs_product;
  // final_product will be the complete product after applying offset corrections.
  reg signed [2*data_size:0] final_product;
  
  always @(posedge clk) begin
    if (reset) begin
      out_a <= 0;
      out_b <= 0;
      out_c <= 0;
    end else begin
      // 1. Convert offset-binary inputs to true signed numbers.
      //    For example, if in_a is 0 (in offset-binary), then a_signed becomes 0 - OFFSET = -OFFSET.
      a_signed = $signed({1'b0, in_a}) - OFFSET;
      b_signed = $signed({1'b0, in_b}) - OFFSET;
      
      // 2. Determine the sign and absolute value of each operand.
      a_negative = (a_signed < 0);
      b_negative = (b_signed < 0);
      a_abs = a_negative ? -a_signed : a_signed;
      b_abs = b_negative ? -b_signed : b_signed;
      
      // 3. Use the reduced LUT to get the product of the absolute values.
      abs_product = lut[a_abs][b_abs];
      
      // 4. Adjust the sign of the product:
      //    If exactly one of the operands is negative, the product must be negative.
      if (a_negative ^ b_negative)
        abs_product = -abs_product;
      
      // 5. Apply the offset correction.
      //    Using the derived formula:
      //      A * B = (a_signed * b_signed) + OFFSET*(a_signed + b_signed) + OFFSET^2,
      //    where A and B are the original (offset-binary) numbers.
      final_product = abs_product + OFFSET*(a_signed + b_signed) + (OFFSET * OFFSET);
      
      // Now, final_product equals the same value as in_a * in_b.
      // 6. Accumulate the final product.
      out_c <= out_c + final_product;
      
      // 7. Propagate the original inputs (for the systolic array operation).
      out_a <= in_a;
      out_b <= in_b;
    end
  end

endmodule
