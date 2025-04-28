`timescale 1ns / 1ps
module pe_generic(clk, reset, in_a, in_b, out_a, out_b, out_c);

parameter data_size = 4;
input wire reset, clk;
input wire signed [data_size-1:0] in_a, in_b;
output reg signed [data_size-1:0] out_a, out_b;
output reg signed [2*data_size:0] out_c;

// Internal wires
reg signed [2*data_size:0] product;
reg signed [2*data_size:0] sum;
  
// Binary Multiplier (Shift-and-Add) for Signed Numbers
function signed [2*data_size:0] binary_multiplier;
    input signed [data_size-1:0] a, b;
    integer i;
    reg [2*data_size-1:0] abs_a, abs_b;
    reg signed [2*data_size:0] p;
    reg sign;
begin
    abs_a = (a < 0) ? -a : a;
    abs_b = (b < 0) ? -b : b;
    sign = a[data_size-1] ^ b[data_size-1]; // XOR: if signs differ, result is negative

    p = 0;
    for (i = 0; i < data_size; i = i + 1) begin
        if (abs_b[i])
            p = p + (abs_a << i); // unsigned shift-and-add
    end

    if (sign)
        binary_multiplier = -p; // apply sign
    else
        binary_multiplier = p;
end
endfunction

// Ripple Carry Adder
function signed [2*data_size:0] ripple_carry_adder;
    input signed [2*data_size:0] x, y;
    integer i;
    reg carry;
    reg [2*data_size:0] result;
begin
    carry = 0;
    for (i = 0; i <= 2*data_size; i = i + 1) begin
        result[i] = x[i] ^ y[i] ^ carry;
        carry = (x[i] & y[i]) | (x[i] & carry) | (y[i] & carry);
    end
    ripple_carry_adder = result;
end
endfunction

always @(posedge clk) begin
    if (reset) begin
        out_a <= 0;
        out_b <= 0;
        out_c <= 0;
    end
    else begin
        product = binary_multiplier(in_a, in_b);       // Compute in_a * in_b
        sum = ripple_carry_adder(out_c, product);       // Accumulate using ripple carry adder
        out_c <= sum;
        out_a <= in_a;
        out_b <= in_b;
    end
end

endmodule
