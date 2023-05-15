/****************************/
//作者:Wei Xuejing
//邮箱:2682152871@qq.com
//描述:16点并行流水fft
//时间:2023.05.13
/****************************/
module fft_3 #(
    parameter RST_LVL = 1'b0
)(
    input clk,
    input rst,
    input [23:0] butt16_real0,
    input [23:0] butt16_imag0,
    input [23:0] butt16_real1,
    input [23:0] butt16_imag1,
    input [23:0] butt16_real2,
    input [23:0] butt16_imag2,
    input [23:0] butt16_real3,
    input [23:0] butt16_imag3,
    input [23:0] butt16_real4,
    input [23:0] butt16_imag4,
    input [23:0] butt16_real5,
    input [23:0] butt16_imag5,
    input [23:0] butt16_real6,
    input [23:0] butt16_imag6,
    input [23:0] butt16_real7,
    input [23:0] butt16_imag7,
    input [23:0] butt16_real8,
    input [23:0] butt16_imag8,
    input [23:0] butt16_real9,
    input [23:0] butt16_imag9,
    input [23:0] butt16_real10,
    input [23:0] butt16_imag10,
    input [23:0] butt16_real11,
    input [23:0] butt16_imag11,
    input [23:0] butt16_real12,
    input [23:0] butt16_imag12,
    input [23:0] butt16_real13,
    input [23:0] butt16_imag13,
    input [23:0] butt16_real14,
    input [23:0] butt16_imag14,
    input [23:0] butt16_real15,
    input [23:0] butt16_imag15,

    output [23:0] y0_real_fin,
    output [23:0] y0_imag_fin,
    output [23:0] y1_real_fin,
    output [23:0] y1_imag_fin,
    output [23:0] y2_real_fin,
    output [23:0] y2_imag_fin,
    output [23:0] y3_real_fin,
    output [23:0] y3_imag_fin,
    output [23:0] y4_real_fin,
    output [23:0] y4_imag_fin,
    output [23:0] y5_real_fin,
    output [23:0] y5_imag_fin,
    output [23:0] y6_real_fin,
    output [23:0] y6_imag_fin,
    output [23:0] y7_real_fin,
    output [23:0] y7_imag_fin,
    output [23:0] y8_real_fin,
    output [23:0] y8_imag_fin,
    output [23:0] y9_real_fin,
    output [23:0] y9_imag_fin,
    output [23:0] y10_real_fin,
    output [23:0] y10_imag_fin,
    output [23:0] y11_real_fin,
    output [23:0] y11_imag_fin,
    output [23:0] y12_real_fin,
    output [23:0] y12_imag_fin,
    output [23:0] y13_real_fin,
    output [23:0] y13_imag_fin,
    output [23:0] y14_real_fin,
    output [23:0] y14_imag_fin,
    output [23:0] y15_real_fin,
    output [23:0] y15_imag_fin       
);

localparam factor_real0 = 32'h00002000;
localparam factor_imag0 = 32'h00000000;
localparam factor_real1 = 32'h00001D90;
localparam factor_imag1 = 32'hffffF3C1;
localparam factor_real2 = 32'h000016A1;
localparam factor_imag2 = 32'hFFFFE95F;
localparam factor_real3 = 32'h00000C3F;
localparam factor_imag3 = 32'hFFFFE270;
localparam factor_real4 = 32'h00000000;
localparam factor_imag4 = 32'hFFFFE000;
localparam factor_real5 = 32'hFFFFF3C1;
localparam factor_imag5 = 32'hFFFFE270;
localparam factor_real6 = 32'hFFFFE95F;
localparam factor_imag6 = 32'hFFFFE95F;
localparam factor_real7 = 32'hFFFFE270;
localparam factor_imag7 = 32'hFFFFF3C1;

//第一级运算结果
wire [23:0] out_0_real0;
wire [23:0] out_0_imag0;
wire [23:0] out_0_real1;
wire [23:0] out_0_imag1;
wire [23:0] out_0_real2;
wire [23:0] out_0_imag2;
wire [23:0] out_0_real3;
wire [23:0] out_0_imag3;
wire [23:0] out_0_real4;
wire [23:0] out_0_imag4;
wire [23:0] out_0_real5;
wire [23:0] out_0_imag5;
wire [23:0] out_0_real6;
wire [23:0] out_0_imag6;
wire [23:0] out_0_real7;
wire [23:0] out_0_imag7;
wire [23:0] out_0_real8;
wire [23:0] out_0_imag8;
wire [23:0] out_0_real9;
wire [23:0] out_0_imag9;
wire [23:0] out_0_real10;
wire [23:0] out_0_imag10;
wire [23:0] out_0_real11;
wire [23:0] out_0_imag11;
wire [23:0] out_0_real12;
wire [23:0] out_0_imag12;
wire [23:0] out_0_real13;
wire [23:0] out_0_imag13;
wire [23:0] out_0_real14;
wire [23:0] out_0_imag14;
wire [23:0] out_0_real15;
wire [23:0] out_0_imag15;

butter_2 u_0_0(
  .clk(clk),
  .rst(rst),
  .butt2_real0(butt16_real0),
  .butt2_imag0(butt16_imag0),
  .butt2_real1(butt16_real8),
  .butt2_imag1(butt16_imag8),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_0_real0),
  .y0_imag    (out_0_imag0),
  .y1_real    (out_0_real1),
  .y1_imag    (out_0_imag1)
);
butter_2 u_0_1(
  .clk(clk),
  .rst(rst),
  .butt2_real0(butt16_real4),
  .butt2_imag0(butt16_imag4),
  .butt2_real1(butt16_real12),
  .butt2_imag1(butt16_imag12),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_0_real2),
  .y0_imag    (out_0_imag2),
  .y1_real    (out_0_real3),
  .y1_imag    (out_0_imag3)
);
butter_2 u_0_2(
  .clk(clk),
  .rst(rst),
  .butt2_real0(butt16_real2),
  .butt2_imag0(butt16_imag2),
  .butt2_real1(butt16_real10),
  .butt2_imag1(butt16_imag10),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_0_real4),
  .y0_imag    (out_0_imag4),
  .y1_real    (out_0_real5),
  .y1_imag    (out_0_imag5)
);
butter_2 u_0_3(
  .clk(clk),
  .rst(rst),
  .butt2_real0(butt16_real6),
  .butt2_imag0(butt16_imag6),
  .butt2_real1(butt16_real14),
  .butt2_imag1(butt16_imag14),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_0_real6),
  .y0_imag    (out_0_imag6),
  .y1_real    (out_0_real7),
  .y1_imag    (out_0_imag7)
);
butter_2 u_0_4(
  .clk(clk),
  .rst(rst),
  .butt2_real0(butt16_real1),
  .butt2_imag0(butt16_imag1),
  .butt2_real1(butt16_real9),
  .butt2_imag1(butt16_imag9),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_0_real8),
  .y0_imag    (out_0_imag8),
  .y1_real    (out_0_real9),
  .y1_imag    (out_0_imag9)
);
butter_2 u_0_5(
  .clk(clk),
  .rst(rst),
  .butt2_real0(butt16_real5),
  .butt2_imag0(butt16_imag5),
  .butt2_real1(butt16_real13),
  .butt2_imag1(butt16_imag13),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_0_real10),
  .y0_imag    (out_0_imag10),
  .y1_real    (out_0_real11),
  .y1_imag    (out_0_imag11)
);
butter_2 u_0_6(
  .clk(clk),
  .rst(rst),
  .butt2_real0(butt16_real3),
  .butt2_imag0(butt16_imag3),
  .butt2_real1(butt16_real11),
  .butt2_imag1(butt16_imag11),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_0_real12),
  .y0_imag    (out_0_imag12),
  .y1_real    (out_0_real13),
  .y1_imag    (out_0_imag13)
);
butter_2 u_0_7(
  .clk(clk),
  .rst(rst),
  .butt2_real0(butt16_real7),
  .butt2_imag0(butt16_imag7),
  .butt2_real1(butt16_real15),
  .butt2_imag1(butt16_imag15),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_0_real14),
  .y0_imag    (out_0_imag14),
  .y1_real    (out_0_real15),
  .y1_imag    (out_0_imag15)
);





















//第二级
wire [23:0] out_1_real0;
wire [23:0] out_1_imag0;
wire [23:0] out_1_real1;
wire [23:0] out_1_imag1;
wire [23:0] out_1_real2;
wire [23:0] out_1_imag2;
wire [23:0] out_1_real3;
wire [23:0] out_1_imag3;
wire [23:0] out_1_real4;
wire [23:0] out_1_imag4;
wire [23:0] out_1_real5;
wire [23:0] out_1_imag5;
wire [23:0] out_1_real6;
wire [23:0] out_1_imag6;
wire [23:0] out_1_real7;
wire [23:0] out_1_imag7;
wire [23:0] out_1_real8;
wire [23:0] out_1_imag8;
wire [23:0] out_1_real9;
wire [23:0] out_1_imag9;
wire [23:0] out_1_real10;
wire [23:0] out_1_imag10;
wire [23:0] out_1_real11;
wire [23:0] out_1_imag11;
wire [23:0] out_1_real12;
wire [23:0] out_1_imag12;
wire [23:0] out_1_real13;
wire [23:0] out_1_imag13;
wire [23:0] out_1_real14;
wire [23:0] out_1_imag14;
wire [23:0] out_1_real15;
wire [23:0] out_1_imag15;

butter_2 u_1_0(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_0_real0),
  .butt2_imag0(out_0_imag0),
  .butt2_real1(out_0_real2),
  .butt2_imag1(out_0_imag2),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_1_real0),
  .y0_imag    (out_1_imag0),
  .y1_real    (out_1_real2),
  .y1_imag    (out_1_imag2)
);
butter_2 u_1_1(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_0_real1),
  .butt2_imag0(out_0_imag1),
  .butt2_real1(out_0_real3),
  .butt2_imag1(out_0_imag3),
  .factor_real(factor_real4),
  .factor_imag(factor_imag4),
  .y0_real    (out_1_real1),
  .y0_imag    (out_1_imag1),
  .y1_real    (out_1_real3),
  .y1_imag    (out_1_imag3)
);

butter_2 u_1_2(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_0_real4),
  .butt2_imag0(out_0_imag4),
  .butt2_real1(out_0_real6),
  .butt2_imag1(out_0_imag6),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_1_real4),
  .y0_imag    (out_1_imag4),
  .y1_real    (out_1_real6),
  .y1_imag    (out_1_imag6)
);
butter_2 u_1_3(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_0_real5),
  .butt2_imag0(out_0_imag5),
  .butt2_real1(out_0_real7),
  .butt2_imag1(out_0_imag7),
  .factor_real(factor_real4),
  .factor_imag(factor_imag4),
  .y0_real    (out_1_real5),
  .y0_imag    (out_1_imag5),
  .y1_real    (out_1_real7),
  .y1_imag    (out_1_imag7)
);

butter_2 u_1_4(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_0_real8),
  .butt2_imag0(out_0_imag8),
  .butt2_real1(out_0_real10),
  .butt2_imag1(out_0_imag10),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_1_real8),
  .y0_imag    (out_1_imag8),
  .y1_real    (out_1_real10),
  .y1_imag    (out_1_imag10)
);
butter_2 u_1_5(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_0_real9),
  .butt2_imag0(out_0_imag9),
  .butt2_real1(out_0_real11),
  .butt2_imag1(out_0_imag11),
  .factor_real(factor_real4),
  .factor_imag(factor_imag4),
  .y0_real    (out_1_real9),
  .y0_imag    (out_1_imag9),
  .y1_real    (out_1_real11),
  .y1_imag    (out_1_imag11)
);

butter_2 u_1_6(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_0_real12),
  .butt2_imag0(out_0_imag12),
  .butt2_real1(out_0_real14),
  .butt2_imag1(out_0_imag14),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_1_real12),
  .y0_imag    (out_1_imag12),
  .y1_real    (out_1_real14),
  .y1_imag    (out_1_imag14)
);
butter_2 u_1_7(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_0_real13),
  .butt2_imag0(out_0_imag13),
  .butt2_real1(out_0_real15),
  .butt2_imag1(out_0_imag15),
  .factor_real(factor_real4),
  .factor_imag(factor_imag4),
  .y0_real    (out_1_real13),
  .y0_imag    (out_1_imag13),
  .y1_real    (out_1_real15),
  .y1_imag    (out_1_imag15)
);

















//第3级
wire [23:0] out_2_real0;
wire [23:0] out_2_imag0;
wire [23:0] out_2_real1;
wire [23:0] out_2_imag1;
wire [23:0] out_2_real2;
wire [23:0] out_2_imag2;
wire [23:0] out_2_real3;
wire [23:0] out_2_imag3;
wire [23:0] out_2_real4;
wire [23:0] out_2_imag4;
wire [23:0] out_2_real5;
wire [23:0] out_2_imag5;
wire [23:0] out_2_real6;
wire [23:0] out_2_imag6;
wire [23:0] out_2_real7;
wire [23:0] out_2_imag7;
wire [23:0] out_2_real8;
wire [23:0] out_2_imag8;
wire [23:0] out_2_real9;
wire [23:0] out_2_imag9;
wire [23:0] out_2_real10;
wire [23:0] out_2_imag10;
wire [23:0] out_2_real11;
wire [23:0] out_2_imag11;
wire [23:0] out_2_real12;
wire [23:0] out_2_imag12;
wire [23:0] out_2_real13;
wire [23:0] out_2_imag13;
wire [23:0] out_2_real14;
wire [23:0] out_2_imag14;
wire [23:0] out_2_real15;
wire [23:0] out_2_imag15;

butter_2 u_2_0(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_1_real0),
  .butt2_imag0(out_1_imag0),
  .butt2_real1(out_1_real4),
  .butt2_imag1(out_1_imag4),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_2_real0),
  .y0_imag    (out_2_imag0),
  .y1_real    (out_2_real4),
  .y1_imag    (out_2_imag4)
);
butter_2 u_2_1(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_1_real1),
  .butt2_imag0(out_1_imag1),
  .butt2_real1(out_1_real5),
  .butt2_imag1(out_1_imag5),
  .factor_real(factor_real2),
  .factor_imag(factor_imag2),
  .y0_real    (out_2_real1),
  .y0_imag    (out_2_imag1),
  .y1_real    (out_2_real5),
  .y1_imag    (out_2_imag5)
);
butter_2 u_2_2(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_1_real2),
  .butt2_imag0(out_1_imag2),
  .butt2_real1(out_1_real6),
  .butt2_imag1(out_1_imag6),
  .factor_real(factor_real4),
  .factor_imag(factor_imag4),
  .y0_real    (out_2_real2),
  .y0_imag    (out_2_imag2),
  .y1_real    (out_2_real6),
  .y1_imag    (out_2_imag6)
);
butter_2 u_2_3(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_1_real3),
  .butt2_imag0(out_1_imag3),
  .butt2_real1(out_1_real7),
  .butt2_imag1(out_1_imag7),
  .factor_real(factor_real6),
  .factor_imag(factor_imag6),
  .y0_real    (out_2_real3),
  .y0_imag    (out_2_imag3),
  .y1_real    (out_2_real7),
  .y1_imag    (out_2_imag7)
);


butter_2 u_2_4(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_1_real8),
  .butt2_imag0(out_1_imag8),
  .butt2_real1(out_1_real12),
  .butt2_imag1(out_1_imag12),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_2_real8),
  .y0_imag    (out_2_imag8),
  .y1_real    (out_2_real12),
  .y1_imag    (out_2_imag12)
);
butter_2 u_2_5(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_1_real9),
  .butt2_imag0(out_1_imag9),
  .butt2_real1(out_1_real13),
  .butt2_imag1(out_1_imag13),
  .factor_real(factor_real2),
  .factor_imag(factor_imag2),
  .y0_real    (out_2_real9),
  .y0_imag    (out_2_imag9),
  .y1_real    (out_2_real13),
  .y1_imag    (out_2_imag13)
);
butter_2 u_2_6(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_1_real10),
  .butt2_imag0(out_1_imag10),
  .butt2_real1(out_1_real14),
  .butt2_imag1(out_1_imag14),
  .factor_real(factor_real4),
  .factor_imag(factor_imag4),
  .y0_real    (out_2_real10),
  .y0_imag    (out_2_imag10),
  .y1_real    (out_2_real14),
  .y1_imag    (out_2_imag14)
);
butter_2 u_2_7(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_1_real11),
  .butt2_imag0(out_1_imag11),
  .butt2_real1(out_1_real15),
  .butt2_imag1(out_1_imag15),
  .factor_real(factor_real6),
  .factor_imag(factor_imag6),
  .y0_real    (out_2_real11),
  .y0_imag    (out_2_imag11),
  .y1_real    (out_2_real15),
  .y1_imag    (out_2_imag15)
);












//第4级
wire [23:0] out_3_real0;
wire [23:0] out_3_imag0;
wire [23:0] out_3_real1;
wire [23:0] out_3_imag1;
wire [23:0] out_3_real2;
wire [23:0] out_3_imag2;
wire [23:0] out_3_real3;
wire [23:0] out_3_imag3;
wire [23:0] out_3_real4;
wire [23:0] out_3_imag4;
wire [23:0] out_3_real5;
wire [23:0] out_3_imag5;
wire [23:0] out_3_real6;
wire [23:0] out_3_imag6;
wire [23:0] out_3_real7;
wire [23:0] out_3_imag7;
wire [23:0] out_3_real8;
wire [23:0] out_3_imag8;
wire [23:0] out_3_real9;
wire [23:0] out_3_imag9;
wire [23:0] out_3_real10;
wire [23:0] out_3_imag10;
wire [23:0] out_3_real11;
wire [23:0] out_3_imag11;
wire [23:0] out_3_real12;
wire [23:0] out_3_imag12;
wire [23:0] out_3_real13;
wire [23:0] out_3_imag13;
wire [23:0] out_3_real14;
wire [23:0] out_3_imag14;
wire [23:0] out_3_real15;
wire [23:0] out_3_imag15;

butter_2 u_3_0(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_2_real0),
  .butt2_imag0(out_2_imag0),
  .butt2_real1(out_2_real8),
  .butt2_imag1(out_2_imag8),
  .factor_real(factor_real0),
  .factor_imag(factor_imag0),
  .y0_real    (out_3_real0),
  .y0_imag    (out_3_imag0),
  .y1_real    (out_3_real8),
  .y1_imag    (out_3_imag8)
);
butter_2 u_3_1(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_2_real1),
  .butt2_imag0(out_2_imag1),
  .butt2_real1(out_2_real9),
  .butt2_imag1(out_2_imag9),
  .factor_real(factor_real1),
  .factor_imag(factor_imag1),
  .y0_real    (out_3_real1),
  .y0_imag    (out_3_imag1),
  .y1_real    (out_3_real9),
  .y1_imag    (out_3_imag9)
);
butter_2 u_3_2(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_2_real2),
  .butt2_imag0(out_2_imag2),
  .butt2_real1(out_2_real10),
  .butt2_imag1(out_2_imag10),
  .factor_real(factor_real2),
  .factor_imag(factor_imag2),
  .y0_real    (out_3_real2),
  .y0_imag    (out_3_imag2),
  .y1_real    (out_3_real10),
  .y1_imag    (out_3_imag10)
);
butter_2 u_3_3(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_2_real3),
  .butt2_imag0(out_2_imag3),
  .butt2_real1(out_2_real11),
  .butt2_imag1(out_2_imag11),
  .factor_real(factor_real3),
  .factor_imag(factor_imag3),
  .y0_real    (out_3_real3),
  .y0_imag    (out_3_imag3),
  .y1_real    (out_3_real11),
  .y1_imag    (out_3_imag11)
);
butter_2 u_3_4(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_2_real4),
  .butt2_imag0(out_2_imag4),
  .butt2_real1(out_2_real12),
  .butt2_imag1(out_2_imag12),
  .factor_real(factor_real4),
  .factor_imag(factor_imag4),
  .y0_real    (out_3_real4),
  .y0_imag    (out_3_imag4),
  .y1_real    (out_3_real12),
  .y1_imag    (out_3_imag12)
);
butter_2 u_3_5(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_2_real5),
  .butt2_imag0(out_2_imag5),
  .butt2_real1(out_2_real13),
  .butt2_imag1(out_2_imag13),
  .factor_real(factor_real5),
  .factor_imag(factor_imag5),
  .y0_real    (out_3_real5),
  .y0_imag    (out_3_imag5),
  .y1_real    (out_3_real13),
  .y1_imag    (out_3_imag13)
);
butter_2 u_3_6(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_2_real6),
  .butt2_imag0(out_2_imag6),
  .butt2_real1(out_2_real14),
  .butt2_imag1(out_2_imag14),
  .factor_real(factor_real6),
  .factor_imag(factor_imag6),
  .y0_real    (out_3_real6),
  .y0_imag    (out_3_imag6),
  .y1_real    (out_3_real14),
  .y1_imag    (out_3_imag14)
);
butter_2 u_3_7(
  .clk(clk),
  .rst(rst),
  .butt2_real0(out_2_real7),
  .butt2_imag0(out_2_imag7),
  .butt2_real1(out_2_real15),
  .butt2_imag1(out_2_imag15),
  .factor_real(factor_real7),
  .factor_imag(factor_imag7),
  .y0_real    (out_3_real7),
  .y0_imag    (out_3_imag7),
  .y1_real    (out_3_real15),
  .y1_imag    (out_3_imag15)
);


assign y0_real_fin =out_3_real0;
assign y0_imag_fin =out_3_imag0;
assign y1_real_fin =out_3_real1;
assign y1_imag_fin =out_3_imag1;
assign y2_real_fin =out_3_real2;
assign y2_imag_fin =out_3_imag2;
assign y3_real_fin =out_3_real3;
assign y3_imag_fin =out_3_imag3;
assign y4_real_fin =out_3_real4;
assign y4_imag_fin =out_3_imag4;
assign y5_real_fin =out_3_real5;
assign y5_imag_fin =out_3_imag5;
assign y6_real_fin =out_3_real6;
assign y6_imag_fin =out_3_imag6;
assign y7_real_fin =out_3_real7;
assign y7_imag_fin =out_3_imag7;
assign y8_real_fin =out_3_real8;
assign y8_imag_fin =out_3_imag8;
assign y9_real_fin =out_3_real9;
assign y9_imag_fin =out_3_imag9;
assign y10_real_fin=out_3_real10;
assign y10_imag_fin=out_3_imag10;
assign y11_real_fin=out_3_real11;
assign y11_imag_fin=out_3_imag11;
assign y12_real_fin=out_3_real12;
assign y12_imag_fin=out_3_imag12;
assign y13_real_fin=out_3_real13;
assign y13_imag_fin=out_3_imag13;
assign y14_real_fin=out_3_real14;
assign y14_imag_fin=out_3_imag14;
assign y15_real_fin=out_3_real15;
assign y15_imag_fin=out_3_imag15;

endmodule