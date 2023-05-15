/****************************/
//作者:Wei Xuejing
//邮箱:2682152871@qq.com
//描述:16点顺序迭代fft
//时间:2023.05.13
/****************************/
module fft_0 #(
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

//蝶形计算
reg [23:0] butt2_real0;
reg [23:0] butt2_imag0;
reg [23:0] butt2_real1;
reg [23:0] butt2_imag1;
reg [31:0] factor_real;
reg [31:0] factor_imag;
wire [23:0] y0_real;
wire [23:0] y0_imag;
wire [23:0] y1_real;
wire [23:0] y1_imag;
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

butter_2 u1(
                 .clk(clk),
                 .rst(rst),
                 .butt2_real0(butt2_real0),
                 .butt2_imag0(butt2_imag0),
                 .butt2_real1(butt2_real1),
                 .butt2_imag1(butt2_imag1),
                 .factor_real(factor_real),
                 .factor_imag(factor_imag),
                 .y0_real(y0_real),
                 .y0_imag(y0_imag),
                 .y1_real(y1_real),
                 .y1_imag(y1_imag)
           );

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





















/***第1级fft运算***/
//**********butterfly_no_1_0***********************************************************************
            20'd1: begin
                      butt2_real0<=register_real0;butt2_imag0<=register_imag0;
                      butt2_real1<=register_real1;butt2_imag1<=register_imag1;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd2:#26 begin i<=i+1; end
            20'd3:begin
                     register_real0<=y0_real;register_imag0<=y0_imag;
                     register_real1<=y1_real;register_imag1<=y1_imag;
                     i<=i+1;
                  end
            20'd4:#3 begin i<=i+1; end
//********************************************************************************************
                 
//**********butterfly_no_1_1***********************************************************************
            20'd5: begin
                      butt2_real0<=register_real2;butt2_imag0<=register_imag2;
                      butt2_real1<=register_real3;butt2_imag1<=register_imag3;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd6:#26 begin i<=i+1; end
            20'd7:begin
                     register_real2<=y0_real;register_imag2<=y0_imag;
                     register_real3<=y1_real;register_imag3<=y1_imag;
                     i<=i+1;
                  end
            20'd8:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_1_2***********************************************************************
            20'd9: begin
                      butt2_real0<=register_real4;butt2_imag0<=register_imag4;
                      butt2_real1<=register_real5;butt2_imag1<=register_imag5;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd10:#26 begin i<=i+1; end
            20'd11:begin
                     register_real4<=y0_real;register_imag4<=y0_imag;
                     register_real5<=y1_real;register_imag5<=y1_imag;
                     i<=i+1;
                  end
            20'd12:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_1_3***********************************************************************
            20'd13: begin
                      butt2_real0<=register_real6;butt2_imag0<=register_imag6;
                      butt2_real1<=register_real7;butt2_imag1<=register_imag7;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd14:#26 begin i<=i+1; end
            20'd15:begin
                     register_real6<=y0_real;register_imag6<=y0_imag;
                     register_real7<=y1_real;register_imag7<=y1_imag;
                     i<=i+1;
                  end
            20'd16:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_1_4***********************************************************************
            20'd17: begin
                      butt2_real0<=register_real8;butt2_imag0<=register_imag8;
                      butt2_real1<=register_real9;butt2_imag1<=register_imag9;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd18:#26 begin i<=i+1; end
            20'd19:begin
                     register_real8<=y0_real;register_imag8<=y0_imag;
                     register_real9<=y1_real;register_imag9<=y1_imag;
                     i<=i+1;
                  end
            20'd20:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_1_5***********************************************************************
            20'd21: begin
                      butt2_real0<=register_real10;butt2_imag0<=register_imag10;
                      butt2_real1<=register_real11;butt2_imag1<=register_imag11;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd22:#26 begin i<=i+1; end
            20'd23:begin
                     register_real10<=y0_real;register_imag10<=y0_imag;
                     register_real11<=y1_real;register_imag11<=y1_imag;
                     i<=i+1;
                  end
            20'd24:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_1_6***********************************************************************
            20'd25: begin
                      butt2_real0<=register_real12;butt2_imag0<=register_imag12;
                      butt2_real1<=register_real13;butt2_imag1<=register_imag13;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd26:#26 begin i<=i+1; end
            20'd27:begin
                     register_real12<=y0_real;register_imag12<=y0_imag;
                     register_real13<=y1_real;register_imag13<=y1_imag;
                     i<=i+1;
                  end
            20'd28:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_1_7**********************************************************************
            20'd29: begin
                      butt2_real0<=register_real14;butt2_imag0<=register_imag14;
                      butt2_real1<=register_real15;butt2_imag1<=register_imag15;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd30:#26 begin i<=i+1; end
            20'd31:begin
                     register_real14<=y0_real;register_imag14<=y0_imag;
                     register_real15<=y1_real;register_imag15<=y1_imag;
                     i<=i+1;
                  end
            20'd32:#3 begin i<=i+1; end
//********************************************************************************************


















/***第二级fft运算***/
//**********butterfly_no_2_0***********************************************************************
            20'd33: begin
                      butt2_real0<=register_real0;butt2_imag0<=register_imag0;
                      butt2_real1<=register_real2;butt2_imag1<=register_imag2;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd34:#26 begin i<=i+1; end
            20'd35:begin
                     register_real0<=y0_real;register_imag0<=y0_imag;
                     register_real2<=y1_real;register_imag2<=y1_imag;
                     i<=i+1;
                  end
            20'd36:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_2_1***********************************************************************
            20'd37: begin
                      butt2_real0<=register_real1;butt2_imag0<=register_imag1;
                      butt2_real1<=register_real3;butt2_imag1<=register_imag3;
                      factor_real<=factor_real4;factor_imag<=factor_imag4;
                      i<=i+1;
                  end
            20'd38:#26 begin i<=i+1; end
            20'd39:begin
                     register_real1<=y0_real;register_imag1<=y0_imag;
                     register_real3<=y1_real;register_imag3<=y1_imag;
                     i<=i+1;
                  end
            20'd40:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_2_2***********************************************************************
            20'd41: begin
                      butt2_real0<=register_real4;butt2_imag0<=register_imag4;
                      butt2_real1<=register_real6;butt2_imag1<=register_imag6;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd42:#26 begin i<=i+1; end
            20'd43:begin
                     register_real4<=y0_real;register_imag4<=y0_imag;
                     register_real6<=y1_real;register_imag6<=y1_imag;
                     i<=i+1;
                  end
            20'd44:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_2_3***********************************************************************
            20'd45: begin
                      butt2_real0<=register_real5;butt2_imag0<=register_imag5;
                      butt2_real1<=register_real7;butt2_imag1<=register_imag7;
                      factor_real<=factor_real4;factor_imag<=factor_imag4;
                      i<=i+1;
                  end
            20'd46:#26 begin i<=i+1; end
            20'd47:begin
                     register_real5<=y0_real;register_imag5<=y0_imag;
                     register_real7<=y1_real;register_imag7<=y1_imag;
                     i<=i+1;
                  end
            20'd48:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_2_4***********************************************************************
            20'd49: begin
                      butt2_real0<=register_real8;butt2_imag0<=register_imag8;
                      butt2_real1<=register_real10;butt2_imag1<=register_imag10;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd50:#26 begin i<=i+1; end
            20'd51:begin
                     register_real8<=y0_real;register_imag8<=y0_imag;
                     register_real10<=y1_real;register_imag10<=y1_imag;
                     i<=i+1;
                  end
            20'd52:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_2_5***********************************************************************
            20'd53: begin
                      butt2_real0<=register_real9;butt2_imag0<=register_imag9;
                      butt2_real1<=register_real11;butt2_imag1<=register_imag11;
                      factor_real<=factor_real4;factor_imag<=factor_imag4;
                      i<=i+1;
                  end
            20'd54:#26 begin i<=i+1; end
            20'd55:begin
                     register_real9<=y0_real;register_imag9<=y0_imag;
                     register_real11<=y1_real;register_imag11<=y1_imag;
                     i<=i+1;
                  end
            20'd56:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_2_6***********************************************************************
            20'd57: begin
                      butt2_real0<=register_real12;butt2_imag0<=register_imag12;
                      butt2_real1<=register_real14;butt2_imag1<=register_imag14;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd58:#26 begin i<=i+1; end
            20'd59:begin
                     register_real12<=y0_real;register_imag12<=y0_imag;
                     register_real14<=y1_real;register_imag14<=y1_imag;
                     i<=i+1;
                  end
            20'd60:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_2_7***********************************************************************
            20'd61: begin
                      butt2_real0<=register_real13;butt2_imag0<=register_imag13;
                      butt2_real1<=register_real15;butt2_imag1<=register_imag15;
                      factor_real<=factor_real4;factor_imag<=factor_imag4;
                      i<=i+1;
                  end
            20'd62:#26 begin i<=i+1; end
            20'd63:begin
                     register_real13<=y0_real;register_imag13<=y0_imag;
                     register_real15<=y1_real;register_imag15<=y1_imag;
                     i<=i+1;
                  end
            20'd64:#3 begin i<=i+1; end
//********************************************************************************************



















/*第3级fft*/
//**********butterfly_no_3_0***********************************************************************
            20'd65: begin
                      butt2_real0<=register_real0;butt2_imag0<=register_imag0;
                      butt2_real1<=register_real4;butt2_imag1<=register_imag4;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd66:#26 begin i<=i+1; end
            20'd67:begin
                     register_real0<=y0_real;register_imag0<=y0_imag;
                     register_real4<=y1_real;register_imag4<=y1_imag;
                     i<=i+1;
                  end
            20'd68:#3 begin i<=i+1; end
//********************************************************************************************
//**********butterfly_no_3_1***********************************************************************
            20'd69: begin
                      butt2_real0<=register_real1;butt2_imag0<=register_imag1;
                      butt2_real1<=register_real5;butt2_imag1<=register_imag5;
                      factor_real<=factor_real2;factor_imag<=factor_imag2;
                      i<=i+1;
                  end
            20'd70:#26 begin i<=i+1; end
            20'd71:begin
                     register_real1<=y0_real;register_imag1<=y0_imag;
                     register_real5<=y1_real;register_imag5<=y1_imag;
                     i<=i+1;
                  end
            20'd72:#3 begin i<=i+1; end
//********************************************************************************************
//**********butterfly_no_3_2***********************************************************************
            20'd73: begin
                      butt2_real0<=register_real2;butt2_imag0<=register_imag2;
                      butt2_real1<=register_real6;butt2_imag1<=register_imag6;
                      factor_real<=factor_real4;factor_imag<=factor_imag4;
                      i<=i+1;
                  end
            20'd74:#26 begin i<=i+1; end
            20'd75:begin
                     register_real2<=y0_real;register_imag2<=y0_imag;
                     register_real6<=y1_real;register_imag6<=y1_imag;
                     i<=i+1;
                  end
            20'd76:#3 begin i<=i+1; end
//********************************************************************************************
//**********butterfly_no_3_3***********************************************************************
            20'd77: begin
                      butt2_real0<=register_real3;butt2_imag0<=register_imag3;
                      butt2_real1<=register_real7;butt2_imag1<=register_imag7;
                      factor_real<=factor_real6;factor_imag<=factor_imag6;
                      i<=i+1;
                  end
            20'd78:#26 begin i<=i+1; end
            20'd79:begin
                     register_real3<=y0_real;register_imag3<=y0_imag;
                     register_real7<=y1_real;register_imag7<=y1_imag;
                     i<=i+1;
                  end
            20'd80:#3 begin i<=i+1; end
//********************************************************************************************     

//**********butterfly_no_3_4***********************************************************************
            20'd81: begin
                      butt2_real0<=register_real8;butt2_imag0<=register_imag8;
                      butt2_real1<=register_real12;butt2_imag1<=register_imag12;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd82:#26 begin i<=i+1; end
            20'd83:begin
                     register_real8<=y0_real;register_imag8<=y0_imag;
                     register_real12<=y1_real;register_imag12<=y1_imag;
                     i<=i+1;
                  end
            20'd84:#3 begin i<=i+1; end
//********************************************************************************************
//**********butterfly_no_3_5***********************************************************************
            20'd85: begin
                      butt2_real0<=register_real9 ;butt2_imag0<=register_imag9 ;
                      butt2_real1<=register_real13;butt2_imag1<=register_imag13;
                      factor_real<=factor_real2;factor_imag<=factor_imag2;
                      i<=i+1;
                  end
            20'd86:#26 begin i<=i+1; end
            20'd87:begin
                     register_real9 <=y0_real;register_imag9 <=y0_imag;
                     register_real13<=y1_real;register_imag13<=y1_imag;
                     i<=i+1;
                  end
            20'd88:#3 begin i<=i+1; end
//********************************************************************************************
//**********butterfly_no_3_6***********************************************************************
            20'd89: begin
                      butt2_real0<=register_real10;butt2_imag0<=register_imag10;
                      butt2_real1<=register_real14;butt2_imag1<=register_imag14;
                      factor_real<=factor_real4;factor_imag<=factor_imag4;
                      i<=i+1;
                  end
            20'd90:#26 begin i<=i+1; end
            20'd91:begin
                     register_real10<=y0_real;register_imag10<=y0_imag;
                     register_real14<=y1_real;register_imag14<=y1_imag;
                     i<=i+1;
                  end
            20'd92:#3 begin i<=i+1; end
//********************************************************************************************
//**********butterfly_no_3_7***********************************************************************
            20'd93: begin
                      butt2_real0<=register_real11;butt2_imag0<=register_imag11;
                      butt2_real1<=register_real15;butt2_imag1<=register_imag15;
                      factor_real<=factor_real6;factor_imag<=factor_imag6;
                      i<=i+1;
                  end
            20'd94:#26 begin i<=i+1; end
            20'd95:begin
                     register_real11<=y0_real;register_imag11<=y0_imag;
                     register_real15<=y1_real;register_imag15<=y1_imag;
                     i<=i+1;
                  end
            20'd96:#3 begin i<=i+1; end
//******************************************************************************************** 






















/***第四级fft***/
//**********butterfly_no_4_0***********************************************************************
            20'd97: begin
                      butt2_real0<=register_real0;butt2_imag0<=register_imag0;
                      butt2_real1<=register_real8;butt2_imag1<=register_imag8;
                      factor_real<=factor_real0;factor_imag<=factor_imag0;
                      i<=i+1;
                  end
            20'd98:#26 begin i<=i+1; end
            20'd99:begin
                     register_real0<=y0_real;register_imag0<=y0_imag;
                     register_real8<=y1_real;register_imag8<=y1_imag;
                     i<=i+1;
                  end
            20'd100:#3 begin i<=i+1; end
//********************************************************************************************
//**********butterfly_no_4_1***********************************************************************
            20'd101: begin
                      butt2_real0<=register_real1;butt2_imag0<=register_imag1;
                      butt2_real1<=register_real9;butt2_imag1<=register_imag9;
                      factor_real<=factor_real1;factor_imag<=factor_imag1;
                      i<=i+1;
                  end
            20'd102:#26 begin i<=i+1; end
            20'd103:begin
                     register_real1<=y0_real;register_imag1<=y0_imag;
                     register_real9<=y1_real;register_imag9<=y1_imag;
                     i<=i+1;
                  end
            20'd104:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_4_2***********************************************************************
            20'd105: begin
                      butt2_real0<=register_real2 ;butt2_imag0<=register_imag2 ;
                      butt2_real1<=register_real10;butt2_imag1<=register_imag10;
                      factor_real<=factor_real2;factor_imag<=factor_imag2;
                      i<=i+1;
                  end
            20'd106:#26 begin i<=i+1; end
            20'd107:begin
                     register_real2 <=y0_real;register_imag2 <=y0_imag;
                     register_real10<=y1_real;register_imag10<=y1_imag;
                     i<=i+1;
                  end
            20'd108:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_4_3***********************************************************************
            20'd109: begin
                      butt2_real0<=register_real3 ;butt2_imag0<=register_imag3 ;
                      butt2_real1<=register_real11;butt2_imag1<=register_imag11;
                      factor_real<=factor_real3;factor_imag<=factor_imag3;
                      i<=i+1;
                  end
            20'd110:#26 begin i<=i+1; end
            20'd111:begin
                     register_real3 <=y0_real;register_imag3 <=y0_imag;
                     register_real11<=y1_real;register_imag11<=y1_imag;
                     i<=i+1;
                  end
            20'd112:#3 begin i<=i+1; end
//********************************************************************************************
//**********butterfly_no_4_4***********************************************************************
            20'd113: begin
                      butt2_real0<=register_real4 ;butt2_imag0<=register_imag4 ;
                      butt2_real1<=register_real12;butt2_imag1<=register_imag12;
                      factor_real<=factor_real4;factor_imag<=factor_imag4;
                      i<=i+1;
                  end
            20'd114:#26 begin i<=i+1; end
            20'd115:begin
                     register_real4 <=y0_real;register_imag4 <=y0_imag;
                     register_real12<=y1_real;register_imag12<=y1_imag;
                     i<=i+1;
                  end
            20'd116:#3 begin i<=i+1; end
//********************************************************************************************
//**********butterfly_no_4_5***********************************************************************
            20'd117: begin
                      butt2_real0<=register_real5 ;butt2_imag0<=register_imag5 ;
                      butt2_real1<=register_real13;butt2_imag1<=register_imag13;
                      factor_real<=factor_real5;factor_imag<=factor_imag5;
                      i<=i+1;
                  end
            20'd118:#26 begin i<=i+1; end
            20'd119:begin
                     register_real5 <=y0_real;register_imag5 <=y0_imag;
                     register_real13<=y1_real;register_imag13<=y1_imag;
                     i<=i+1;
                  end
            20'd120:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_4_6***********************************************************************
            20'd121: begin
                      butt2_real0<=register_real6 ;butt2_imag0<=register_imag6 ;
                      butt2_real1<=register_real14;butt2_imag1<=register_imag14;
                      factor_real<=factor_real6;factor_imag<=factor_imag6;
                      i<=i+1;
                  end
            20'd122:#26 begin i<=i+1; end
            20'd123:begin
                     register_real6 <=y0_real;register_imag6 <=y0_imag;
                     register_real14<=y1_real;register_imag14<=y1_imag;
                     i<=i+1;
                  end
            20'd124:#3 begin i<=i+1; end
//********************************************************************************************

//**********butterfly_no_4_7***********************************************************************
            20'd125: begin
                      butt2_real0<=register_real7 ;butt2_imag0<=register_imag7 ;
                      butt2_real1<=register_real15;butt2_imag1<=register_imag15;
                      factor_real<=factor_real7;factor_imag<=factor_imag7;
                      i<=i+1;
                  end
            20'd126:#26 begin i<=i+1; end
            20'd127:begin
                     register_real7 <=y0_real;register_imag7 <=y0_imag;
                     register_real15<=y1_real;register_imag15<=y1_imag;
                     i<=i+1;
                  end
            20'd128:#3 begin i<=i+1; end
//********************************************************************************************














            20'd129:
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
           20'd130:
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