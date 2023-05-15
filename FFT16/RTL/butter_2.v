`timescale 1ns/100ps
module butter_2  ( 
                 clk,
                 rst,
                 butt2_real0,
                 butt2_imag0,
                 butt2_real1,
                 butt2_imag1,
                 factor_real,
                 factor_imag,
                 y0_real,
                 y0_imag,
                 y1_real,
                 y1_imag
                 );

parameter RST_LVL = 1'b0;
  
input clk;
input rst;
input [23:0] butt2_real0;
input [23:0] butt2_imag0;
input [23:0] butt2_real1;
input [23:0] butt2_imag1;
input [31:0] factor_real;
input [31:0] factor_imag;
output [23:0] y0_real;
output [23:0] y0_imag;
output [23:0] y1_real;
output [23:0] y1_imag;

wire [54:0] mult_real0;
wire [54:0] mult_real1;
wire [54:0] mult_imag0;
wire [54:0] mult_imag1;
wire [54:0] result_real0;
wire [54:0] result_real1;
wire [54:0] result_imag0;
wire [54:0] result_imag1;
reg [54:0] result_real0_next;
reg [54:0] result_imag0_next;
reg [54:0] result_real1_next;
reg [54:0] result_imag1_next;
wire [54:0] adder_real0;
wire [54:0] adder_imag0;
reg [54:0] adder_real0_next [10:0];
reg [54:0] adder_imag0_next [10:0];
wire [54:0] adder_real1;
wire [54:0] adder_imag1;
reg [54:0] adder_real1_next;
reg [54:0] adder_imag1_next;
wire [54:0] y0_result_real;
wire [54:0] y0_result_imag;
wire [54:0] y1_result_real;
wire [54:0] y1_result_imag;
reg [54:0] y0_result_real_next;
reg [54:0] y0_result_imag_next;
reg [54:0] y1_result_real_next;
reg [54:0] y1_result_imag_next;
wire [23:0] output0_real;
wire [23:0] output0_imag;
wire [23:0] output1_real;
wire [23:0] output1_imag;
reg [23:0] output0_real_next;
reg [23:0] output0_imag_next;
reg [23:0] output1_real_next;
reg [23:0] output1_imag_next;

/*复数的乘法*/
mult32_24 U_mult_real0 (
           .clk     (clk        ),
           .rst     (rst        ),
           .mult_a  (factor_real),
           .mult_b  (butt2_real1),
           .mult_out(mult_real0 )
                      );
mult32_24 U_mult_real1 ( 
           .clk     (clk        ),
           .rst     (rst        ),
           .mult_a  (factor_imag),
           .mult_b  (butt2_imag1),
           .mult_out(mult_real1 )
                      );
mult32_24 U_mult_imag0 (
           .clk     (clk        ),
           .rst     (rst        ),
           .mult_a  (factor_imag),
           .mult_b  (butt2_real1),
           .mult_out(mult_imag0 )
                      );                                           
mult32_24 U_mult_imag1 (
           .clk     (clk        ),
           .rst     (rst        ),
           .mult_a  (factor_real),
           .mult_b  (butt2_imag1),
           .mult_out(mult_imag1 )
                      );
                      
assign result_real0 = (mult_real0 == 55'b0)? 55'b0 : 
             (mult_real0[54])? {13'b1111111111111,mult_real0[54:13]} : {13'b0,mult_real0[54:13]};  
assign result_real1 = (mult_real1 == 55'b0)? 55'b0 : 
             (mult_real1[54])? {13'b1111111111111,mult_real1[54:13]} : {13'b0,mult_real1[54:13]}; 
assign result_imag0 = (mult_imag0 == 55'b0)? 55'b0 : 
             (mult_imag0[54])? {13'b1111111111111,mult_imag0[54:13]} : {13'b0,mult_imag0[54:13]};
assign result_imag1 = (mult_imag1 == 55'b0)? 55'b0 : 
             (mult_imag1[54])? {13'b1111111111111,mult_imag1[54:13]} : {13'b0,mult_imag1[54:13]};  

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    result_real0_next <= 55'b0;
    result_imag0_next <= 55'b0;
    result_real1_next <= 55'b0;
    result_imag1_next <= 55'b0;
  end
  else begin
    result_real0_next <= result_real0;
    result_imag0_next <= result_imag0;
    result_real1_next <= result_real1;
    result_imag1_next <= result_imag1;
  end
end
                 
assign adder_real1 = result_real0_next - result_real1_next;
assign adder_imag1 = result_imag0_next + result_imag1_next; 

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    adder_real1_next <= 55'b0;
    adder_imag1_next <= 55'b0;  
  end
  else begin
    adder_real1_next <= adder_real1;
    adder_imag1_next <= adder_imag1;
  end
end

assign adder_real0 = (butt2_real0 == 24'b0)? 55'b0 : 
            (butt2_real0[23])? {31'b1111111111111111111111111111111,butt2_real0} : {31'b0,butt2_real0};
assign adder_imag0 = (butt2_imag0 == 24'b0)? 55'b0 : 
            (butt2_imag0[23])? {31'b1111111111111111111111111111111,butt2_imag0} : {31'b0,butt2_imag0};

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    adder_real0_next[0] <= 55'b0;
    adder_imag0_next[0] <= 55'b0;
    adder_real0_next[1] <= 55'b0;
    adder_imag0_next[1] <= 55'b0;
    adder_real0_next[2] <= 55'b0;
    adder_imag0_next[2] <= 55'b0;
    adder_real0_next[3] <= 55'b0;
    adder_imag0_next[3] <= 55'b0;
    adder_real0_next[4] <= 55'b0;
    adder_imag0_next[4] <= 55'b0;
    adder_real0_next[5] <= 55'b0;
    adder_imag0_next[5] <= 55'b0;
    adder_real0_next[6] <= 55'b0;
    adder_imag0_next[6] <= 55'b0;
    adder_real0_next[7] <= 55'b0;
    adder_imag0_next[7] <= 55'b0;
    adder_real0_next[8] <= 55'b0;
    adder_imag0_next[8] <= 55'b0;
    adder_real0_next[9] <= 55'b0;
    adder_imag0_next[9] <= 55'b0;
    adder_real0_next[10] <= 55'b0;
    adder_imag0_next[10] <= 55'b0;      
  end
  else begin
    adder_real0_next[0] <= adder_real0;
    adder_imag0_next[0] <= adder_imag0;
    adder_real0_next[1] <= adder_real0_next[0];
    adder_imag0_next[1] <= adder_imag0_next[0];
    adder_real0_next[2] <= adder_real0_next[1];
    adder_imag0_next[2] <= adder_imag0_next[1];
    adder_real0_next[3] <= adder_real0_next[2];
    adder_imag0_next[3] <= adder_imag0_next[2];
    adder_real0_next[4] <= adder_real0_next[3];
    adder_imag0_next[4] <= adder_imag0_next[3];
    adder_real0_next[5] <= adder_real0_next[4];
    adder_imag0_next[5] <= adder_imag0_next[4];
    adder_real0_next[6] <= adder_real0_next[5];
    adder_imag0_next[6] <= adder_imag0_next[5];
    adder_real0_next[7] <= adder_real0_next[6];
    adder_imag0_next[7] <= adder_imag0_next[6];
    adder_real0_next[8] <= adder_real0_next[7];
    adder_imag0_next[8] <= adder_imag0_next[7];
    adder_real0_next[9] <= adder_real0_next[8];
    adder_imag0_next[9] <= adder_imag0_next[8];
    adder_real0_next[10] <= adder_real0_next[9];
    adder_imag0_next[10] <= adder_imag0_next[9];    
  end
end

assign y0_result_real = adder_real0_next[10] + adder_real1_next;
assign y0_result_imag = adder_imag0_next[10] + adder_imag1_next;
assign y1_result_real = adder_real0_next[10] - adder_real1_next;
assign y1_result_imag = adder_imag0_next[10] - adder_imag1_next;

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    y0_result_real_next <= 55'b0;
    y0_result_imag_next <= 55'b0;
    y1_result_real_next <= 55'b0;
    y1_result_imag_next <= 55'b0;  
  end
  else begin
    y0_result_real_next <= y0_result_real;
    y0_result_imag_next <= y0_result_imag;
    y1_result_real_next <= y1_result_real;
    y1_result_imag_next <= y1_result_imag;
  end 
end

assign output0_real = (y0_result_real == 54'b0)? 24'b0 : 
                   {y0_result_real_next[54],y0_result_real_next[22:0]};
assign output0_imag = (y0_result_imag == 54'b0)? 24'b0 : 
                   {y0_result_imag_next[54],y0_result_imag_next[22:0]};
assign output1_real = (y1_result_real == 54'b0)? 24'b0 : 
                   {y1_result_real_next[54],y1_result_real_next[22:0]};
assign output1_imag = (y1_result_imag == 54'b0)? 24'b0 : 
                   {y1_result_imag_next[54],y1_result_imag_next[22:0]};

always @(posedge clk or negedge rst) begin
  if (rst == RST_LVL) begin
    output0_real_next <= 24'b0;
    output0_imag_next <= 24'b0;
    output1_real_next <= 24'b0;
    output1_imag_next <= 24'b0;  
  end
  else begin
    output0_real_next <= output0_real;
    output0_imag_next <= output0_imag;
    output1_real_next <= output1_real;
    output1_imag_next <= output1_imag;    
  end
end

assign y0_real = output0_real_next;
assign y0_imag = output0_imag_next;
assign y1_real = output1_real_next;
assign y1_imag = output1_imag_next;
 
endmodule

 