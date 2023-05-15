`timescale 1ns/100ps

module tb_fft_0();

    reg clk;
    reg rst;
    reg [23:0] butt16_real0;
    reg [23:0] butt16_imag0;
    reg [23:0] butt16_real1;
    reg [23:0] butt16_imag1;
    reg [23:0] butt16_real2;
    reg [23:0] butt16_imag2;
    reg [23:0] butt16_real3;
    reg [23:0] butt16_imag3;
    reg [23:0] butt16_real4;
    reg [23:0] butt16_imag4;
    reg [23:0] butt16_real5;
    reg [23:0] butt16_imag5;
    reg [23:0] butt16_real6;
    reg [23:0] butt16_imag6;
    reg [23:0] butt16_real7;
    reg [23:0] butt16_imag7;
    reg [23:0] butt16_real8;
    reg [23:0] butt16_imag8;
    reg [23:0] butt16_real9;
    reg [23:0] butt16_imag9;
    reg [23:0] butt16_real10;
    reg [23:0] butt16_imag10;
    reg [23:0] butt16_real11;
    reg [23:0] butt16_imag11;
    reg [23:0] butt16_real12;
    reg [23:0] butt16_imag12;
    reg [23:0] butt16_real13;
    reg [23:0] butt16_imag13;
    reg [23:0] butt16_real14;
    reg [23:0] butt16_imag14;
    reg [23:0] butt16_real15;
    reg [23:0] butt16_imag15;

    wire [23:0] y0_real_fin;
    wire [23:0] y0_imag_fin;
    wire [23:0] y1_real_fin;
    wire [23:0] y1_imag_fin;
    wire [23:0] y2_real_fin;
    wire [23:0] y2_imag_fin;
    wire [23:0] y3_real_fin;
    wire [23:0] y3_imag_fin;
    wire [23:0] y4_real_fin;
    wire [23:0] y4_imag_fin;
    wire [23:0] y5_real_fin;
    wire [23:0] y5_imag_fin;
    wire [23:0] y6_real_fin;
    wire [23:0] y6_imag_fin;
    wire [23:0] y7_real_fin;
    wire [23:0] y7_imag_fin;
    wire [23:0] y8_real_fin;
    wire [23:0] y8_imag_fin;
    wire [23:0] y9_real_fin;
    wire [23:0] y9_imag_fin;
    wire [23:0] y10_real_fin;
    wire [23:0] y10_imag_fin;
    wire [23:0] y11_real_fin;
    wire [23:0] y11_imag_fin;
    wire [23:0] y12_real_fin;
    wire [23:0] y12_imag_fin;
    wire [23:0] y13_real_fin;
    wire [23:0] y13_imag_fin;
    wire [23:0] y14_real_fin;
    wire [23:0] y14_imag_fin;
    wire [23:0] y15_real_fin;
    wire [23:0] y15_imag_fin;

fft_0 u_fft_0(
    .clk(clk),
    .rst(rst),
    .butt16_real0 (butt16_real0 ),
    .butt16_imag0 (butt16_imag0 ),
    .butt16_real1 (butt16_real1 ),
    .butt16_imag1 (butt16_imag1 ),
    .butt16_real2 (butt16_real2 ),
    .butt16_imag2 (butt16_imag2 ),
    .butt16_real3 (butt16_real3 ),
    .butt16_imag3 (butt16_imag3 ),
    .butt16_real4 (butt16_real4 ),
    .butt16_imag4 (butt16_imag4 ),
    .butt16_real5 (butt16_real5 ),
    .butt16_imag5 (butt16_imag5 ),
    .butt16_real6 (butt16_real6 ),
    .butt16_imag6 (butt16_imag6 ),
    .butt16_real7 (butt16_real7 ),
    .butt16_imag7 (butt16_imag7 ),
    .butt16_real8 (butt16_real8 ),
    .butt16_imag8 (butt16_imag8 ),
    .butt16_real9 (butt16_real9 ),
    .butt16_imag9 (butt16_imag9 ),
    .butt16_real10(butt16_real10),
    .butt16_imag10(butt16_imag10),
    .butt16_real11(butt16_real11),
    .butt16_imag11(butt16_imag11),
    .butt16_real12(butt16_real12),
    .butt16_imag12(butt16_imag12),
    .butt16_real13(butt16_real13),
    .butt16_imag13(butt16_imag13),
    .butt16_real14(butt16_real14),
    .butt16_imag14(butt16_imag14),
    .butt16_real15(butt16_real15),
    .butt16_imag15(butt16_imag15),

    .y0_real_fin (y0_real_fin ),
    .y0_imag_fin (y0_imag_fin ),
    .y1_real_fin (y1_real_fin ),
    .y1_imag_fin (y1_imag_fin ),
    .y2_real_fin (y2_real_fin ),
    .y2_imag_fin (y2_imag_fin ),
    .y3_real_fin (y3_real_fin ),
    .y3_imag_fin (y3_imag_fin ),
    .y4_real_fin (y4_real_fin ),
    .y4_imag_fin (y4_imag_fin ),
    .y5_real_fin (y5_real_fin ),
    .y5_imag_fin (y5_imag_fin ),
    .y6_real_fin (y6_real_fin ),
    .y6_imag_fin (y6_imag_fin ),
    .y7_real_fin (y7_real_fin ),
    .y7_imag_fin (y7_imag_fin ),
    .y8_real_fin (y8_real_fin ),
    .y8_imag_fin (y8_imag_fin ),
    .y9_real_fin (y9_real_fin ),
    .y9_imag_fin (y9_imag_fin ),
    .y10_real_fin(y10_real_fin),
    .y10_imag_fin(y10_imag_fin),
    .y11_real_fin(y11_real_fin),
    .y11_imag_fin(y11_imag_fin),
    .y12_real_fin(y12_real_fin),
    .y12_imag_fin(y12_imag_fin),
    .y13_real_fin(y13_real_fin),
    .y13_imag_fin(y13_imag_fin),
    .y14_real_fin(y14_real_fin),
    .y14_imag_fin(y14_imag_fin),
    .y15_real_fin(y15_real_fin),
    .y15_imag_fin(y15_imag_fin) 
);

initial
begin
clk = 0;
rst = 0;

#10 rst = 1;
butt16_imag0 = 24'd0;
butt16_imag1 = 24'd0;
butt16_imag2 = 24'd0;
butt16_imag3 = 24'd0;
butt16_imag4 = 24'd0;
butt16_imag5 = 24'd0;
butt16_imag6 = 24'd0;
butt16_imag7 = 24'd0;
butt16_imag8 = 24'd0;
butt16_imag9 = 24'd0;
butt16_imag10= 24'd0;
butt16_imag11= 24'd0;
butt16_imag12= 24'd0;
butt16_imag13= 24'd0;
butt16_imag14= 24'd0;
butt16_imag15= 24'd0;

butt16_real0 = 24'd1;
butt16_real1 = 24'd2;
butt16_real2 = 24'd3;
butt16_real3 = 24'd4;
butt16_real4 = 24'd1;
butt16_real5 = 24'd2;
butt16_real6 = 24'd3;
butt16_real7 = 24'd4;
butt16_real8 = 24'd1;
butt16_real9 = 24'd2;
butt16_real10= 24'd3;
butt16_real11= 24'd4;
butt16_real12= 24'd1;
butt16_real13= 24'd2;
butt16_real14= 24'd3;
butt16_real15= 24'd4;

#10;
butt16_real0 = 24'd1;
butt16_real1 = 24'd2;
butt16_real2 = 24'd3;
butt16_real3 = 24'd4;
butt16_real4 = 24'd5;
butt16_real5 = 24'd6;
butt16_real6 = 24'd7;
butt16_real7 = 24'd8;
butt16_real8 = 24'd1;
butt16_real9 = 24'd2;
butt16_real10= 24'd3;
butt16_real11= 24'd4;
butt16_real12= 24'd5;
butt16_real13= 24'd6;
butt16_real14= 24'd7;
butt16_real15= 24'd8;
end  
always #1 clk = ~clk;

endmodule