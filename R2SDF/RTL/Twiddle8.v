//----------------------------------------------------------------------
//  Twiddle: 8-Point Twiddle Table for Radix-2^2 Butterfly
//----------------------------------------------------------------------
`include "define.v"
module Twiddle8 #(
    parameter   TW_FF = 1
)(
    input                           clk     ,
    input   [`C2LOG_FFT_POINTS-1:0] addr    ,
    output  [`DATA_IN_WIDTH-1:0]    tw_re   ,
    output  [`DATA_IN_WIDTH-1:0]    tw_im    
);

wire[`DATA_IN_WIDTH-1:0]  wn_re[0:`FFT_POINTS-1];    //  Twiddle Table (Real)
wire[`DATA_IN_WIDTH-1:0]  wn_im[0:`FFT_POINTS-1];    //  Twiddle Table (Imag)
wire[`DATA_IN_WIDTH-1:0]  mx_re;          //  Multiplexer output (Real)
wire[`DATA_IN_WIDTH-1:0]  mx_im;          //  Multiplexer output (Imag)
reg [`DATA_IN_WIDTH-1:0]  ff_re;          //  Register output (Real)
reg [`DATA_IN_WIDTH-1:0]  ff_im;          //  Register output (Imag)

assign  mx_re = wn_re[addr];
assign  mx_im = wn_im[addr];

always @(posedge clk) begin
    ff_re <= mx_re;
    ff_im <= mx_im;
end

assign  tw_re = TW_FF ? ff_re : mx_re;
assign  tw_im = TW_FF ? ff_im : mx_im;

/********Twiddle Factor Value*********/
// wn_re = cos(-2pi*n/8) wn_im = sin(-2pi*n/8)
assign  wn_re[0] = 16'h7FFF;   assign  wn_im[0] = 16'h0000;   //  1.000 -0.000
assign  wn_re[1] = 16'h5A82;   assign  wn_im[1] = 16'hA57E;   //  0.707 -0.707
assign  wn_re[2] = 16'h0000;   assign  wn_im[2] = 16'h8000;   //  0.000 -1.000
assign  wn_re[3] = 16'hA57E;   assign  wn_im[3] = 16'hA57E;   // -0.707 -0.707
assign  wn_re[4] = 16'hxxxx;   assign  wn_im[4] = 16'hxxxx;   // -1.000 -0.000 //8点FFT 用不上
assign  wn_re[5] = 16'hxxxx;   assign  wn_im[5] = 16'hxxxx;   // -0.707  0.707 //8点FFT 用不上
assign  wn_re[6] = 16'hxxxx;   assign  wn_im[6] = 16'hxxxx;   // -0.000  1.000 //8点FFT 用不上
assign  wn_re[7] = 16'hxxxx;   assign  wn_im[7] = 16'hxxxx;   //  0.707  0.707 //8点FFT 用不上

endmodule
