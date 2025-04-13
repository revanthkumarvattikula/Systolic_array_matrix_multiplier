`timescale 1ns / 1ps
module pe_DA(clk, reset, in_a, in_b, out_a, out_b, out_c);

  parameter data_size = 8; // Adjustable data width
  
  input wire reset, clk;
  input wire [data_size-1:0] in_a, in_b;
  output reg [2*data_size:0] out_c;
  output reg [data_size-1:0] out_a, out_b;

  // Flattened 1D LUT (synthesizable version)
  reg [(2*data_size)-1:0] lut [0:(1 << (2 * data_size)) - 1];
  reg [(2*data_size)-1:0] mult_result;
  
  wire [(2 * data_size) - 1:0] addr;
  assign addr = {in_a, in_b}; // Concatenate inputs to form the address

  integer i;

  // Simulation-only init block, gets ignored in synthesis.
  // Remove this block for synthesis and load lut_data.hex instead.
  initial begin
    // Uncomment this for simulation or remove for synthesis
    /*
    for (i = 0; i < (1 << (2 * data_size)); i = i + 1) begin
      lut[i] = (i >> data_size) * (i & ((1 << data_size) - 1)); // simulate i * j
    end
    */
    
    // Synthesis-compatible memory load (use `lut_data.hex`)
    $readmemh("lut_data.hex", lut);
  end

  always @(posedge clk) begin
    if (reset) begin
      out_a <= 0;
      out_b <= 0;
      out_c <= 0;
    end else begin
      mult_result = lut[addr];
      out_c <= out_c + mult_result;
      out_a <= in_a;
      out_b <= in_b;
    end
  end

endmodule
