//----------------------------------------------------------------------
//  Twiddle: 8-Point Twiddle Table for Radix-2^2 Butterfly
//----------------------------------------------------------------------
`include "define.v"
module Twiddle #(
    parameter   TW_FF = 1
)(
    input                           clk     ,
    input   [`C2LOG_FFT_POINTS-1:0] addr    ,
    output  [`DATA_IN_WIDTH-1:0]    tw_re   ,
    output  [`DATA_IN_WIDTH-1:0]    tw_im    
);

reg [`DATA_IN_WIDTH-1:0]  wn_re[0:`FFT_POINTS-1];    //  Twiddle Table (Real)
reg [`DATA_IN_WIDTH-1:0]  wn_im[0:`FFT_POINTS-1];    //  Twiddle Table (Imag)
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
initial begin
    $readmemh("C:/Users/hp/Desktop/FFT/R2SDF/matlab/tw_real.txt",wn_re);
    $readmemh("C:/Users/hp/Desktop/FFT/R2SDF/matlab/tw_img.txt",wn_im);
end
endmodule
