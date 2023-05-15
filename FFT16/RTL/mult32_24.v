`timescale 1ns/100ps
/*
  是一个采用移位累加式实现的乘法器，mult_a*mult_b
  部分积采用加法树的方式，目前是8个时钟周期输出结果
*/

module mult32_24 (clk,rst,mult_a,mult_b,mult_out);

parameter RST_LVL = 1'b0;

input clk;
input rst;
input [31:0] mult_a;
input [23:0] mult_b;  
output [54:0] mult_out;

wire msb0;
wire [30:0] mult_a_unsigned;
wire [22:0] mult_b_unsigned;
reg msb_next0;
reg [30:0] mult_a_next;
reg [22:0] mult_b_next;
wire msb1;
wire [52:0] mult_store0;
wire [52:0] mult_store1;
wire [52:0] mult_store2;
wire [52:0] mult_store3;
wire [52:0] mult_store4;
wire [52:0] mult_store5;
wire [52:0] mult_store6;
wire [52:0] mult_store7;
wire [52:0] mult_store8;
wire [52:0] mult_store9;
wire [52:0] mult_store10;
wire [52:0] mult_store11;
wire [52:0] mult_store12;
wire [52:0] mult_store13;
wire [52:0] mult_store14;
wire [52:0] mult_store15;
wire [52:0] mult_store16;
wire [52:0] mult_store17;
wire [52:0] mult_store18;
wire [52:0] mult_store19;
wire [52:0] mult_store20;
wire [52:0] mult_store21;
wire [52:0] mult_store22;
reg msb_next1;
reg [52:0] adder_next0 [22:0];
wire msb2;
wire [53:0] sum_fir0;
wire [53:0] sum_fir1;
wire [53:0] sum_fir2;
wire [53:0] sum_fir3;
wire [53:0] sum_fir4;
wire [53:0] sum_fir5;
wire [53:0] sum_fir6;
wire [53:0] sum_fir7; 
wire [53:0] sum_fir8;
wire [53:0] sum_fir9;
wire [53:0] sum_fir10;
wire [53:0] sum_fir11;
reg msb_next2;
reg [53:0] adder_next1 [11:0];
wire msb3;
wire [53:0] sum_sec0;
wire [53:0] sum_sec1;
wire [53:0] sum_sec2;
wire [53:0] sum_sec3;
wire [53:0] sum_sec4;
wire [53:0] sum_sec5;
reg msb_next3;
reg [53:0] adder_next2 [5:0];
wire msb4;
wire [53:0] sum_tri0;
wire [53:0] sum_tri1;
wire [53:0] sum_tri2;
reg msb_next4;
reg [53:0] adder_next3 [2:0];
wire msb5;
wire [53:0] sum_for0;
wire [53:0] sum_for1;
reg msb_next5;
reg [53:0] adder_next4 [1:0];
wire msb6;
wire [53:0] sum_fiv;
reg msb_next6;
reg [53:0] adder_next5;
wire msb7;
wire [53:0] result_unsigned;
reg msb_next7;
reg [53:0] result_next;
wire [23:0] result_out;
reg [23:0] result_next0;

assign msb0 = mult_a[31] ^ mult_b[23];
assign mult_a_unsigned = (mult_a[31])? (~mult_a[30:0] + 1'b1) : mult_a[30:0];  
assign mult_b_unsigned = (mult_b[23])? (~mult_b[22:0] + 1'b1) : mult_b[22:0];

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    msb_next0 <= 1'b0;
    mult_a_next <= 31'b0;
    mult_b_next <= 23'b0;
  end
  else begin
    msb_next0 <= msb0;
    mult_a_next <= mult_a_unsigned;
    mult_b_next <= mult_b_unsigned; 
  end
end

assign msb1 = msb_next0;
assign mult_store0  = (mult_b_next[0 ])? {22'b0,mult_a_next} : 53'b0;
assign mult_store1  = (mult_b_next[1 ])? {21'b0,mult_a_next, 1'b0} : 53'b0;
assign mult_store2  = (mult_b_next[2 ])? {20'b0,mult_a_next, 2'b0} : 53'b0;
assign mult_store3  = (mult_b_next[3 ])? {19'b0,mult_a_next, 3'b0} : 53'b0;
assign mult_store4  = (mult_b_next[4 ])? {18'b0,mult_a_next, 4'b0} : 53'b0;
assign mult_store5  = (mult_b_next[5 ])? {17'b0,mult_a_next, 5'b0} : 53'b0;
assign mult_store6  = (mult_b_next[6 ])? {16'b0,mult_a_next, 6'b0} : 53'b0;
assign mult_store7  = (mult_b_next[7 ])? {15'b0,mult_a_next, 7'b0} : 53'b0;
assign mult_store8  = (mult_b_next[8 ])? {14'b0,mult_a_next, 8'b0} : 53'b0;
assign mult_store9  = (mult_b_next[9 ])? {13'b0,mult_a_next, 9'b0} : 53'b0;
assign mult_store10 = (mult_b_next[10])? {12'b0,mult_a_next,10'b0} : 53'b0;
assign mult_store11 = (mult_b_next[11])? {11'b0,mult_a_next,11'b0} : 53'b0;
assign mult_store12 = (mult_b_next[12])? {10'b0,mult_a_next,12'b0} : 53'b0;
assign mult_store13 = (mult_b_next[13])? { 9'b0,mult_a_next,13'b0} : 53'b0;
assign mult_store14 = (mult_b_next[14])? { 8'b0,mult_a_next,14'b0} : 53'b0;
assign mult_store15 = (mult_b_next[15])? { 7'b0,mult_a_next,15'b0} : 53'b0;
assign mult_store16 = (mult_b_next[16])? { 6'b0,mult_a_next,16'b0} : 53'b0;
assign mult_store17 = (mult_b_next[17])? { 5'b0,mult_a_next,17'b0} : 53'b0;
assign mult_store18 = (mult_b_next[18])? { 4'b0,mult_a_next,18'b0} : 53'b0;
assign mult_store19 = (mult_b_next[19])? { 3'b0,mult_a_next,19'b0} : 53'b0;
assign mult_store20 = (mult_b_next[20])? { 2'b0,mult_a_next,20'b0} : 53'b0;
assign mult_store21 = (mult_b_next[21])? { 1'b0,mult_a_next,21'b0} : 53'b0;
assign mult_store22 = (mult_b_next[22])? {mult_a_next,22'b0} : 53'b0;

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    msb_next1 <= 1'b0;
    adder_next0[ 0] <= 53'b0;
    adder_next0[ 1] <= 53'b0;  
    adder_next0[ 2] <= 53'b0;
    adder_next0[ 3] <= 53'b0;  
    adder_next0[ 4] <= 53'b0;
    adder_next0[ 5] <= 53'b0;  
    adder_next0[ 6] <= 53'b0;
    adder_next0[ 7] <= 53'b0;   
    adder_next0[ 8] <= 53'b0;
    adder_next0[ 9] <= 53'b0;  
    adder_next0[10] <= 53'b0;
    adder_next0[11] <= 53'b0;  
    adder_next0[12] <= 53'b0;
    adder_next0[13] <= 53'b0;  
    adder_next0[14] <= 53'b0;
    adder_next0[15] <= 53'b0; 
    adder_next0[16] <= 53'b0;
    adder_next0[17] <= 53'b0;  
    adder_next0[18] <= 53'b0;
    adder_next0[19] <= 53'b0;  
    adder_next0[20] <= 53'b0;
    adder_next0[21] <= 53'b0;  
    adder_next0[22] <= 53'b0;              
  end
  else begin
    msb_next1 <= msb1;
    adder_next0[0] <= mult_store0;
    adder_next0[ 1] <= mult_store1;  
    adder_next0[ 2] <= mult_store2;
    adder_next0[ 3] <= mult_store3;  
    adder_next0[ 4] <= mult_store4;
    adder_next0[ 5] <= mult_store5;  
    adder_next0[ 6] <= mult_store6;
    adder_next0[ 7] <= mult_store7;   
    adder_next0[ 8] <= mult_store8;
    adder_next0[ 9] <= mult_store9;  
    adder_next0[10] <= mult_store10;
    adder_next0[11] <= mult_store11;  
    adder_next0[12] <= mult_store12;
    adder_next0[13] <= mult_store13;  
    adder_next0[14] <= mult_store14;
    adder_next0[15] <= mult_store15; 
    adder_next0[16] <= mult_store16;
    adder_next0[17] <= mult_store17;  
    adder_next0[18] <= mult_store18;
    adder_next0[19] <= mult_store19;  
    adder_next0[20] <= mult_store20;
    adder_next0[21] <= mult_store21;  
    adder_next0[22] <= mult_store22;                
  end
end

assign msb2 = msb_next1;
assign sum_fir0  = adder_next0[ 0] + adder_next0[ 1];
assign sum_fir1  = adder_next0[ 2] + adder_next0[ 3]; 
assign sum_fir2  = adder_next0[ 4] + adder_next0[ 5];
assign sum_fir3  = adder_next0[ 6] + adder_next0[ 7];
assign sum_fir4  = adder_next0[ 8] + adder_next0[ 9];
assign sum_fir5  = adder_next0[10] + adder_next0[11];
assign sum_fir6  = adder_next0[12] + adder_next0[13];
assign sum_fir7  = adder_next0[14] + adder_next0[15];
assign sum_fir8  = adder_next0[16] + adder_next0[17];
assign sum_fir9  = adder_next0[18] + adder_next0[19];
assign sum_fir10 = adder_next0[20] + adder_next0[21];
assign sum_fir11 = adder_next0[22];

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    msb_next2 <= 1'b0;
    adder_next1[ 0] <= 54'b0;
    adder_next1[ 1] <= 54'b0;
    adder_next1[ 2] <= 54'b0;   
    adder_next1[ 3] <= 54'b0;
    adder_next1[ 4] <= 54'b0;
    adder_next1[ 5] <= 54'b0; 
    adder_next1[ 6] <= 54'b0;
    adder_next1[ 7] <= 54'b0;
    adder_next1[ 8] <= 54'b0;
    adder_next1[ 9] <= 54'b0;
    adder_next1[10] <= 54'b0;
    adder_next1[11] <= 54'b0;                
  end
  else begin
    msb_next2 <= msb2;
    adder_next1[ 0] <= sum_fir0;
    adder_next1[ 1] <= sum_fir1;
    adder_next1[ 2] <= sum_fir2;
    adder_next1[ 3] <= sum_fir3;
    adder_next1[ 4] <= sum_fir4;  
    adder_next1[ 5] <= sum_fir5;
    adder_next1[ 6] <= sum_fir6;
    adder_next1[ 7] <= sum_fir7;
    adder_next1[ 8] <= sum_fir8;
    adder_next1[ 9] <= sum_fir9; 
    adder_next1[10] <= sum_fir10;
    adder_next1[11] <= sum_fir11;                 
  end
end

assign msb3 = msb_next2;
assign sum_sec0 = adder_next1[0] + adder_next1[1];
assign sum_sec1 = adder_next1[2] + adder_next1[3];
assign sum_sec2 = adder_next1[4] + adder_next1[5];
assign sum_sec3 = adder_next1[6] + adder_next1[7];
assign sum_sec4 = adder_next1[8] + adder_next1[9];
assign sum_sec5 = adder_next1[10] + adder_next1[11];

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    msb_next3 <= 1'b0;
    adder_next2[0] <= 54'b0;
    adder_next2[1] <= 54'b0;
    adder_next2[2] <= 54'b0;
    adder_next2[3] <= 54'b0;
    adder_next2[4] <= 54'b0;
    adder_next2[5] <= 54'b0;    
  end
  else begin
    msb_next3 <= msb3;
    adder_next2[0] <= sum_sec0;
    adder_next2[1] <= sum_sec1;
    adder_next2[2] <= sum_sec2;
    adder_next2[3] <= sum_sec3;
    adder_next2[4] <= sum_sec4;
    adder_next2[5] <= sum_sec5;   
  end 
end

assign msb4 = msb_next3;
assign sum_tri0 = adder_next2[0] + adder_next2[1];
assign sum_tri1 = adder_next2[2] + adder_next2[3];
assign sum_tri2 = adder_next2[4] + adder_next2[5];

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    msb_next4 <= 1'b0;
    adder_next3[0] <= 54'b0;
    adder_next3[1] <= 54'b0;
    adder_next3[2] <= 54'b0;  
  end
  else begin
    msb_next4 <= msb4;
    adder_next3[0] <= sum_tri0;
    adder_next3[1] <= sum_tri1;
    adder_next3[2] <= sum_tri2;
  end
end

assign msb5 = msb_next4;
assign sum_for0 = adder_next3[0] + adder_next3[1];
assign sum_for1 = adder_next3[2];

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    msb_next5 <= 1'b0;
    adder_next4[0] <= 54'b0;
    adder_next4[1] <= 54'b0;  
  end
  else begin
    msb_next5 <= msb5;
    adder_next4[0] <= sum_for0;
    adder_next4[1] <= sum_for1;
  end
end

assign msb6 = msb_next5;
assign sum_fiv = adder_next4[0] + adder_next4[1];

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    msb_next6 <= 1'b0;
    adder_next5 <= 54'b0;  
  end
  else begin
    msb_next6 <= msb6;
    adder_next5 <= sum_fiv;  
  end
end

assign msb7 = msb_next6;
assign result_unsigned = (adder_next5 == 54'b0)? 54'b0 : 
                    (msb7)? (~adder_next5 + 1'b1) : adder_next5;
                    
always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    msb_next7 <= 1'b0;
    result_next <= 54'b0;
  end
  else begin
    msb_next7 <= msb7;
    result_next <= result_unsigned;
  end
end                     

assign result_out = (result_next == 54'b0)? 54'b0 : {msb_next7,result_next};

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) result_next0 <= 24'b0;
  else result_next0 <= result_out;
end

assign mult_out = result_next0;
endmodule

 