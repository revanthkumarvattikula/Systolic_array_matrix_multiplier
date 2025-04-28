`timescale 1ns / 1ps

module pe_DA #(parameter data_size = 4)(
  input wire clk,
  input wire reset,
  input wire [data_size-1:0] in_a,
  input wire [data_size-1:0] in_b,
  output reg signed [2*data_size:0] out_c,
  output reg [data_size-1:0] out_a,
  output reg [data_size-1:0] out_b
);

  wire signed [2*data_size-1:0] lut_data;
  wire [2*data_size-1:0] addr;

  assign addr = {in_a, in_b};

  rom_lut #(
    .ADDR_WIDTH(2*data_size),
    .DATA_WIDTH(2*data_size)
  ) rom_inst (
    .addr(addr),
    .data(lut_data)
  );

  always @(posedge clk) begin
    if (reset) begin
      out_c <= 0;
      out_a <= 0;
      out_b <= 0;
    end else begin
      out_c <= out_c + lut_data;
      out_a <= in_a;
      out_b <= in_b;
    end
  end

endmodule


module rom_lut #(
  parameter ADDR_WIDTH = 8,
  parameter DATA_WIDTH = 8
)(
  input  wire [ADDR_WIDTH-1:0] addr,
  output reg signed [DATA_WIDTH-1:0] data
);

  always @(*) begin
    case (addr)
    
      8'h00: data = 8'h00;    8'h01: data = 8'h00;    8'h02: data = 8'h00;    8'h03: data = 8'h00;
      8'h04: data = 8'h00;    8'h05: data = 8'h00;    8'h06: data = 8'h00;    8'h07: data = 8'h00;
      8'h08: data = 8'h00;    8'h09: data = 8'h00;    8'h0A: data = 8'h00;    8'h0B: data = 8'h00;
      8'h0C: data = 8'h00;    8'h0D: data = 8'h00;    8'h0E: data = 8'h00;    8'h0F: data = 8'h00;

    
      8'h10: data = 8'h00;    8'h11: data = 8'h01;    8'h12: data = 8'h02;    8'h13: data = 8'h03;
      8'h14: data = 8'h04;    8'h15: data = 8'h05;    8'h16: data = 8'h06;    8'h17: data = 8'h07;
      8'h18: data = 8'hF8;   8'h19: data = 8'hF9;   8'h1A: data = 8'hFA;   8'h1B: data = 8'hFB;
      8'h1C: data = 8'hFC;   8'h1D: data = 8'hFD;   8'h1E: data = 8'hFE;   8'h1F: data = 8'hFF;

      
      8'h20: data = 8'h00;    8'h21: data = 8'h02;    8'h22: data = 8'h04;    8'h23: data = 8'h06;
      8'h24: data = 8'h08;    8'h25: data = 8'h0A;   8'h26: data = 8'h0C;   8'h27: data = 8'h0E;
      8'h28: data = 8'hF0;  8'h29: data = 8'hF2;  8'h2A: data = 8'hF4;  8'h2B: data = 8'hF6;
      8'h2C: data = 8'hF8;   8'h2D: data = 8'hFA;   8'h2E: data = 8'hFC;   8'h2F: data = 8'hFE;

     
      8'h30: data = 8'h00;    8'h31: data = 8'h03;    8'h32: data = 8'h06;    8'h33: data = 8'h09;
      8'h34: data = 8'h0C;   8'h35: data = 8'h0F;   8'h36: data = 8'h12;   8'h37: data = 8'h15;
      8'h38: data = 8'hE8;  8'h39: data = 8'hEB;  8'h3A: data = 8'hEE;  8'h3B: data = 8'hF1;
      8'h3C: data = 8'hF4;  8'h3D: data = 8'hF7;   8'h3E: data = 8'hFA;   8'h3F: data = 8'hFD;

     
      8'h40: data = 8'h00;    8'h41: data = 8'h04;    8'h42: data = 8'h08;    8'h43: data = 8'h0C;
      8'h44: data = 8'h10;   8'h45: data = 8'h14;   8'h46: data = 8'h18;   8'h47: data = 8'h1C;
      8'h48: data = 8'hE0;  8'h49: data = 8'hE4;  8'h4A: data = 8'hE8;  8'h4B: data = 8'hEC;
      8'h4C: data = 8'hF0;  8'h4D: data = 8'hF4;   8'h4E: data = 8'hF8;   8'h4F: data = 8'hFC;

      
      8'h50: data = 8'h00;    8'h51: data = 8'h05;    8'h52: data = 8'h0A;   8'h53: data = 8'h0F;
      8'h54: data = 8'h14;   8'h55: data = 8'h19;   8'h56: data = 8'h1E;   8'h57: data = 8'h23;
      8'h58: data = 8'hD8;  8'h59: data = 8'hDD;  8'h5A: data = 8'hE2;  8'h5B: data = 8'hE7;
      8'h5C: data = 8'hEC;  8'h5D: data = 8'hF1;   8'h5E: data = 8'hF6;   8'h5F: data = 8'hFB;

      
      8'h60: data = 8'h00;    8'h61: data = 8'h06;    8'h62: data = 8'h0C;   8'h63: data = 8'h12;
      8'h64: data = 8'h18;   8'h65: data = 8'h1E;   8'h66: data = 8'h24;   8'h67: data = 8'h2A;
      8'h68: data = 8'hD0;  8'h69: data = 8'hD6;  8'h6A: data = 8'hDC;  8'h6B: data = 8'hE2;
      8'h6C: data = 8'hE8;  8'h6D: data = 8'hEE;   8'h6E: data = 8'hF4;   8'h6F: data = 8'hFA;

      
      8'h70: data = 8'h00;    8'h71: data = 8'h07;    8'h72: data = 8'h0E;   8'h73: data = 8'h15;
      8'h74: data = 8'h1C;   8'h75: data = 8'h23;   8'h76: data = 8'h2A;   8'h77: data = 8'h31;
      8'h78: data = 8'hC8;  8'h79: data = 8'hCF;  8'h7A: data = 8'hD6;  8'h7B: data = 8'hDD;
      8'h7C: data = 8'hE4;  8'h7D: data = 8'hEB;   8'h7E: data = 8'hF2;   8'h7F: data = 8'hF9;

      
      8'h80: data = 8'h00;    8'h81: data = 8'hF8;   8'h82: data = 8'hF0;  8'h83: data = 8'hE8;
      8'h84: data = 8'hE0;  8'h85: data = 8'hD8;  8'h86: data = 8'hD0;  8'h87: data = 8'hC8;
      8'h88: data = 8'h40;   8'h89: data = 8'h38;   8'h8A: data = 8'h30;   8'h8B: data = 8'h28;
      8'h8C: data = 8'h20;   8'h8D: data = 8'h18;   8'h8E: data = 8'h10;   8'h8F: data = 8'h08;

      
      8'h90: data = 8'h00;    8'h91: data = 8'hF9;   8'h92: data = 8'hF2;  8'h93: data = 8'hEB;
      8'h94: data = 8'hE4;  8'h95: data = 8'hDD;  8'h96: data = 8'hD6;  8'h97: data = 8'hCF;
      8'h98: data = 8'h38;   8'h99: data = 8'h31;   8'h9A: data = 8'h2A;   8'h9B: data = 8'h23;
      8'h9C: data = 8'h1C;   8'h9D: data = 8'h15;   8'h9E: data = 8'h0E;   8'h9F: data = 8'h07;

      
      8'hA0: data = 8'h00;    8'hA1: data = 8'hFA;   8'hA2: data = 8'hF4;  8'hA3: data = 8'hEE;
      8'hA4: data = 8'hE8;  8'hA5: data = 8'hE2;  8'hA6: data = 8'hDC;  8'hA7: data = 8'hD6;
      8'hA8: data = 8'h30;   8'hA9: data = 8'h2A;   8'hAA: data = 8'h24;   8'hAB: data = 8'h1E;
      8'hAC: data = 8'h18;   8'hAD: data = 8'h12;   8'hAE: data = 8'h0C;   8'hAF: data = 8'h06;

      
      8'hB0: data = 8'h00;    8'hB1: data = 8'hFB;   8'hB2: data = 8'hF6;  8'hB3: data = 8'hF1;
      8'hB4: data = 8'hEC;  8'hB5: data = 8'hE7;  8'hB6: data = 8'hE2;  8'hB7: data = 8'hDD;
      8'hB8: data = 8'h28;   8'hB9: data = 8'h23;   8'hBA: data = 8'h1E;   8'hBB: data = 8'h19;
      8'hBC: data = 8'h14;   8'hBD: data = 8'h0F;   8'hBE: data = 8'h0A;   8'hBF: data = 8'h05;

      
      8'hC0: data = 8'h00;    8'hC1: data = 8'hFC;   8'hC2: data = 8'hF8;   8'hC3: data = 8'hF4;
      8'hC4: data = 8'hF0;  8'hC5: data = 8'hEC;  8'hC6: data = 8'hE8;  8'hC7: data = 8'hE4;
      8'hC8: data = 8'h20;   8'hC9: data = 8'h1C;   8'hCA: data = 8'h18;   8'hCB: data = 8'h14;
      8'hCC: data = 8'h10;   8'hCD: data = 8'h0C;   8'hCE: data = 8'h08;    8'hCF: data = 8'h04;

      
      8'hD0: data = 8'h00;    8'hD1: data = 8'hFD;   8'hD2: data = 8'hFA;   8'hD3: data = 8'hF7;
      8'hD4: data = 8'hF4;  8'hD5: data = 8'hF1;  8'hD6: data = 8'hEE;  8'hD7: data = 8'hEB;
      8'hD8: data = 8'h18;   8'hD9: data = 8'h15;   8'hDA: data = 8'h12;   8'hDB: data = 8'h0F;
      8'hDC: data = 8'h0C;   8'hDD: data = 8'h09;    8'hDE: data = 8'h06;    8'hDF: data = 8'h03;

      
      8'hE0: data = 8'h00;    8'hE1: data = 8'hFE;   8'hE2: data = 8'hFC;   8'hE3: data = 8'hFA;
      8'hE4: data = 8'hF8;   8'hE5: data = 8'hF6;  8'hE6: data = 8'hF4;  8'hE7: data = 8'hF2;
      8'hE8: data = 8'h10;   8'hE9: data = 8'h0E;   8'hEA: data = 8'h0C;   8'hEB: data = 8'h0A;
      8'hEC: data = 8'h08;    8'hED: data = 8'h06;    8'hEE: data = 8'h04;    8'hEF: data = 8'h02;

      
      8'hF0: data = 8'h00;    8'hF1: data = 8'hFF;   8'hF2: data = 8'hFE;   8'hF3: data = 8'hFD;
      8'hF4: data = 8'hFC;   8'hF5: data = 8'hFB;   8'hF6: data = 8'hFA;   8'hF7: data = 8'hF9;
      8'hF8: data = 8'h08;    8'hF9: data = 8'h07;    8'hFA: data = 8'h06;    8'hFB: data = 8'h05;
      8'hFC: data = 8'h04;    8'hFD: data = 8'h03;    8'hFE: data = 8'h02;    8'hFF: data = 8'h01;

      default: data = 8'h00;
    endcase
  end

endmodule
