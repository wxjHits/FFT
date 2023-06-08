//----------------------------------------------------------------------
//  Butterfly: Add/Sub and Scaling
//----------------------------------------------------------------------
`include "define.v"
module Butterfly (
    input   signed  [`DATA_IN_WIDTH-1:0] x0_re,  //  Input Data #0 (Real)
    input   signed  [`DATA_IN_WIDTH-1:0] x0_im,  //  Input Data #0 (Imag)
    input   signed  [`DATA_IN_WIDTH-1:0] x1_re,  //  Input Data #1 (Real)
    input   signed  [`DATA_IN_WIDTH-1:0] x1_im,  //  Input Data #1 (Imag)
    output  signed  [`DATA_IN_WIDTH-1:0] y0_re,  //  Output Data #0 (Real)
    output  signed  [`DATA_IN_WIDTH-1:0] y0_im,  //  Output Data #0 (Imag)
    output  signed  [`DATA_IN_WIDTH-1:0] y1_re,  //  Output Data #1 (Real)
    output  signed  [`DATA_IN_WIDTH-1:0] y1_im   //  Output Data #1 (Imag)
);

wire signed [`DATA_IN_WIDTH:0]   add_re, add_im, sub_re, sub_im;

//  Add/Sub
assign  add_re = x0_re + x1_re;
assign  add_im = x0_im + x1_im;
assign  sub_re = x1_re - x0_re;
assign  sub_im = x1_im - x0_im;

//  Scaling
assign  y0_re = (add_re) >>> 1;
assign  y0_im = (add_im) >>> 1;
assign  y1_re = (sub_re) >>> 1;
assign  y1_im = (sub_im) >>> 1;

// assign  y0_re = (add_re) ;
// assign  y0_im = (add_im) ;
// assign  y1_re = (sub_re) ;
// assign  y1_im = (sub_im) ;

endmodule
