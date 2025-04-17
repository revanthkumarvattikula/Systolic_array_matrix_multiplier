`timescale 1ns / 1ps

module pe (clk, reset, in_a, in_b, out_c, out_a, out_b);
    parameter DATA_SIZE = 4;
    
    input clk;
    input reset;
    input [DATA_SIZE-1:0] in_a;
    input [DATA_SIZE-1:0] in_b;
    output reg [2*DATA_SIZE:0] out_c;
    output reg [DATA_SIZE-1:0] out_a;
    output reg [DATA_SIZE-1:0] out_b;

    wire [2*DATA_SIZE-1:0] lut_data;
    wire [2*DATA_SIZE-1:0] addr;

    assign addr = {in_a, in_b};

    rom_lut #(
        .ADDR_WIDTH(2*DATA_SIZE),
        .DATA_WIDTH(2*DATA_SIZE)
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

module rom_lut (addr, data);
    parameter ADDR_WIDTH = 8;
    parameter DATA_WIDTH = 8;
    
    input [ADDR_WIDTH-1:0] addr;
    output reg [DATA_WIDTH-1:0] data;


  always @(*) begin
    case (addr)
      8'd0   : data = 8'd0;
      8'd1   : data = 8'd0;
      8'd2   : data = 8'd0;
      8'd3   : data = 8'd0;
      8'd4   : data = 8'd0;
      8'd5   : data = 8'd0;
      8'd6   : data = 8'd0;
      8'd7   : data = 8'd0;
      8'd8   : data = 8'd0;
      8'd9   : data = 8'd0;
      8'd10  : data = 8'd0;
      8'd11  : data = 8'd0;
      8'd12  : data = 8'd0;
      8'd13  : data = 8'd0;
      8'd14  : data = 8'd0;
      8'd15  : data = 8'd0;
      8'd16  : data = 8'd0;
      8'd17  : data = 8'd1;
      8'd18  : data = 8'd2;
      8'd19  : data = 8'd3;
      8'd20  : data = 8'd4;
      8'd21  : data = 8'd5;
      8'd22  : data = 8'd6;
      8'd23  : data = 8'd7;
      8'd24  : data = 8'd8;
      8'd25  : data = 8'd9;
      8'd26  : data = 8'd10;
      8'd27  : data = 8'd11;
      8'd28  : data = 8'd12;
      8'd29  : data = 8'd13;
      8'd30  : data = 8'd14;
      8'd31  : data = 8'd15;
      8'd32  : data = 8'd0;
      8'd33  : data = 8'd2;
      8'd34  : data = 8'd4;
      8'd35  : data = 8'd6;
      8'd36  : data = 8'd8;
      8'd37  : data = 8'd10;
      8'd38  : data = 8'd12;
      8'd39  : data = 8'd14;
      8'd40  : data = 8'd16;
      8'd41  : data = 8'd18;
      8'd42  : data = 8'd20;
      8'd43  : data = 8'd22;
      8'd44  : data = 8'd24;
      8'd45  : data = 8'd26;
      8'd46  : data = 8'd28;
      8'd47  : data = 8'd30;
      8'd48  : data = 8'd0;
      8'd49  : data = 8'd3;
      8'd50  : data = 8'd6;
      8'd51  : data = 8'd9;
      8'd52  : data = 8'd12;
      8'd53  : data = 8'd15;
      8'd54  : data = 8'd18;
      8'd55  : data = 8'd21;
      8'd56  : data = 8'd24;
      8'd57  : data = 8'd27;
      8'd58  : data = 8'd30;
      8'd59  : data = 8'd33;
      8'd60  : data = 8'd36;
      8'd61  : data = 8'd39;
      8'd62  : data = 8'd42;
      8'd63  : data = 8'd45;
      8'd64  : data = 8'd0;
      8'd65  : data = 8'd4;
      8'd66  : data = 8'd8;
      8'd67  : data = 8'd12;
      8'd68  : data = 8'd16;
      8'd69  : data = 8'd20;
      8'd70  : data = 8'd24;
      8'd71  : data = 8'd28;
      8'd72  : data = 8'd32;
      8'd73  : data = 8'd36;
      8'd74  : data = 8'd40;
      8'd75  : data = 8'd44;
      8'd76  : data = 8'd48;
      8'd77  : data = 8'd52;
      8'd78  : data = 8'd56;
      8'd79  : data = 8'd60;
      8'd80  : data = 8'd0;
      8'd81  : data = 8'd5;
      8'd82  : data = 8'd10;
      8'd83  : data = 8'd15;
      8'd84  : data = 8'd20;
      8'd85  : data = 8'd25;
      8'd86  : data = 8'd30;
      8'd87  : data = 8'd35;
      8'd88  : data = 8'd40;
      8'd89  : data = 8'd45;
      8'd90  : data = 8'd50;
      8'd91  : data = 8'd55;
      8'd92  : data = 8'd60;
      8'd93  : data = 8'd65;
      8'd94  : data = 8'd70;
      8'd95  : data = 8'd75;
      8'd96  : data = 8'd0;
      8'd97  : data = 8'd6;
      8'd98  : data = 8'd12;
      8'd99  : data = 8'd18;
      8'd100 : data = 8'd24;
      8'd101 : data = 8'd30;
      8'd102 : data = 8'd36;
      8'd103 : data = 8'd42;
      8'd104 : data = 8'd48;
      8'd105 : data = 8'd54;
      8'd106 : data = 8'd60;
      8'd107 : data = 8'd66;
      8'd108 : data = 8'd72;
      8'd109 : data = 8'd78;
      8'd110 : data = 8'd84;
      8'd111 : data = 8'd90;
      8'd112 : data = 8'd0;
      8'd113 : data = 8'd7;
      8'd114 : data = 8'd14;
      8'd115 : data = 8'd21;
      8'd116 : data = 8'd28;
      8'd117 : data = 8'd35;
      8'd118 : data = 8'd42;
      8'd119 : data = 8'd49;
      8'd120 : data = 8'd56;
      8'd121 : data = 8'd63;
      8'd122 : data = 8'd70;
      8'd123 : data = 8'd77;
      8'd124 : data = 8'd84;
      8'd125 : data = 8'd91;
      8'd126 : data = 8'd98;
      8'd127 : data = 8'd105;
      8'd128 : data = 8'd0;
      8'd129 : data = 8'd8;
      8'd130 : data = 8'd16;
      8'd131 : data = 8'd24;
      8'd132 : data = 8'd32;
      8'd133 : data = 8'd40;
      8'd134 : data = 8'd48;
      8'd135 : data = 8'd56;
      8'd136 : data = 8'd64;
      8'd137 : data = 8'd72;
      8'd138 : data = 8'd80;
      8'd139 : data = 8'd88;
      8'd140 : data = 8'd96;
      8'd141 : data = 8'd104;
      8'd142 : data = 8'd112;
      8'd143 : data = 8'd120;
      8'd144 : data = 8'd0;
      8'd145 : data = 8'd9;
      8'd146 : data = 8'd18;
      8'd147 : data = 8'd27;
      8'd148 : data = 8'd36;
      8'd149 : data = 8'd45;
      8'd150 : data = 8'd54;
      8'd151 : data = 8'd63;
      8'd152 : data = 8'd72;
      8'd153 : data = 8'd81;
      8'd154 : data = 8'd90;
      8'd155 : data = 8'd99;
      8'd156 : data = 8'd108;
      8'd157 : data = 8'd117;
      8'd158 : data = 8'd126;
      8'd159 : data = 8'd135;
      8'd160 : data = 8'd0;
      8'd161 : data = 8'd10;
      8'd162 : data = 8'd20;
      8'd163 : data = 8'd30;
      8'd164 : data = 8'd40;
      8'd165 : data = 8'd50;
      8'd166 : data = 8'd60;
      8'd167 : data = 8'd70;
      8'd168 : data = 8'd80;
      8'd169 : data = 8'd90;
      8'd170 : data = 8'd100;
      8'd171 : data = 8'd110;
      8'd172 : data = 8'd120;
      8'd173 : data = 8'd130;
      8'd174 : data = 8'd140;
      8'd175 : data = 8'd150;
      8'd176 : data = 8'd0;
      8'd177 : data = 8'd11;
      8'd178 : data = 8'd22;
      8'd179 : data = 8'd33;
      8'd180 : data = 8'd44;
      8'd181 : data = 8'd55;
      8'd182 : data = 8'd66;
      8'd183 : data = 8'd77;
      8'd184 : data = 8'd88;
      8'd185 : data = 8'd99;
      8'd186 : data = 8'd110;
      8'd187 : data = 8'd121;
      8'd188 : data = 8'd132;
      8'd189 : data = 8'd143;
      8'd190 : data = 8'd154;
      8'd191 : data = 8'd165;
      8'd192 : data = 8'd0;
      8'd193 : data = 8'd12;
      8'd194 : data = 8'd24;
      8'd195 : data = 8'd36;
      8'd196 : data = 8'd48;
      8'd197 : data = 8'd60;
      8'd198 : data = 8'd72;
      8'd199 : data = 8'd84;
      8'd200 : data = 8'd96;
      8'd201 : data = 8'd108;
      8'd202 : data = 8'd120;
      8'd203 : data = 8'd132;
      8'd204 : data = 8'd144;
      8'd205 : data = 8'd156;
      8'd206 : data = 8'd168;
      8'd207 : data = 8'd180;
      8'd208 : data = 8'd0;
      8'd209 : data = 8'd13;
      8'd210 : data = 8'd26;
      8'd211 : data = 8'd39;
      8'd212 : data = 8'd52;
      8'd213 : data = 8'd65;
      8'd214 : data = 8'd78;
      8'd215 : data = 8'd91;
      8'd216 : data = 8'd104;
      8'd217 : data = 8'd117;
      8'd218 : data = 8'd130;
      8'd219 : data = 8'd143;
      8'd220 : data = 8'd156;
      8'd221 : data = 8'd169;
      8'd222 : data = 8'd182;
      8'd223 : data = 8'd195;
      8'd224 : data = 8'd0;
      8'd225 : data = 8'd14;
      8'd226 : data = 8'd28;
      8'd227 : data = 8'd42;
      8'd228 : data = 8'd56;
      8'd229 : data = 8'd70;
      8'd230 : data = 8'd84;
      8'd231 : data = 8'd98;
      8'd232 : data = 8'd112;
      8'd233 : data = 8'd126;
      8'd234 : data = 8'd140;
      8'd235 : data = 8'd154;
      8'd236 : data = 8'd168;
      8'd237 : data = 8'd182;
      8'd238 : data = 8'd196;
      8'd239 : data = 8'd210;
      8'd240 : data = 8'd0;
      8'd241 : data = 8'd15;
      8'd242 : data = 8'd30;
      8'd243 : data = 8'd45;
      8'd244 : data = 8'd60;
      8'd245 : data = 8'd75;
      8'd246 : data = 8'd90;
      8'd247 : data = 8'd105;
      8'd248 : data = 8'd120;
      8'd249 : data = 8'd135;
      8'd250 : data = 8'd150;
      8'd251 : data = 8'd165;
      8'd252 : data = 8'd180;
      8'd253 : data = 8'd195;
      8'd254 : data = 8'd210;
      8'd255 : data = 8'd225;
      default: data = 8'd0;
    endcase
  end

endmodule



