/****************************/
//作者:Wei Xuejing
//邮箱:2682152871@qq.com
//描述:16点级联流水fft-级内并行,级间串行
//时间:2023.05.13
/****************************/
module fft_1 #(
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
reg     [23:0] butt2_real0_0;
reg     [23:0] butt2_imag0_0;
reg     [23:0] butt2_real1_0;
reg     [23:0] butt2_imag1_0;
reg     [31:0] factor_real_0;
reg     [31:0] factor_imag_0;
wire    [23:0] y0_real_0;
wire    [23:0] y0_imag_0;
wire    [23:0] y1_real_0;
wire    [23:0] y1_imag_0;
//第2级的例化
reg     [23:0] butt2_real0_1;
reg     [23:0] butt2_imag0_1;
reg     [23:0] butt2_real1_1;
reg     [23:0] butt2_imag1_1;
reg     [31:0] factor_real_1;
reg     [31:0] factor_imag_1;
wire    [23:0] y0_real_1;
wire    [23:0] y0_imag_1;
wire    [23:0] y1_real_1;
wire    [23:0] y1_imag_1;
//第3级的例化
reg     [23:0] butt2_real0_2;
reg     [23:0] butt2_imag0_2;
reg     [23:0] butt2_real1_2;
reg     [23:0] butt2_imag1_2;
reg     [31:0] factor_real_2;
reg     [31:0] factor_imag_2;
wire    [23:0] y0_real_2;
wire    [23:0] y0_imag_2;
wire    [23:0] y1_real_2;
wire    [23:0] y1_imag_2;
//第4级的例化
reg     [23:0] butt2_real0_3;
reg     [23:0] butt2_imag0_3;
reg     [23:0] butt2_real1_3;
reg     [23:0] butt2_imag1_3;
reg     [31:0] factor_real_3;
reg     [31:0] factor_imag_3;
wire    [23:0]     y0_real_3;
wire    [23:0]     y0_imag_3;
wire    [23:0]     y1_real_3;
wire    [23:0]     y1_imag_3;

butter_2 u0(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_0),
                 .butt2_imag0(butt2_imag0_0),
                 .butt2_real1(butt2_real1_0),
                 .butt2_imag1(butt2_imag1_0),
                 .factor_real(factor_real_0),
                 .factor_imag(factor_imag_0),
                 .y0_real(y0_real_0),
                 .y0_imag(y0_imag_0),
                 .y1_real(y1_real_0),
                 .y1_imag(y1_imag_0)
           );
butter_2 u1(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_1),
                 .butt2_imag0(butt2_imag0_1),
                 .butt2_real1(butt2_real1_1),
                 .butt2_imag1(butt2_imag1_1),
                 .factor_real(factor_real_1),
                 .factor_imag(factor_imag_1),
                 .y0_real(y0_real_1),
                 .y0_imag(y0_imag_1),
                 .y1_real(y1_real_1),
                 .y1_imag(y1_imag_1)
           );
butter_2 u2(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_2),
                 .butt2_imag0(butt2_imag0_2),
                 .butt2_real1(butt2_real1_2),
                 .butt2_imag1(butt2_imag1_2),
                 .factor_real(factor_real_2),
                 .factor_imag(factor_imag_2),
                 .y0_real(y0_real_2),
                 .y0_imag(y0_imag_2),
                 .y1_real(y1_real_2),
                 .y1_imag(y1_imag_2)
           );
butter_2 u3(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0_3),
                 .butt2_imag0(butt2_imag0_3),
                 .butt2_real1(butt2_real1_3),
                 .butt2_imag1(butt2_imag1_3),
                 .factor_real(factor_real_3),
                 .factor_imag(factor_imag_3),
                 .y0_real(y0_real_3),
                 .y0_imag(y0_imag_3),
                 .y1_real(y1_real_3),
                 .y1_imag(y1_imag_3)
           );

//第1级输出寄存器
reg [23:0] out_0_real0;
reg [23:0] out_0_imag0;
reg [23:0] out_0_real1;
reg [23:0] out_0_imag1;
reg [23:0] out_0_real2;
reg [23:0] out_0_imag2;
reg [23:0] out_0_real3;
reg [23:0] out_0_imag3;
reg [23:0] out_0_real4;
reg [23:0] out_0_imag4;
reg [23:0] out_0_real5;
reg [23:0] out_0_imag5;
reg [23:0] out_0_real6;
reg [23:0] out_0_imag6;
reg [23:0] out_0_real7;
reg [23:0] out_0_imag7;
reg [23:0] out_0_real8;
reg [23:0] out_0_imag8;
reg [23:0] out_0_real9;
reg [23:0] out_0_imag9;
reg [23:0] out_0_real10;
reg [23:0] out_0_imag10;
reg [23:0] out_0_real11;
reg [23:0] out_0_imag11;
reg [23:0] out_0_real12;
reg [23:0] out_0_imag12;
reg [23:0] out_0_real13;
reg [23:0] out_0_imag13;
reg [23:0] out_0_real14;
reg [23:0] out_0_imag14;
reg [23:0] out_0_real15;
reg [23:0] out_0_imag15;

//第2级输出寄存器
reg [23:0] in_1_real0;
reg [23:0] in_1_imag0;
reg [23:0] in_1_real1;
reg [23:0] in_1_imag1;
reg [23:0] in_1_real2;
reg [23:0] in_1_imag2;
reg [23:0] in_1_real3;
reg [23:0] in_1_imag3;
reg [23:0] in_1_real4;
reg [23:0] in_1_imag4;
reg [23:0] in_1_real5;
reg [23:0] in_1_imag5;
reg [23:0] in_1_real6;
reg [23:0] in_1_imag6;
reg [23:0] in_1_real7;
reg [23:0] in_1_imag7;
reg [23:0] in_1_real8;
reg [23:0] in_1_imag8;
reg [23:0] in_1_real9;
reg [23:0] in_1_imag9;
reg [23:0] in_1_real10;
reg [23:0] in_1_imag10;
reg [23:0] in_1_real11;
reg [23:0] in_1_imag11;
reg [23:0] in_1_real12;
reg [23:0] in_1_imag12;
reg [23:0] in_1_real13;
reg [23:0] in_1_imag13;
reg [23:0] in_1_real14;
reg [23:0] in_1_imag14;
reg [23:0] in_1_real15;
reg [23:0] in_1_imag15;

reg [23:0] out_1_real0;
reg [23:0] out_1_imag0;
reg [23:0] out_1_real1;
reg [23:0] out_1_imag1;
reg [23:0] out_1_real2;
reg [23:0] out_1_imag2;
reg [23:0] out_1_real3;
reg [23:0] out_1_imag3;
reg [23:0] out_1_real4;
reg [23:0] out_1_imag4;
reg [23:0] out_1_real5;
reg [23:0] out_1_imag5;
reg [23:0] out_1_real6;
reg [23:0] out_1_imag6;
reg [23:0] out_1_real7;
reg [23:0] out_1_imag7;
reg [23:0] out_1_real8;
reg [23:0] out_1_imag8;
reg [23:0] out_1_real9;
reg [23:0] out_1_imag9;
reg [23:0] out_1_real10;
reg [23:0] out_1_imag10;
reg [23:0] out_1_real11;
reg [23:0] out_1_imag11;
reg [23:0] out_1_real12;
reg [23:0] out_1_imag12;
reg [23:0] out_1_real13;
reg [23:0] out_1_imag13;
reg [23:0] out_1_real14;
reg [23:0] out_1_imag14;
reg [23:0] out_1_real15;
reg [23:0] out_1_imag15;

//第3级输出寄存器
reg [23:0] in_2_real0;
reg [23:0] in_2_imag0;
reg [23:0] in_2_real1;
reg [23:0] in_2_imag1;
reg [23:0] in_2_real2;
reg [23:0] in_2_imag2;
reg [23:0] in_2_real3;
reg [23:0] in_2_imag3;
reg [23:0] in_2_real4;
reg [23:0] in_2_imag4;
reg [23:0] in_2_real5;
reg [23:0] in_2_imag5;
reg [23:0] in_2_real6;
reg [23:0] in_2_imag6;
reg [23:0] in_2_real7;
reg [23:0] in_2_imag7;
reg [23:0] in_2_real8;
reg [23:0] in_2_imag8;
reg [23:0] in_2_real9;
reg [23:0] in_2_imag9;
reg [23:0] in_2_real10;
reg [23:0] in_2_imag10;
reg [23:0] in_2_real11;
reg [23:0] in_2_imag11;
reg [23:0] in_2_real12;
reg [23:0] in_2_imag12;
reg [23:0] in_2_real13;
reg [23:0] in_2_imag13;
reg [23:0] in_2_real14;
reg [23:0] in_2_imag14;
reg [23:0] in_2_real15;
reg [23:0] in_2_imag15;

reg [23:0] out_2_real0;
reg [23:0] out_2_imag0;
reg [23:0] out_2_real1;
reg [23:0] out_2_imag1;
reg [23:0] out_2_real2;
reg [23:0] out_2_imag2;
reg [23:0] out_2_real3;
reg [23:0] out_2_imag3;
reg [23:0] out_2_real4;
reg [23:0] out_2_imag4;
reg [23:0] out_2_real5;
reg [23:0] out_2_imag5;
reg [23:0] out_2_real6;
reg [23:0] out_2_imag6;
reg [23:0] out_2_real7;
reg [23:0] out_2_imag7;
reg [23:0] out_2_real8;
reg [23:0] out_2_imag8;
reg [23:0] out_2_real9;
reg [23:0] out_2_imag9;
reg [23:0] out_2_real10;
reg [23:0] out_2_imag10;
reg [23:0] out_2_real11;
reg [23:0] out_2_imag11;
reg [23:0] out_2_real12;
reg [23:0] out_2_imag12;
reg [23:0] out_2_real13;
reg [23:0] out_2_imag13;
reg [23:0] out_2_real14;
reg [23:0] out_2_imag14;
reg [23:0] out_2_real15;
reg [23:0] out_2_imag15;

//第4级输出寄存器
reg [23:0] in_3_real0;
reg [23:0] in_3_imag0;
reg [23:0] in_3_real1;
reg [23:0] in_3_imag1;
reg [23:0] in_3_real2;
reg [23:0] in_3_imag2;
reg [23:0] in_3_real3;
reg [23:0] in_3_imag3;
reg [23:0] in_3_real4;
reg [23:0] in_3_imag4;
reg [23:0] in_3_real5;
reg [23:0] in_3_imag5;
reg [23:0] in_3_real6;
reg [23:0] in_3_imag6;
reg [23:0] in_3_real7;
reg [23:0] in_3_imag7;
reg [23:0] in_3_real8;
reg [23:0] in_3_imag8;
reg [23:0] in_3_real9;
reg [23:0] in_3_imag9;
reg [23:0] in_3_real10;
reg [23:0] in_3_imag10;
reg [23:0] in_3_real11;
reg [23:0] in_3_imag11;
reg [23:0] in_3_real12;
reg [23:0] in_3_imag12;
reg [23:0] in_3_real13;
reg [23:0] in_3_imag13;
reg [23:0] in_3_real14;
reg [23:0] in_3_imag14;
reg [23:0] in_3_real15;
reg [23:0] in_3_imag15;

reg [23:0] out_3_real0;
reg [23:0] out_3_imag0;
reg [23:0] out_3_real1;
reg [23:0] out_3_imag1;
reg [23:0] out_3_real2;
reg [23:0] out_3_imag2;
reg [23:0] out_3_real3;
reg [23:0] out_3_imag3;
reg [23:0] out_3_real4;
reg [23:0] out_3_imag4;
reg [23:0] out_3_real5;
reg [23:0] out_3_imag5;
reg [23:0] out_3_real6;
reg [23:0] out_3_imag6;
reg [23:0] out_3_real7;
reg [23:0] out_3_imag7;
reg [23:0] out_3_real8;
reg [23:0] out_3_imag8;
reg [23:0] out_3_real9;
reg [23:0] out_3_imag9;
reg [23:0] out_3_real10;
reg [23:0] out_3_imag10;
reg [23:0] out_3_real11;
reg [23:0] out_3_imag11;
reg [23:0] out_3_real12;
reg [23:0] out_3_imag12;
reg [23:0] out_3_real13;
reg [23:0] out_3_imag13;
reg [23:0] out_3_real14;
reg [23:0] out_3_imag14;
reg [23:0] out_3_real15;
reg [23:0] out_3_imag15;


//输入的数据寄存器
reg [23:0] data_in_real0;
reg [23:0] data_in_imag0;
reg [23:0] data_in_real1;
reg [23:0] data_in_imag1;
reg [23:0] data_in_real2;
reg [23:0] data_in_imag2;
reg [23:0] data_in_real3;
reg [23:0] data_in_imag3;
reg [23:0] data_in_real4;
reg [23:0] data_in_imag4;
reg [23:0] data_in_real5;
reg [23:0] data_in_imag5;
reg [23:0] data_in_real6;
reg [23:0] data_in_imag6;
reg [23:0] data_in_real7;
reg [23:0] data_in_imag7;
reg [23:0] data_in_real8;
reg [23:0] data_in_imag8;
reg [23:0] data_in_real9;
reg [23:0] data_in_imag9;
reg [23:0] data_in_real10;
reg [23:0] data_in_imag10;
reg [23:0] data_in_real11;
reg [23:0] data_in_imag11;
reg [23:0] data_in_real12;
reg [23:0] data_in_imag12;
reg [23:0] data_in_real13;
reg [23:0] data_in_imag13;
reg [23:0] data_in_real14;
reg [23:0] data_in_imag14;
reg [23:0] data_in_real15;
reg [23:0] data_in_imag15;

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

//第1级fft运算
always @(posedge clk or negedge rst) begin
    if (rst == RST_LVL)
        i<=20'd0;
    else begin
        case(i)
            20'd0: begin
                data_in_real0  <=butt16_real0  ;  data_in_imag0<=butt16_imag0    ; 
                data_in_real1  <=butt16_real8  ;  data_in_imag1<=butt16_imag8    ; 
                data_in_real2  <=butt16_real4  ;  data_in_imag2<=butt16_imag4    ; 
                data_in_real3  <=butt16_real12 ;  data_in_imag3<=butt16_imag12   ;
                data_in_real4  <=butt16_real2  ;  data_in_imag4<=butt16_imag2    ; 
                data_in_real5  <=butt16_real10 ;  data_in_imag5<=butt16_imag10   ;
                data_in_real6  <=butt16_real6  ;  data_in_imag6<=butt16_imag6    ; 
                data_in_real7  <=butt16_real14 ;  data_in_imag7<=butt16_imag14   ;
			    data_in_real8  <=butt16_real1  ;  data_in_imag8<=butt16_imag1    ; 
                data_in_real9  <=butt16_real9  ;  data_in_imag9<=butt16_imag9    ;
                data_in_real10 <=butt16_real5  ;  data_in_imag10<=butt16_imag5   ;
                data_in_real11 <=butt16_real13 ;  data_in_imag11<=butt16_imag13  ;
                data_in_real12 <=butt16_real3  ;  data_in_imag12<=butt16_imag3   ;
                data_in_real13 <=butt16_real11 ;  data_in_imag13<=butt16_imag11  ;
                data_in_real14 <=butt16_real7  ;  data_in_imag14<=butt16_imag7   ;
                data_in_real15 <=butt16_real15 ;  data_in_imag15<=butt16_imag15  ;
                i<=i+1;
            end
        //0
        20'd1: begin
                butt2_real0_0<=data_in_real0;butt2_imag0_0<=data_in_imag0;
                butt2_real1_0<=data_in_real1;butt2_imag1_0<=data_in_imag1;
                factor_real_0<=factor_real0  ;factor_imag_0<=factor_imag0  ;
                i<=i+1;
              end
        20'd2:#26 begin i<=i+1; end
        20'd3:begin
                out_0_real0 <=y0_real_0;out_0_imag0 <=y0_imag_0;
                out_0_real1 <=y1_real_0;out_0_imag1 <=y1_imag_0;
                i<=i+1;
              end
        20'd4:#3 begin i<=i+1; end
    //1
    20'd5: begin
            butt2_real0_0<=data_in_real2;butt2_imag0_0<=data_in_imag2;
            butt2_real1_0<=data_in_real3;butt2_imag1_0<=data_in_imag3;
            factor_real_0<=factor_real0  ;factor_imag_0<=factor_imag0  ;
            i<=i+1;
          end
    20'd6:#26 begin i<=i+1; end
    20'd7:begin
            out_0_real2 <=y0_real_0;out_0_imag2 <=y0_imag_0;
            out_0_real3 <=y1_real_0;out_0_imag3 <=y1_imag_0;
            i<=i+1;
          end
    20'd8:#3 begin i<=i+1; end
    //2
    20'd9: begin
            butt2_real0_0<=data_in_real4;butt2_imag0_0<=data_in_imag4;
            butt2_real1_0<=data_in_real5;butt2_imag1_0<=data_in_imag5;
            factor_real_0<=factor_real0  ;factor_imag_0<=factor_imag0  ;
            i<=i+1;
          end
    20'd10:#26 begin i<=i+1; end
    20'd11:begin
            out_0_real4 <=y0_real_0;out_0_imag4 <=y0_imag_0;
            out_0_real5 <=y1_real_0;out_0_imag5 <=y1_imag_0;
            i<=i+1;
          end
    20'd12:#3 begin i<=i+1; end
    //3
    20'd13: begin
            butt2_real0_0<=data_in_real6;butt2_imag0_0<=data_in_imag6;
            butt2_real1_0<=data_in_real7;butt2_imag1_0<=data_in_imag7;
            factor_real_0<=factor_real0  ;factor_imag_0<=factor_imag0  ;
            i<=i+1;
          end
    20'd14:#26 begin i<=i+1; end
    20'd15:begin
            out_0_real6 <=y0_real_0;out_0_imag6 <=y0_imag_0;
            out_0_real7 <=y1_real_0;out_0_imag7 <=y1_imag_0;
            i<=i+1;
          end
    20'd16:#3 begin i<=i+1; end
    //4
    20'd17: begin
            butt2_real0_0<=data_in_real8;butt2_imag0_0<=data_in_imag8;
            butt2_real1_0<=data_in_real9;butt2_imag1_0<=data_in_imag9;
            factor_real_0<=factor_real0  ;factor_imag_0<=factor_imag0  ;
            i<=i+1;
          end
    20'd18:#26 begin i<=i+1; end
    20'd19:begin
            out_0_real8 <=y0_real_0;out_0_imag8 <=y0_imag_0;
            out_0_real9 <=y1_real_0;out_0_imag9 <=y1_imag_0;
            i<=i+1;
          end
    20'd20:#3 begin i<=i+1; end
    //5
    20'd21: begin
            butt2_real0_0<=data_in_real10;butt2_imag0_0<=data_in_imag10;
            butt2_real1_0<=data_in_real11;butt2_imag1_0<=data_in_imag11;
            factor_real_0<=factor_real0  ;factor_imag_0<=factor_imag0  ;
            i<=i+1;
          end
    20'd22:#26 begin i<=i+1; end
    20'd23:begin
            out_0_real10 <=y0_real_0;out_0_imag10 <=y0_imag_0;
            out_0_real11 <=y1_real_0;out_0_imag11 <=y1_imag_0;
            i<=i+1;
          end
    20'd24:#3 begin i<=i+1; end
    //6
    20'd25: begin
            butt2_real0_0<=data_in_real12;butt2_imag0_0<=data_in_imag12;
            butt2_real1_0<=data_in_real13;butt2_imag1_0<=data_in_imag13;
            factor_real_0<=factor_real0  ;factor_imag_0<=factor_imag0  ;
            i<=i+1;
          end
    20'd26:#26 begin i<=i+1; end
    20'd27:begin
            out_0_real12<=y0_real_0;out_0_imag12<=y0_imag_0;
            out_0_real13<=y1_real_0;out_0_imag13<=y1_imag_0;
            i<=i+1;
          end
    20'd28:#3 begin i<=i+1; end
    //7
    20'd29: begin
            butt2_real0_0<=data_in_real14;butt2_imag0_0<=data_in_imag14;
            butt2_real1_0<=data_in_real15;butt2_imag1_0<=data_in_imag15;
            factor_real_0<=factor_real0  ;factor_imag_0<=factor_imag0  ;
            i<=i+1;
          end
    20'd30:#26 begin i<=i+1; end
    20'd31:begin
            out_0_real14<=y0_real_0;out_0_imag14<=y0_imag_0;
            out_0_real15<=y1_real_0;out_0_imag15<=y1_imag_0;
             i<=i+1;
            // i<=0;
           end
    20'd32:#3 begin i<=0; end

    //
            // 20'd33:
            //     begin
            //        register_roundend_real0 <=out_3_real0 ;register_roundend_imag0 <=out_3_imag0 ;
            //        register_roundend_real1 <=out_3_real1 ;register_roundend_imag1 <=out_3_imag1 ;
            //        register_roundend_real2 <=out_3_real2 ;register_roundend_imag2 <=out_3_imag2 ;
            //        register_roundend_real3 <=out_3_real3 ;register_roundend_imag3 <=out_3_imag3 ;
            //        register_roundend_real4 <=out_3_real4 ;register_roundend_imag4 <=out_3_imag4 ;
            //        register_roundend_real5 <=out_3_real5 ;register_roundend_imag5 <=out_3_imag5 ;
            //        register_roundend_real6 <=out_3_real6 ;register_roundend_imag6 <=out_3_imag6 ;
            //        register_roundend_real7 <=out_3_real7 ;register_roundend_imag7 <=out_3_imag7 ;  
            //        register_roundend_real8 <=out_3_real8 ;register_roundend_imag8 <=out_3_imag8 ;
            //        register_roundend_real9 <=out_3_real9 ;register_roundend_imag9 <=out_3_imag9 ;
            //        register_roundend_real10<=out_3_real10;register_roundend_imag10<=out_3_imag10;
            //        register_roundend_real11<=out_3_real11;register_roundend_imag11<=out_3_imag11;
            //        register_roundend_real12<=out_3_real12;register_roundend_imag12<=out_3_imag12;
            //        register_roundend_real13<=out_3_real13;register_roundend_imag13<=out_3_imag13;
            //        register_roundend_real14<=out_3_real14;register_roundend_imag14<=out_3_imag14;
            //        register_roundend_real15<=out_3_real15;register_roundend_imag15<=out_3_imag15;  
            //        i<=i+1;               
            //     end
          //  20'd34:
          //      begin i<=0;end
             default:
                begin i<=0; end
             endcase end end     



/***第2级的级内串行fft计算***/
always @(posedge clk or negedge rst) begin
    if (rst == RST_LVL)
        i<=20'd0;
     else begin
          case(i)
          20'd0:begin
              in_1_real0 <=out_0_real0 ;in_1_imag0 <=out_0_imag0 ;
              in_1_real1 <=out_0_real1 ;in_1_imag1 <=out_0_imag1 ;
              in_1_real2 <=out_0_real2 ;in_1_imag2 <=out_0_imag2 ;
              in_1_real3 <=out_0_real3 ;in_1_imag3 <=out_0_imag3 ;
              in_1_real4 <=out_0_real4 ;in_1_imag4 <=out_0_imag4 ;
              in_1_real5 <=out_0_real5 ;in_1_imag5 <=out_0_imag5 ;
              in_1_real6 <=out_0_real6 ;in_1_imag6 <=out_0_imag6 ;
              in_1_real7 <=out_0_real7 ;in_1_imag7 <=out_0_imag7 ;
              in_1_real8 <=out_0_real8 ;in_1_imag8 <=out_0_imag8 ;
              in_1_real9 <=out_0_real9 ;in_1_imag9 <=out_0_imag9 ;
              in_1_real10<=out_0_real10;in_1_imag10<=out_0_imag10;
              in_1_real11<=out_0_real11;in_1_imag11<=out_0_imag11;
              in_1_real12<=out_0_real12;in_1_imag12<=out_0_imag12;
              in_1_real13<=out_0_real13;in_1_imag13<=out_0_imag13;
              in_1_real14<=out_0_real14;in_1_imag14<=out_0_imag14;
              in_1_real15<=out_0_real15;in_1_imag15<=out_0_imag15;
          end
    //0
    20'd1: begin
             butt2_real0_1<=in_1_real0 ;butt2_imag0_1<=in_1_imag0 ;
             butt2_real1_1<=in_1_real2 ;butt2_imag1_1<=in_1_imag2 ;
             factor_real_1<=factor_real0;factor_imag_1<=factor_imag0  ;
             i<=i+1;
           end
    20'd2:#26 begin i<=i+1; end
    20'd3:begin
             out_1_real0 <=y0_real_1;out_1_imag0 <=y0_imag_1;
             out_1_real2 <=y1_real_1;out_1_imag2 <=y1_imag_1;
             i<=i+1;
           end
    20'd4:#3 begin i<=i+1; end
    //1
    20'd5: begin
             butt2_real0_1<=in_1_real1 ;butt2_imag0_1<=in_1_imag1 ;
             butt2_real1_1<=in_1_real3 ;butt2_imag1_1<=in_1_imag3 ;
             factor_real_1<=factor_real4;factor_imag_1<=factor_imag4  ;
             i<=i+1;
           end
    20'd6:#26 begin i<=i+1; end
    20'd7:begin
             out_1_real1 <=y0_real_1;out_1_imag1 <=y0_imag_1;
             out_1_real3 <=y1_real_1;out_1_imag3 <=y1_imag_1;
             i<=i+1;
           end
    20'd8:#3 begin i<=i+1; end
    //2
    20'd9: begin
             butt2_real0_1<=in_1_real4 ;butt2_imag0_1<=in_1_imag4 ;
             butt2_real1_1<=in_1_real6 ;butt2_imag1_1<=in_1_imag6 ;
             factor_real_1<=factor_real0;factor_imag_1<=factor_imag0  ;
             i<=i+1;
           end
    20'd10:#26 begin i<=i+1; end
    20'd11:begin
             out_1_real4 <=y0_real_1;out_1_imag4 <=y0_imag_1;
             out_1_real6 <=y1_real_1;out_1_imag6 <=y1_imag_1;
             i<=i+1;
           end
    20'd12:#3 begin i<=i+1; end
    //3
    20'd13: begin
             butt2_real0_1<=in_1_real5 ;butt2_imag0_1<=in_1_imag5 ;
             butt2_real1_1<=in_1_real7 ;butt2_imag1_1<=in_1_imag7 ;
             factor_real_1<=factor_real4;factor_imag_1<=factor_imag4  ;
             i<=i+1;
           end
    20'd14:#26 begin i<=i+1; end
    20'd15:begin
             out_1_real5 <=y0_real_1;out_1_imag5 <=y0_imag_1;
             out_1_real7 <=y1_real_1;out_1_imag7 <=y1_imag_1;
             i<=i+1;
           end
    20'd16:#3 begin i<=i+1; end
    //4
    20'd17: begin
             butt2_real0_1<=in_1_real8 ;butt2_imag0_1<=in_1_imag8 ;
             butt2_real1_1<=in_1_real10;butt2_imag1_1<=in_1_imag10;
             factor_real_1<=factor_real0;factor_imag_1<=factor_imag0  ;
             i<=i+1;
           end
    20'd18:#26 begin i<=i+1; end
    20'd19:begin
             out_1_real8  <=y0_real_1;out_1_imag8 <=y0_imag_1;
             out_1_real10 <=y1_real_1;out_1_imag10<=y1_imag_1;
             i<=i+1;
           end
    20'd20:#3 begin i<=i+1; end
    //5
    20'd21: begin
             butt2_real0_1<=in_1_real9 ;butt2_imag0_1<=in_1_imag9 ;
             butt2_real1_1<=in_1_real11;butt2_imag1_1<=in_1_imag11;
             factor_real_1<=factor_real4;factor_imag_1<=factor_imag4  ;
             i<=i+1;
           end
    20'd22:#26 begin i<=i+1; end
    20'd23:begin
             out_1_real9 <=y0_real_1;out_1_imag9 <=y0_imag_1;
             out_1_real11<=y1_real_1;out_1_imag11<=y1_imag_1;
             i<=i+1;
           end
    20'd24:#3 begin i<=i+1; end
    //6
    20'd25: begin
             butt2_real0_1<=in_1_real12;butt2_imag0_1<=in_1_imag12;
             butt2_real1_1<=in_1_real14;butt2_imag1_1<=in_1_imag14;
             factor_real_1<=factor_real0;factor_imag_1<=factor_imag0;
             i<=i+1;
           end
    20'd26:#26 begin i<=i+1; end
    20'd27:begin
             out_1_real12<=y0_real_1;out_1_imag12<=y0_imag_1;
             out_1_real14<=y1_real_1;out_1_imag14<=y1_imag_1;
             i<=i+1;
           end
    20'd28:#3 begin i<=i+1; end
    //7
    20'd29: begin
             butt2_real0_1<=in_1_real13;butt2_imag0_1<=in_1_imag13;
             butt2_real1_1<=in_1_real15;butt2_imag1_1<=in_1_imag15;
             factor_real_1<=factor_real4;factor_imag_1<=factor_imag4;
             i<=i+1;
           end
    20'd30:#26 begin i<=i+1; end
    20'd31:begin
             out_1_real13<=y0_real_1;out_1_imag13<=y0_imag_1;
             out_1_real15<=y1_real_1;out_1_imag15<=y1_imag_1;
             i<=i+1;
            // i<=0;
           end
    20'd32:#3 begin i<=0; end
endcase end end



/***第3级fft运算***/
always @(posedge clk or negedge rst) begin
    if (rst == RST_LVL)
        i<=20'd0;
     else begin
          case(i)
          20'd0:begin
              in_2_real0 <=out_1_real0 ;in_2_imag0 <=out_1_imag0 ;
              in_2_real1 <=out_1_real1 ;in_2_imag1 <=out_1_imag1 ;
              in_2_real2 <=out_1_real2 ;in_2_imag2 <=out_1_imag2 ;
              in_2_real3 <=out_1_real3 ;in_2_imag3 <=out_1_imag3 ;
              in_2_real4 <=out_1_real4 ;in_2_imag4 <=out_1_imag4 ;
              in_2_real5 <=out_1_real5 ;in_2_imag5 <=out_1_imag5 ;
              in_2_real6 <=out_1_real6 ;in_2_imag6 <=out_1_imag6 ;
              in_2_real7 <=out_1_real7 ;in_2_imag7 <=out_1_imag7 ;
              in_2_real8 <=out_1_real8 ;in_2_imag8 <=out_1_imag8 ;
              in_2_real9 <=out_1_real9 ;in_2_imag9 <=out_1_imag9 ;
              in_2_real10<=out_1_real10;in_2_imag10<=out_1_imag10;
              in_2_real11<=out_1_real11;in_2_imag11<=out_1_imag11;
              in_2_real12<=out_1_real12;in_2_imag12<=out_1_imag12;
              in_2_real13<=out_1_real13;in_2_imag13<=out_1_imag13;
              in_2_real14<=out_1_real14;in_2_imag14<=out_1_imag14;
              in_2_real15<=out_1_real15;in_2_imag15<=out_1_imag15;
          end
    //0
    20'd1: begin
             butt2_real0_2<=in_2_real0 ;butt2_imag0_2<=in_2_imag0 ;
             butt2_real1_2<=in_2_real4 ;butt2_imag1_2<=in_2_imag4 ;
             factor_real_2<=factor_real0;factor_imag_2<=factor_imag0  ;
             i<=i+1;
           end
    20'd2:#26 begin i<=i+1; end
    20'd3:begin
             out_2_real0 <=y0_real_2;out_2_imag0 <=y0_imag_2;
             out_2_real4 <=y1_real_2;out_2_imag4 <=y1_imag_2;
             i<=i+1;
           end
    20'd4:#3 begin i<=i+1; end
    //1
    20'd5: begin
             butt2_real0_2<=in_2_real1 ;butt2_imag0_2<=in_2_imag1 ;
             butt2_real1_2<=in_2_real5 ;butt2_imag1_2<=in_2_imag5 ;
             factor_real_2<=factor_real2;factor_imag_2<=factor_imag2;
             i<=i+1;
           end
    20'd6:#26 begin i<=i+1; end
    20'd7:begin
             out_2_real1 <=y0_real_2;out_2_imag1 <=y0_imag_2;
             out_2_real5 <=y1_real_2;out_2_imag5 <=y1_imag_2;
             i<=i+1;
           end
    20'd8:#3 begin i<=i+1; end
    //2
    20'd9: begin
             butt2_real0_2<=in_2_real2 ;butt2_imag0_2<=in_2_imag2 ;
             butt2_real1_2<=in_2_real6 ;butt2_imag1_2<=in_2_imag6 ;
             factor_real_2<=factor_real4;factor_imag_2<=factor_imag4;
             i<=i+1;
           end
    20'd10:#26 begin i<=i+1; end
    20'd11:begin
             out_2_real2 <=y0_real_2;out_2_imag2 <=y0_imag_2;
             out_2_real6 <=y1_real_2;out_2_imag6 <=y1_imag_2;
             i<=i+1;
           end
    20'd12:#3 begin i<=i+1; end
    //3
    20'd13: begin
             butt2_real0_2<=in_2_real3 ;butt2_imag0_2<=in_2_imag3 ;
             butt2_real1_2<=in_2_real7 ;butt2_imag1_2<=in_2_imag7 ;
             factor_real_2<=factor_real6;factor_imag_2<=factor_imag6;
             i<=i+1;
           end
    20'd14:#26 begin i<=i+1; end
    20'd15:begin
             out_2_real3 <=y0_real_2;out_2_imag3 <=y0_imag_2;
             out_2_real7 <=y1_real_2;out_2_imag7 <=y1_imag_2;
             i<=i+1;
           end
    20'd16:#3 begin i<=i+1; end
    //4
    20'd17: begin
             butt2_real0_2<=in_2_real8 ;butt2_imag0_2<=in_2_imag8 ;
             butt2_real1_2<=in_2_real12;butt2_imag1_2<=in_2_imag12;
             factor_real_2<=factor_real0;factor_imag_2<=factor_imag0;
             i<=i+1;
           end
    20'd18:#26 begin i<=i+1; end
    20'd19:begin
             out_2_real8 <=y0_real_2;out_2_imag8 <=y0_imag_2;
             out_2_real12<=y1_real_2;out_2_imag12<=y1_imag_2;
             i<=i+1;
           end
    20'd20:#3 begin i<=i+1; end
    //5
    20'd21: begin
             butt2_real0_2<=in_2_real9 ;butt2_imag0_2<=in_2_imag9 ;
             butt2_real1_2<=in_2_real13;butt2_imag1_2<=in_2_imag13;
             factor_real_2<=factor_real2;factor_imag_2<=factor_imag2;
             i<=i+1;
           end
    20'd22:#26 begin i<=i+1; end
    20'd23:begin
             out_2_real9 <=y0_real_2;out_2_imag9 <=y0_imag_2;
             out_2_real13<=y1_real_2;out_2_imag13<=y1_imag_2;
             i<=i+1;
           end
    20'd24:#3 begin i<=i+1; end
    //6
    20'd25: begin
             butt2_real0_2<=in_2_real10;butt2_imag0_2<=in_2_imag10;
             butt2_real1_2<=in_2_real14;butt2_imag1_2<=in_2_imag14;
             factor_real_2<=factor_real4;factor_imag_2<=factor_imag4;
             i<=i+1;
           end
    20'd26:#26 begin i<=i+1; end
    20'd27:begin
             out_2_real10<=y0_real_2;out_2_imag10<=y0_imag_2;
             out_2_real14<=y1_real_2;out_2_imag14<=y1_imag_2;
             i<=i+1;
           end
    20'd28:#3 begin i<=i+1; end
    //7
    20'd29: begin
             butt2_real0_2<=in_2_real11;butt2_imag0_2<=in_2_imag11;
             butt2_real1_2<=in_2_real15;butt2_imag1_2<=in_2_imag15;
             factor_real_2<=factor_real6;factor_imag_2<=factor_imag6;
             i<=i+1;
           end
    20'd30:#26 begin i<=i+1; end
    20'd31:begin
             out_2_real11<=y0_real_2;out_2_imag11<=y0_imag_2;
             out_2_real15<=y1_real_2;out_2_imag15<=y1_imag_2;
             i<=i+1;
            // i<=0;
           end
    20'd32:#3 begin i<=0; end
endcase end end




/***第4级fft运算***/
always @(posedge clk or negedge rst) begin
    if (rst == RST_LVL)
        i<=20'd0;
     else begin
          case(i)
          20'd0:begin
              in_3_real0 <=out_2_real0 ;in_3_imag0 <=out_2_imag0 ;
              in_3_real1 <=out_2_real1 ;in_3_imag1 <=out_2_imag1 ;
              in_3_real2 <=out_2_real2 ;in_3_imag2 <=out_2_imag2 ;
              in_3_real3 <=out_2_real3 ;in_3_imag3 <=out_2_imag3 ;
              in_3_real4 <=out_2_real4 ;in_3_imag4 <=out_2_imag4 ;
              in_3_real5 <=out_2_real5 ;in_3_imag5 <=out_2_imag5 ;
              in_3_real6 <=out_2_real6 ;in_3_imag6 <=out_2_imag6 ;
              in_3_real7 <=out_2_real7 ;in_3_imag7 <=out_2_imag7 ;
              in_3_real8 <=out_2_real8 ;in_3_imag8 <=out_2_imag8 ;
              in_3_real9 <=out_2_real9 ;in_3_imag9 <=out_2_imag9 ;
              in_3_real10<=out_2_real10;in_3_imag10<=out_2_imag10;
              in_3_real11<=out_2_real11;in_3_imag11<=out_2_imag11;
              in_3_real12<=out_2_real12;in_3_imag12<=out_2_imag12;
              in_3_real13<=out_2_real13;in_3_imag13<=out_2_imag13;
              in_3_real14<=out_2_real14;in_3_imag14<=out_2_imag14;
              in_3_real15<=out_2_real15;in_3_imag15<=out_2_imag15;
          end
    //0
    20'd1: begin
             butt2_real0_3<=in_3_real0 ;butt2_imag0_3<=in_3_imag0 ;
             butt2_real1_3<=in_3_real8 ;butt2_imag1_3<=in_3_imag8 ;
             factor_real_3<=factor_real0;factor_imag_3<=factor_imag0;
             i<=i+1;
           end
    20'd2:#26 begin i<=i+1; end
    20'd3:begin
             out_3_real0 <=y0_real_3;out_3_imag0 <=y0_imag_3;
             out_3_real8 <=y1_real_3;out_3_imag8 <=y1_imag_3;
             i<=i+1;
           end
    20'd4:#3 begin i<=i+1; end
    //1
    20'd5: begin
             butt2_real0_3<=in_3_real1 ;butt2_imag0_3<=in_3_imag1 ;
             butt2_real1_3<=in_3_real9 ;butt2_imag1_3<=in_3_imag9 ;
             factor_real_3<=factor_real1;factor_imag_3<=factor_imag1;
             i<=i+1;
           end
    20'd6:#26 begin i<=i+1; end
    20'd7:begin
             out_3_real1 <=y0_real_3;out_3_imag1 <=y0_imag_3;
             out_3_real9 <=y1_real_3;out_3_imag9 <=y1_imag_3;
             i<=i+1;
           end
    20'd8:#3 begin i<=i+1; end
    //2
    20'd9: begin
             butt2_real0_3<=in_3_real2 ;butt2_imag0_3<=in_3_imag2 ;
             butt2_real1_3<=in_3_real10;butt2_imag1_3<=in_3_imag10;
             factor_real_3<=factor_real2;factor_imag_3<=factor_imag2;
             i<=i+1;
           end
    20'd10:#26 begin i<=i+1; end
    20'd11:begin
             out_3_real2 <=y0_real_3;out_3_imag2 <=y0_imag_3;
             out_3_real10<=y1_real_3;out_3_imag10<=y1_imag_3;
             i<=i+1;
           end
    20'd12:#3 begin i<=i+1; end
    //3
    20'd13: begin
             butt2_real0_3<=in_3_real3 ;butt2_imag0_3<=in_3_imag3 ;
             butt2_real1_3<=in_3_real11;butt2_imag1_3<=in_3_imag11;
             factor_real_3<=factor_real3;factor_imag_3<=factor_imag3;
             i<=i+1;
           end
    20'd14:#26 begin i<=i+1; end
    20'd15:begin
             out_3_real3 <=y0_real_3;out_3_imag3 <=y0_imag_3;
             out_3_real11<=y1_real_3;out_3_imag11<=y1_imag_3;
             i<=i+1;
           end
    20'd16:#3 begin i<=i+1; end
    //4
    20'd17: begin
             butt2_real0_3<=in_3_real4 ;butt2_imag0_3<=in_3_imag4 ;
             butt2_real1_3<=in_3_real12;butt2_imag1_3<=in_3_imag12;
             factor_real_3<=factor_real4;factor_imag_3<=factor_imag4;
             i<=i+1;
           end
    20'd18:#26 begin i<=i+1; end
    20'd19:begin
             out_3_real4 <=y0_real_3;out_3_imag4 <=y0_imag_3;
             out_3_real12<=y1_real_3;out_3_imag12<=y1_imag_3;
             i<=i+1;
           end
    20'd20:#3 begin i<=i+1; end
    //5
    20'd21: begin
             butt2_real0_3<=in_3_real5 ;butt2_imag0_3<=in_3_imag5 ;
             butt2_real1_3<=in_3_real13;butt2_imag1_3<=in_3_imag13;
             factor_real_3<=factor_real5;factor_imag_3<=factor_imag5;
             i<=i+1;
           end
    20'd22:#26 begin i<=i+1; end
    20'd23:begin
             out_3_real5 <=y0_real_3;out_3_imag5 <=y0_imag_3;
             out_3_real13<=y1_real_3;out_3_imag13<=y1_imag_3;
             i<=i+1;
           end
    20'd24:#3 begin i<=i+1; end
    //6
    20'd25: begin
             butt2_real0_3<=in_3_real6 ;butt2_imag0_3<=in_3_imag6 ;
             butt2_real1_3<=in_3_real14;butt2_imag1_3<=in_3_imag14;
             factor_real_3<=factor_real6;factor_imag_3<=factor_imag6;
             i<=i+1;
           end
    20'd26:#26 begin i<=i+1; end
    20'd27:begin
             out_3_real6 <=y0_real_3;out_3_imag6 <=y0_imag_3;
             out_3_real14<=y1_real_3;out_3_imag14<=y1_imag_3;
             i<=i+1;
           end
    20'd28:#3 begin i<=i+1; end
    //7
    20'd29: begin
             butt2_real0_3<=in_3_real7 ;butt2_imag0_3<=in_3_imag7 ;
             butt2_real1_3<=in_3_real15;butt2_imag1_3<=in_3_imag15;
             factor_real_3<=factor_real7;factor_imag_3<=factor_imag7;
             i<=i+1;
           end
    20'd30:#26 begin i<=i+1; end
    20'd31:begin
             out_3_real7 <=y0_real_3;out_3_imag7 <=y0_imag_3;
             out_3_real15<=y1_real_3;out_3_imag15<=y1_imag_3;
             i<=i+1;
            // i<=0;
           end
    20'd32:#3 begin i<=0; end
endcase end end




//        register_roundend_real0 <=out_3_real0 ;register_roundend_imag0 <=out_3_imag0 ;
            //        register_roundend_real1 <=out_3_real1 ;register_roundend_imag1 <=out_3_imag1 ;
            //        register_roundend_real2 <=out_3_real2 ;register_roundend_imag2 <=out_3_imag2 ;
            //        register_roundend_real3 <=out_3_real3 ;register_roundend_imag3 <=out_3_imag3 ;
            //        register_roundend_real4 <=out_3_real4 ;register_roundend_imag4 <=out_3_imag4 ;
            //        register_roundend_real5 <=out_3_real5 ;register_roundend_imag5 <=out_3_imag5 ;
            //        register_roundend_real6 <=out_3_real6 ;register_roundend_imag6 <=out_3_imag6 ;
            //        register_roundend_real7 <=out_3_real7 ;register_roundend_imag7 <=out_3_imag7 ;  
            //        register_roundend_real8 <=out_3_real8 ;register_roundend_imag8 <=out_3_imag8 ;
            //        register_roundend_real9 <=out_3_real9 ;register_roundend_imag9 <=out_3_imag9 ;
            //        register_roundend_real10<=out_3_real10;register_roundend_imag10<=out_3_imag10;
            //        register_roundend_real11<=out_3_real11;register_roundend_imag11<=out_3_imag11;
            //        register_roundend_real12<=out_3_real12;register_roundend_imag12<=out_3_imag12;
            //        register_roundend_real13<=out_3_real13;register_roundend_imag13<=out_3_imag13;
            //        register_roundend_real14<=out_3_real14;register_roundend_imag14<=out_3_imag14;
            //        register_roundend_real15<=out_3_real15;register_roundend_imag15<=out_3_imag15;  

assign y0_real_fin =out_3_real0 ;
assign y0_imag_fin =out_3_imag0 ;
assign y1_real_fin =out_3_real1 ;
assign y1_imag_fin =out_3_imag1 ;
assign y2_real_fin =out_3_real2 ;
assign y2_imag_fin =out_3_imag2 ;
assign y3_real_fin =out_3_real3 ;
assign y3_imag_fin =out_3_imag3 ;
assign y4_real_fin =out_3_real4 ;
assign y4_imag_fin =out_3_imag4 ;
assign y5_real_fin =out_3_real5 ;
assign y5_imag_fin =out_3_imag5 ;
assign y6_real_fin =out_3_real6 ;
assign y6_imag_fin =out_3_imag6 ;
assign y7_real_fin =out_3_real7 ;
assign y7_imag_fin =out_3_imag7 ;
assign y8_real_fin =out_3_real8 ;
assign y8_imag_fin =out_3_imag8 ;
assign y9_real_fin =out_3_real9 ;
assign y9_imag_fin =out_3_imag9 ;
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