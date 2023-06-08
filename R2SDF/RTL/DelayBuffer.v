//----------------------------------------------------------------------
//  DelayBuffer: Generate Constant Delay
//----------------------------------------------------------------------
`include "define.v"
module DelayBuffer #(
    parameter   DELAY_DEPTH = 1
)(
    input               clk,  //  Master Clock
    input   [`DATA_IN_WIDTH-1:0] di_re,  //  Data Input (Real)
    input   [`DATA_IN_WIDTH-1:0] di_im,  //  Data Input (Imag)
    output  [`DATA_IN_WIDTH-1:0] do_re,  //  Data Output (Real)
    output  [`DATA_IN_WIDTH-1:0] do_im   //  Data Output (Imag)
);

reg [`DATA_IN_WIDTH-1:0] buf_re[0:DELAY_DEPTH-1];
reg [`DATA_IN_WIDTH-1:0] buf_im[0:DELAY_DEPTH-1];
integer n;

//  Shift Buffer
always @(posedge clk) begin
    for (n = DELAY_DEPTH-1; n > 0; n = n - 1) begin
        buf_re[n] <= buf_re[n-1];
        buf_im[n] <= buf_im[n-1];
    end
    buf_re[0] <= di_re;
    buf_im[0] <= di_im;
end

assign  do_re = buf_re[DELAY_DEPTH-1];
assign  do_im = buf_im[DELAY_DEPTH-1];

endmodule
