module pe_DA_modified (
  input  clk,
  input  reset,
  input  [3:0] in_a,
  input  [3:0] in_b,
  output [3:0] out_a,
  output [3:0] out_b,
  output reg [8:0] out_c
);
  wire [2:0] a_mag, b_mag;
  wire a_sign, b_sign;
  wire [6:0] product_mag;  // Changed to 7 bits
  wire product_sign;
  wire [6:0] product_twoscomp;
  wire [8:0] adder_sum;
  wire overflow;
  reg [3:0] out_a_reg, out_b_reg;
  
  twoscomp_to_signmag_4bit conv_a (in_a, a_mag, a_sign);
  twoscomp_to_signmag_4bit conv_b (in_b, b_mag, b_sign);
  
  wire [2:0] lo = (a_mag <= b_mag) ? a_mag : b_mag;
  wire [2:0] hi = (a_mag <= b_mag) ? b_mag : a_mag;
  
  rom_lut_25 rom_inst ({lo, hi}, product_mag);
  
  assign product_sign = a_sign ^ b_sign;
  
  signmag_to_twoscomp_7bit conv_product (product_mag, product_sign, product_twoscomp);
  
  twoscomp_adder_9bit accumulator (out_c, product_twoscomp, adder_sum, overflow);
  
  always @(posedge clk) begin
    if (reset) begin
      out_c <= 0;
      out_a_reg <= 0;
      out_b_reg <= 0;
    end else begin
      out_c <= overflow ? (product_twoscomp[6] ? 9'h100 : 9'h0FF) : adder_sum;
      out_a_reg <= in_a;
      out_b_reg <= in_b;
    end
  end
  
  assign out_a = out_a_reg;
  assign out_b = out_b_reg;
endmodule



module twoscomp_to_signmag_4bit (
  input  [3:0] twoscomp_in,
  output [2:0] magnitude_out,
  output sign_out
);
  assign sign_out = twoscomp_in[3];
  assign magnitude_out = sign_out ? (~twoscomp_in[2:0] + 1'b1) : twoscomp_in[2:0];
endmodule

module rom_lut_25(
  input  [5:0] addr,
  output reg [6:0] data  // Increased to 7 bits to handle up to 64
);
  always @(*) begin
    case (addr)
      6'b001001: data = 7'd1;
      6'b001010: data = 7'd2;
      6'b001011: data = 7'd3;
      6'b001100: data = 7'd4;
      6'b001101: data = 7'd5;
      6'b001110: data = 7'd6;
      6'b001111: data = 7'd7;
      6'b010010: data = 7'd4;
      6'b010011: data = 7'd6;
      6'b010100: data = 7'd8;
      6'b010101: data = 7'd10;
      6'b010110: data = 7'd12;
      6'b010111: data = 7'd14;
      6'b011011: data = 7'd9;
      6'b011100: data = 7'd12;
      6'b011101: data = 7'd15;
      6'b011110: data = 7'd18;
      6'b011111: data = 7'd21;
      6'b100100: data = 7'd16;
      6'b100101: data = 7'd20;
      6'b100110: data = 7'd24;
      6'b100111: data = 7'd28;
      6'b101101: data = 7'd25;
      6'b101110: data = 7'd30;
      6'b101111: data = 7'd35;
      6'b110110: data = 7'd36;
      6'b110111: data = 7'd42;
      6'b111111: data = 7'd49;
      default: data = 7'd0;
    endcase
  end
endmodule

module signmag_to_twoscomp_7bit (
  input  [6:0] magnitude_in,
  input  sign_in,
  output [6:0] twoscomp_out
);
  assign twoscomp_out = sign_in ? (~magnitude_in + 1'b1) : magnitude_in;
endmodule

module twoscomp_adder_9bit (
  input  [8:0] a,
  input  [6:0] b,  // Changed to 7-bit input
  output [8:0] sum,
  output overflow
);
  wire [8:0] sign_ext_b = {{2{b[6]}}, b};
  wire [9:0] temp_sum = {a[8], a} + {sign_ext_b[8], sign_ext_b};
  
  assign sum = temp_sum[8:0];
  assign overflow = (a[8] == sign_ext_b[8]) && (temp_sum[8] != a[8]);
endmodule
