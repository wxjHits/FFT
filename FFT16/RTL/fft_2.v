/****************************/
//作者:Wei Xuejing
//邮箱:2682152871@qq.com
//描述:16点并行迭代fft-级内并行,级间串行迭代
//时间:2023.05.13
/****************************/
module fft_2 #(
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


//蝶形计算单元
//第1级的例化
reg     [23:0] butt2_real0_num0;
reg     [23:0] butt2_imag0_num0;
reg     [23:0] butt2_real1_num0;
reg     [23:0] butt2_imag1_num0;
reg     [31:0] factor_real_num0;
reg     [31:0] factor_imag_num0;
wire    [23:0] y0_real_num0;
wire    [23:0] y0_imag_num0;
wire    [23:0] y1_real_num0;
wire    [23:0] y1_imag_num0;
//第2级的例化
reg     [23:0] butt2_real0_num1;
reg     [23:0] butt2_imag0_num1;
reg     [23:0] butt2_real1_num1;
reg     [23:0] butt2_imag1_num1;
reg     [31:0] factor_real_num1;
reg     [31:0] factor_imag_num1;
wire    [23:0]     y0_real_num1;
wire    [23:0]     y0_imag_num1;
wire    [23:0]     y1_real_num1;
wire    [23:0]     y1_imag_num1;
//第3级的例化
reg     [23:0] butt2_real0_num2;
reg     [23:0] butt2_imag0_num2;
reg     [23:0] butt2_real1_num2;
reg     [23:0] butt2_imag1_num2;
reg     [31:0] factor_real_num2;
reg     [31:0] factor_imag_num2;
wire    [23:0]     y0_real_num2;
wire    [23:0]     y0_imag_num2;
wire    [23:0]     y1_real_num2;
wire    [23:0]     y1_imag_num2;
//第4级的例化
reg     [23:0] butt2_real0_num3;
reg     [23:0] butt2_imag0_num3;
reg     [23:0] butt2_real1_num3;
reg     [23:0] butt2_imag1_num3;
reg     [31:0] factor_real_num3;
reg     [31:0] factor_imag_num3;
wire    [23:0]     y0_real_num3;
wire    [23:0]     y0_imag_num3;
wire    [23:0]     y1_real_num3;
wire    [23:0]     y1_imag_num3;

reg     [23:0] butt2_real0_num4;
reg     [23:0] butt2_imag0_num4;
reg     [23:0] butt2_real1_num4;
reg     [23:0] butt2_imag1_num4;
reg     [31:0] factor_real_num4;
reg     [31:0] factor_imag_num4;
wire    [23:0]     y0_real_num4;
wire    [23:0]     y0_imag_num4;
wire    [23:0]     y1_real_num4;
wire    [23:0]     y1_imag_num4;

reg     [23:0] butt2_real0_num5;
reg     [23:0] butt2_imag0_num5;
reg     [23:0] butt2_real1_num5;
reg     [23:0] butt2_imag1_num5;
reg     [31:0] factor_real_num5;
reg     [31:0] factor_imag_num5;
wire    [23:0]     y0_real_num5;
wire    [23:0]     y0_imag_num5;
wire    [23:0]     y1_real_num5;
wire    [23:0]     y1_imag_num5;

reg     [23:0] butt2_real0_num6;
reg     [23:0] butt2_imag0_num6;
reg     [23:0] butt2_real1_num6;
reg     [23:0] butt2_imag1_num6;
reg     [31:0] factor_real_num6;
reg     [31:0] factor_imag_num6;
wire    [23:0]     y0_real_num6;
wire    [23:0]     y0_imag_num6;
wire    [23:0]     y1_real_num6;
wire    [23:0]     y1_imag_num6;

reg     [23:0] butt2_real0_num7;
reg     [23:0] butt2_imag0_num7;
reg     [23:0] butt2_real1_num7;
reg     [23:0] butt2_imag1_num7;
reg     [31:0] factor_real_num7;
reg     [31:0] factor_imag_num7;
wire    [23:0]     y0_real_num7;
wire    [23:0]     y0_imag_num7;
wire    [23:0]     y1_real_num7;
wire    [23:0]     y1_imag_num7;

butter_2 u0(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_num0),
                 .butt2_imag0(butt2_imag0_num0),
                 .butt2_real1(butt2_real1_num0),
                 .butt2_imag1(butt2_imag1_num0),
                 .factor_real(factor_real_num0),
                 .factor_imag(factor_imag_num0),
                 .y0_real    (    y0_real_num0),
                 .y0_imag    (    y0_imag_num0),
                 .y1_real    (    y1_real_num0),
                 .y1_imag    (    y1_imag_num0)
           );
butter_2 u1(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_num1),
                 .butt2_imag0(butt2_imag0_num1),
                 .butt2_real1(butt2_real1_num1),
                 .butt2_imag1(butt2_imag1_num1),
                 .factor_real(factor_real_num1),
                 .factor_imag(factor_imag_num1),
                 .y0_real    (y0_real_num1),
                 .y0_imag    (y0_imag_num1),
                 .y1_real    (y1_real_num1),
                 .y1_imag    (y1_imag_num1)
           );
butter_2 u2(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_num2),
                 .butt2_imag0(butt2_imag0_num2),
                 .butt2_real1(butt2_real1_num2),
                 .butt2_imag1(butt2_imag1_num2),
                 .factor_real(factor_real_num2),
                 .factor_imag(factor_imag_num2),
                 .y0_real(y0_real_num2),
                 .y0_imag(y0_imag_num2),
                 .y1_real(y1_real_num2),
                 .y1_imag(y1_imag_num2)
           );
butter_2 u3(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_num3),
                 .butt2_imag0(butt2_imag0_num3),
                 .butt2_real1(butt2_real1_num3),
                 .butt2_imag1(butt2_imag1_num3),
                 .factor_real(factor_real_num3),
                 .factor_imag(factor_imag_num3),
                 .y0_real(y0_real_num3),
                 .y0_imag(y0_imag_num3),
                 .y1_real(y1_real_num3),
                 .y1_imag(y1_imag_num3)
           );
butter_2 u4(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_num4),
                 .butt2_imag0(butt2_imag0_num4),
                 .butt2_real1(butt2_real1_num4),
                 .butt2_imag1(butt2_imag1_num4),
                 .factor_real(factor_real_num4),
                 .factor_imag(factor_imag_num4),
                 .y0_real    (    y0_real_num4),
                 .y0_imag    (    y0_imag_num4),
                 .y1_real    (    y1_real_num4),
                 .y1_imag    (    y1_imag_num4)
           );
butter_2 u5(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_num5),
                 .butt2_imag0(butt2_imag0_num5),
                 .butt2_real1(butt2_real1_num5),
                 .butt2_imag1(butt2_imag1_num5),
                 .factor_real(factor_real_num5),
                 .factor_imag(factor_imag_num5),
                 .y0_real    (    y0_real_num5),
                 .y0_imag    (    y0_imag_num5),
                 .y1_real    (    y1_real_num5),
                 .y1_imag    (    y1_imag_num5)
           );
butter_2 u6(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_num6),
                 .butt2_imag0(butt2_imag0_num6),
                 .butt2_real1(butt2_real1_num6),
                 .butt2_imag1(butt2_imag1_num6),
                 .factor_real(factor_real_num6),
                 .factor_imag(factor_imag_num6),
                 .y0_real    (    y0_real_num6),
                 .y0_imag    (    y0_imag_num6),
                 .y1_real    (    y1_real_num6),
                 .y1_imag    (    y1_imag_num6)
           );
butter_2 u7(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_num7),
                 .butt2_imag0(butt2_imag0_num7),
                 .butt2_real1(butt2_real1_num7),
                 .butt2_imag1(butt2_imag1_num7),
                 .factor_real(factor_real_num7),
                 .factor_imag(factor_imag_num7),
                 .y0_real    (    y0_real_num7),
                 .y0_imag    (    y0_imag_num7),
                 .y1_real    (    y1_real_num7),
                 .y1_imag    (    y1_imag_num7)
           );








//中间寄存器
reg [23:0] register_real0;
reg [23:0] register_imag0;
reg [23:0] register_real1;
reg [23:0] register_imag1;
reg [23:0] register_real2;
reg [23:0] register_imag2;
reg [23:0] register_real3;
reg [23:0] register_imag3;
reg [23:0] register_real4;
reg [23:0] register_imag4;
reg [23:0] register_real5;
reg [23:0] register_imag5;
reg [23:0] register_real6;
reg [23:0] register_imag6;
reg [23:0] register_real7;
reg [23:0] register_imag7;
reg [23:0] register_real8;
reg [23:0] register_imag8;
reg [23:0] register_real9;
reg [23:0] register_imag9;
reg [23:0] register_real10;
reg [23:0] register_imag10;
reg [23:0] register_real11;
reg [23:0] register_imag11;
reg [23:0] register_real12;
reg [23:0] register_imag12;
reg [23:0] register_real13;
reg [23:0] register_imag13;
reg [23:0] register_real14;
reg [23:0] register_imag14;
reg [23:0] register_real15;
reg [23:0] register_imag15;
//输出寄存
reg [23:0] register_roundend_real0=0;
reg [23:0] register_roundend_imag0=0;
reg [23:0] register_roundend_real1=0;
reg [23:0] register_roundend_imag1=0;
reg [23:0] register_roundend_real2=0;
reg [23:0] register_roundend_imag2=0;
reg [23:0] register_roundend_real3=0;
reg [23:0] register_roundend_imag3=0;
reg [23:0] register_roundend_real4=0;
reg [23:0] register_roundend_imag4=0;
reg [23:0] register_roundend_real5=0;
reg [23:0] register_roundend_imag5=0;
reg [23:0] register_roundend_real6=0;
reg [23:0] register_roundend_imag6=0;
reg [23:0] register_roundend_real7=0;
reg [23:0] register_roundend_imag7=0;
reg [23:0] register_roundend_real8=0;
reg [23:0] register_roundend_imag8=0;
reg [23:0] register_roundend_real9=0;
reg [23:0] register_roundend_imag9=0;
reg [23:0] register_roundend_real10=0;
reg [23:0] register_roundend_imag10=0;
reg [23:0] register_roundend_real11=0;
reg [23:0] register_roundend_imag11=0;
reg [23:0] register_roundend_real12=0;
reg [23:0] register_roundend_imag12=0;
reg [23:0] register_roundend_real13=0;
reg [23:0] register_roundend_imag13=0;
reg [23:0] register_roundend_real14=0;
reg [23:0] register_roundend_imag14=0;
reg [23:0] register_roundend_real15=0;
reg [23:0] register_roundend_imag15=0;












reg [19:0] i;
always @(posedge clk or negedge rst) begin
    if (rst == RST_LVL)
        i<=20'd0;
     else begin
          case(i)
            20'd0: begin
                register_real0  <=butt16_real0  ;   register_imag0<=butt16_imag0    ; 
                register_real1  <=butt16_real8  ;   register_imag1<=butt16_imag8    ; 
                register_real2  <=butt16_real4  ;   register_imag2<=butt16_imag4    ; 
                register_real3  <=butt16_real12 ;   register_imag3<=butt16_imag12   ;
                register_real4  <=butt16_real2  ;   register_imag4<=butt16_imag2    ; 
                register_real5  <=butt16_real10 ;   register_imag5<=butt16_imag10   ;
                register_real6  <=butt16_real6  ;   register_imag6<=butt16_imag6    ; 
                register_real7  <=butt16_real14 ;   register_imag7<=butt16_imag14   ;
			          register_real8  <=butt16_real1  ;   register_imag8<=butt16_imag1    ; 
                register_real9  <=butt16_real9  ;   register_imag9<=butt16_imag9    ;
                register_real10 <=butt16_real5  ;   register_imag10<=butt16_imag5   ;
                register_real11 <=butt16_real13 ;   register_imag11<=butt16_imag13  ;
                register_real12 <=butt16_real3  ;   register_imag12<=butt16_imag3   ;
                register_real13 <=butt16_real11 ;   register_imag13<=butt16_imag11  ;
                register_real14 <=butt16_real7  ;   register_imag14<=butt16_imag7   ;
                register_real15 <=butt16_real15 ;   register_imag15<=butt16_imag15  ;
                i<=i+1;
            end









/*第1级fft*/
    20'd1: begin
            butt2_real0_num0<=register_real0;butt2_imag0_num0<=register_imag0;
            butt2_real1_num0<=register_real1;butt2_imag1_num0<=register_imag1;
            factor_real_num0<=factor_real0  ;factor_imag_num0<=factor_imag0;

            butt2_real0_num1<=register_real2;butt2_imag0_num1<=register_imag2;
            butt2_real1_num1<=register_real3;butt2_imag1_num1<=register_imag3;
            factor_real_num1<=factor_real0  ;factor_imag_num1<=factor_imag0;

            butt2_real0_num2<=register_real4;butt2_imag0_num2<=register_imag4;
            butt2_real1_num2<=register_real5;butt2_imag1_num2<=register_imag5;
            factor_real_num2<=factor_real0  ;factor_imag_num2<=factor_imag0;

            butt2_real0_num3<=register_real6;butt2_imag0_num3<=register_imag6;
            butt2_real1_num3<=register_real7;butt2_imag1_num3<=register_imag7;
            factor_real_num3<=factor_real0  ;factor_imag_num3<=factor_imag0;

            butt2_real0_num4<=register_real8;butt2_imag0_num4<=register_imag8;
            butt2_real1_num4<=register_real9;butt2_imag1_num4<=register_imag9;
            factor_real_num4<=factor_real0  ;factor_imag_num4<=factor_imag0;

            butt2_real0_num5<=register_real10;butt2_imag0_num5<=register_imag10;
            butt2_real1_num5<=register_real11;butt2_imag1_num5<=register_imag11;
            factor_real_num5<=factor_real0  ;factor_imag_num5<=factor_imag0;

            butt2_real0_num6<=register_real12;butt2_imag0_num6<=register_imag12;
            butt2_real1_num6<=register_real13;butt2_imag1_num6<=register_imag13;
            factor_real_num6<=factor_real0   ;factor_imag_num6<=factor_imag0;

            butt2_real0_num7<=register_real14;butt2_imag0_num7<=register_imag14;
            butt2_real1_num7<=register_real15;butt2_imag1_num7<=register_imag15;
            factor_real_num7<=factor_real0   ;factor_imag_num7<=factor_imag0   ;

            i<=i+1;
          end
    20'd2:#26 begin i<=i+1; end
    20'd3:begin
            register_real0 <=y0_real_num0;register_imag0 <=y0_imag_num0;
            register_real1 <=y1_real_num0;register_imag1 <=y1_imag_num0;
            register_real2 <=y0_real_num1;register_imag2 <=y0_imag_num1;
            register_real3 <=y1_real_num1;register_imag3 <=y1_imag_num1;
            register_real4 <=y0_real_num2;register_imag4 <=y0_imag_num2;
            register_real5 <=y1_real_num2;register_imag5 <=y1_imag_num2;
            register_real6 <=y0_real_num3;register_imag6 <=y0_imag_num3;
            register_real7 <=y1_real_num3;register_imag7 <=y1_imag_num3;
            register_real8 <=y0_real_num4;register_imag8 <=y0_imag_num4;
            register_real9 <=y1_real_num4;register_imag9 <=y1_imag_num4;
            register_real10<=y0_real_num5;register_imag10<=y0_imag_num5;
            register_real11<=y1_real_num5;register_imag11<=y1_imag_num5;
            register_real12<=y0_real_num6;register_imag12<=y0_imag_num6;
            register_real13<=y1_real_num6;register_imag13<=y1_imag_num6;
            register_real14<=y0_real_num7;register_imag14<=y0_imag_num7;
            register_real15<=y1_real_num7;register_imag15<=y1_imag_num7;
            i<=i+1;
          end
    20'd4:#3 begin i<=i+1; end









/*第2级fft*/
    20'd5: begin
            butt2_real0_num0<=register_real0;butt2_imag0_num0<=register_imag0;
            butt2_real1_num0<=register_real2;butt2_imag1_num0<=register_imag2;
            factor_real_num0<=factor_real0  ;factor_imag_num0<=factor_imag0;
            butt2_real0_num1<=register_real1;butt2_imag0_num1<=register_imag1;
            butt2_real1_num1<=register_real3;butt2_imag1_num1<=register_imag3;
            factor_real_num1<=factor_real4  ;factor_imag_num1<=factor_imag4;

            butt2_real0_num2<=register_real4;butt2_imag0_num2<=register_imag4;
            butt2_real1_num2<=register_real6;butt2_imag1_num2<=register_imag6;
            factor_real_num2<=factor_real0  ;factor_imag_num2<=factor_imag0;
            butt2_real0_num3<=register_real5;butt2_imag0_num3<=register_imag5;
            butt2_real1_num3<=register_real7;butt2_imag1_num3<=register_imag7;
            factor_real_num3<=factor_real4  ;factor_imag_num3<=factor_imag4;

            butt2_real0_num4<=register_real8;butt2_imag0_num4<=register_imag8;
            butt2_real1_num4<=register_real10;butt2_imag1_num4<=register_imag10;
            factor_real_num4<=factor_real0  ;factor_imag_num4<=factor_imag0;
            butt2_real0_num5<=register_real9;butt2_imag0_num5<=register_imag9;
            butt2_real1_num5<=register_real11;butt2_imag1_num5<=register_imag11;
            factor_real_num5<=factor_real4  ;factor_imag_num5<=factor_imag4;

            butt2_real0_num6<=register_real12;butt2_imag0_num6<=register_imag12;
            butt2_real1_num6<=register_real14;butt2_imag1_num6<=register_imag14;
            factor_real_num6<=factor_real0   ;factor_imag_num6<=factor_imag0;
            butt2_real0_num7<=register_real13;butt2_imag0_num7<=register_imag13;
            butt2_real1_num7<=register_real15;butt2_imag1_num7<=register_imag15;
            factor_real_num7<=factor_real4   ;factor_imag_num7<=factor_imag4   ;

            i<=i+1;
          end
    20'd6:#26 begin i<=i+1; end
    20'd7:begin
            register_real0 <=y0_real_num0;register_imag0 <=y0_imag_num0;
            register_real2 <=y1_real_num0;register_imag2 <=y1_imag_num0;
            register_real1 <=y0_real_num1;register_imag1 <=y0_imag_num1;
            register_real3 <=y1_real_num1;register_imag3 <=y1_imag_num1;

            register_real4 <=y0_real_num2;register_imag4 <=y0_imag_num2;
            register_real6 <=y1_real_num2;register_imag6 <=y1_imag_num2;
            register_real5 <=y0_real_num3;register_imag5 <=y0_imag_num3;
            register_real7 <=y1_real_num3;register_imag7 <=y1_imag_num3;

            register_real8 <=y0_real_num4;register_imag8 <=y0_imag_num4;
            register_real10<=y1_real_num4;register_imag10<=y1_imag_num4;
            register_real9 <=y0_real_num5;register_imag9 <=y0_imag_num5;
            register_real11<=y1_real_num5;register_imag11<=y1_imag_num5;

            register_real12<=y0_real_num6;register_imag12<=y0_imag_num6;
            register_real14<=y1_real_num6;register_imag14<=y1_imag_num6;
            register_real13<=y0_real_num7;register_imag13<=y0_imag_num7;
            register_real15<=y1_real_num7;register_imag15<=y1_imag_num7;
            i<=i+1;
          end
    20'd8:#3 begin i<=i+1; end












/***第3级fft运算***/
    20'd9: begin
            butt2_real0_num0<=register_real0;butt2_imag0_num0<=register_imag0;
            butt2_real1_num0<=register_real4;butt2_imag1_num0<=register_imag4;
            butt2_real0_num1<=register_real1;butt2_imag0_num1<=register_imag1;
            butt2_real1_num1<=register_real5;butt2_imag1_num1<=register_imag5;
            butt2_real0_num2<=register_real2;butt2_imag0_num2<=register_imag2;
            butt2_real1_num2<=register_real6;butt2_imag1_num2<=register_imag6;
            butt2_real0_num3<=register_real3;butt2_imag0_num3<=register_imag3;
            butt2_real1_num3<=register_real7;butt2_imag1_num3<=register_imag7;
            factor_real_num0<=factor_real0;factor_imag_num0<=factor_imag0;
            factor_real_num1<=factor_real2;factor_imag_num1<=factor_imag2;
            factor_real_num2<=factor_real4;factor_imag_num2<=factor_imag4;
            factor_real_num3<=factor_real6;factor_imag_num3<=factor_imag6;

            butt2_real0_num4<=register_real8 ;butt2_imag0_num4<=register_imag8 ;
            butt2_real1_num4<=register_real12;butt2_imag1_num4<=register_imag12;
            butt2_real0_num5<=register_real9 ;butt2_imag0_num5<=register_imag9 ;
            butt2_real1_num5<=register_real13;butt2_imag1_num5<=register_imag13;
            butt2_real0_num6<=register_real10;butt2_imag0_num6<=register_imag10;
            butt2_real1_num6<=register_real14;butt2_imag1_num6<=register_imag14;
            butt2_real0_num7<=register_real11;butt2_imag0_num7<=register_imag11;
            butt2_real1_num7<=register_real15;butt2_imag1_num7<=register_imag15;
            factor_real_num4<=factor_real0;factor_imag_num4<=factor_imag0;
            factor_real_num5<=factor_real2;factor_imag_num5<=factor_imag2;
            factor_real_num6<=factor_real4;factor_imag_num6<=factor_imag4;
            factor_real_num7<=factor_real6;factor_imag_num7<=factor_imag6;

            i<=i+1;
          end
    20'd10:#26 begin i<=i+1; end
    20'd11:begin
            register_real0 <=y0_real_num0;register_imag0 <=y0_imag_num0;
            register_real4 <=y1_real_num0;register_imag4 <=y1_imag_num0;
            register_real1 <=y0_real_num1;register_imag1 <=y0_imag_num1;
            register_real5 <=y1_real_num1;register_imag5 <=y1_imag_num1;
            register_real2 <=y0_real_num2;register_imag2 <=y0_imag_num2;
            register_real6 <=y1_real_num2;register_imag6 <=y1_imag_num2;
            register_real3 <=y0_real_num3;register_imag3 <=y0_imag_num3;
            register_real7 <=y1_real_num3;register_imag7 <=y1_imag_num3;

            register_real8 <=y0_real_num4;register_imag8 <=y0_imag_num4;
            register_real12<=y1_real_num4;register_imag12<=y1_imag_num4;
            register_real9 <=y0_real_num5;register_imag9 <=y0_imag_num5;
            register_real13<=y1_real_num5;register_imag13<=y1_imag_num5;
            register_real10<=y0_real_num6;register_imag10<=y0_imag_num6;
            register_real14<=y1_real_num6;register_imag14<=y1_imag_num6;
            register_real11<=y0_real_num7;register_imag11<=y0_imag_num7;
            register_real15<=y1_real_num7;register_imag15<=y1_imag_num7;
            i<=i+1;
          end
    20'd12:#3 begin i<=i+1; end














/***第4级fft***/
    20'd13: begin
            butt2_real0_num0<=register_real0 ;butt2_imag0_num0<=register_imag0 ;
            butt2_real1_num0<=register_real8 ;butt2_imag1_num0<=register_imag8 ;
            butt2_real0_num1<=register_real1 ;butt2_imag0_num1<=register_imag1 ;
            butt2_real1_num1<=register_real9 ;butt2_imag1_num1<=register_imag9 ;
            butt2_real0_num2<=register_real2 ;butt2_imag0_num2<=register_imag2 ;
            butt2_real1_num2<=register_real10;butt2_imag1_num2<=register_imag10;
            butt2_real0_num3<=register_real3 ;butt2_imag0_num3<=register_imag3 ;
            butt2_real1_num3<=register_real11;butt2_imag1_num3<=register_imag11;
            butt2_real0_num4<=register_real4 ;butt2_imag0_num4<=register_imag4 ;
            butt2_real1_num4<=register_real12;butt2_imag1_num4<=register_imag12;
            butt2_real0_num5<=register_real5 ;butt2_imag0_num5<=register_imag5 ;
            butt2_real1_num5<=register_real13;butt2_imag1_num5<=register_imag13;
            butt2_real0_num6<=register_real6 ;butt2_imag0_num6<=register_imag6 ;
            butt2_real1_num6<=register_real14;butt2_imag1_num6<=register_imag14;
            butt2_real0_num7<=register_real7 ;butt2_imag0_num7<=register_imag7 ;
            butt2_real1_num7<=register_real15;butt2_imag1_num7<=register_imag15;

            factor_real_num0<=factor_real0;factor_imag_num0<=factor_imag0;
            factor_real_num1<=factor_real1;factor_imag_num1<=factor_imag1;
            factor_real_num2<=factor_real2;factor_imag_num2<=factor_imag2;
            factor_real_num3<=factor_real3;factor_imag_num3<=factor_imag3;
            factor_real_num4<=factor_real4;factor_imag_num4<=factor_imag4;
            factor_real_num5<=factor_real5;factor_imag_num5<=factor_imag5;
            factor_real_num6<=factor_real6;factor_imag_num6<=factor_imag6;
            factor_real_num7<=factor_real7;factor_imag_num7<=factor_imag7;

            i<=i+1;
          end
    20'd14:#26 begin i<=i+1; end
    20'd15:begin
            register_real0 <=y0_real_num0;register_imag0 <=y0_imag_num0;
            register_real8 <=y1_real_num0;register_imag8 <=y1_imag_num0;
            register_real1 <=y0_real_num1;register_imag1 <=y0_imag_num1;
            register_real9 <=y1_real_num1;register_imag9 <=y1_imag_num1;
            register_real2 <=y0_real_num2;register_imag2 <=y0_imag_num2;
            register_real10<=y1_real_num2;register_imag10<=y1_imag_num2;
            register_real3 <=y0_real_num3;register_imag3 <=y0_imag_num3;
            register_real11<=y1_real_num3;register_imag11<=y1_imag_num3;
            register_real4 <=y0_real_num4;register_imag4 <=y0_imag_num4;
            register_real12<=y1_real_num4;register_imag12<=y1_imag_num4;
            register_real5 <=y0_real_num5;register_imag5 <=y0_imag_num5;
            register_real13<=y1_real_num5;register_imag13<=y1_imag_num5;
            register_real6 <=y0_real_num6;register_imag6 <=y0_imag_num6;
            register_real14<=y1_real_num6;register_imag14<=y1_imag_num6;
            register_real7 <=y0_real_num7;register_imag7 <=y0_imag_num7;
            register_real15<=y1_real_num7;register_imag15<=y1_imag_num7;
            i<=i+1;
          end
    20'd16:#3 begin i<=i+1; end

//
            20'd17:
                begin
                   register_roundend_real0 <=register_real0 ;register_roundend_imag0 <=register_imag0 ;
                   register_roundend_real1 <=register_real1 ;register_roundend_imag1 <=register_imag1 ;
                   register_roundend_real2 <=register_real2 ;register_roundend_imag2 <=register_imag2 ;
                   register_roundend_real3 <=register_real3 ;register_roundend_imag3 <=register_imag3 ;
                   register_roundend_real4 <=register_real4 ;register_roundend_imag4 <=register_imag4 ;
                   register_roundend_real5 <=register_real5 ;register_roundend_imag5 <=register_imag5 ;
                   register_roundend_real6 <=register_real6 ;register_roundend_imag6 <=register_imag6 ;
                   register_roundend_real7 <=register_real7 ;register_roundend_imag7 <=register_imag7 ;  
                   register_roundend_real8 <=register_real8 ;register_roundend_imag8 <=register_imag8 ;
                   register_roundend_real9 <=register_real9 ;register_roundend_imag9 <=register_imag9 ;
                   register_roundend_real10<=register_real10;register_roundend_imag10<=register_imag10;
                   register_roundend_real11<=register_real11;register_roundend_imag11<=register_imag11;
                   register_roundend_real12<=register_real12;register_roundend_imag12<=register_imag12;
                   register_roundend_real13<=register_real13;register_roundend_imag13<=register_imag13;
                   register_roundend_real14<=register_real14;register_roundend_imag14<=register_imag14;
                   register_roundend_real15<=register_real15;register_roundend_imag15<=register_imag15;  
                   i<=i+1;               
                end
           20'd18:
               begin i<=0;end
             default:
                begin i<=0; end
             endcase end end     

assign y0_real_fin=register_roundend_real0;
assign y0_imag_fin=register_roundend_imag0;
assign y1_real_fin=register_roundend_real1;
assign y1_imag_fin=register_roundend_imag1;
assign y2_real_fin=register_roundend_real2;
assign y2_imag_fin=register_roundend_imag2;
assign y3_real_fin=register_roundend_real3;
assign y3_imag_fin=register_roundend_imag3;
assign y4_real_fin=register_roundend_real4;
assign y4_imag_fin=register_roundend_imag4;
assign y5_real_fin=register_roundend_real5;
assign y5_imag_fin=register_roundend_imag5;
assign y6_real_fin=register_roundend_real6;
assign y6_imag_fin=register_roundend_imag6;
assign y7_real_fin=register_roundend_real7;
assign y7_imag_fin=register_roundend_imag7;
assign y8_real_fin=register_roundend_real8;
assign y8_imag_fin=register_roundend_imag8;
assign y9_real_fin=register_roundend_real9;
assign y9_imag_fin=register_roundend_imag9;
assign y10_real_fin=register_roundend_real10;
assign y10_imag_fin=register_roundend_imag10;
assign y11_real_fin=register_roundend_real11;
assign y11_imag_fin=register_roundend_imag11;
assign y12_real_fin=register_roundend_real12;
assign y12_imag_fin=register_roundend_imag12;
assign y13_real_fin=register_roundend_real13;
assign y13_imag_fin=register_roundend_imag13;
assign y14_real_fin=register_roundend_real14;
assign y14_imag_fin=register_roundend_imag14;
assign y15_real_fin=register_roundend_real15;
assign y15_imag_fin=register_roundend_imag15;

endmodule