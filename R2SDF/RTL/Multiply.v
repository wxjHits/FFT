//----------------------------------------------------------------------
//  Multiply: Complex Multiplier
//----------------------------------------------------------------------
`include "define.v"
module Multiply(
    input   signed  [`DATA_IN_WIDTH-1:0] a_re,
    input   signed  [`DATA_IN_WIDTH-1:0] a_im,
    input   signed  [`DATA_IN_WIDTH-1:0] b_re,
    input   signed  [`DATA_IN_WIDTH-1:0] b_im,
    output  signed  [`DATA_IN_WIDTH-1:0] m_re,
    output  signed  [`DATA_IN_WIDTH-1:0] m_im
);

wire signed [`DATA_IN_WIDTH*2-1:0]   arbr, arbi, aibr, aibi;
wire signed [`DATA_IN_WIDTH-1:0]     sc_arbr, sc_arbi, sc_aibr, sc_aibi;

//  Signed Multiplication
assign  arbr = a_re * b_re;
assign  arbi = a_re * b_im;
assign  aibr = a_im * b_re;
assign  aibi = a_im * b_im;

//  Scaling
assign  sc_arbr = arbr >>> (`DATA_IN_WIDTH-1);
assign  sc_arbi = arbi >>> (`DATA_IN_WIDTH-1);
assign  sc_aibr = aibr >>> (`DATA_IN_WIDTH-1);
assign  sc_aibi = aibi >>> (`DATA_IN_WIDTH-1);

//  Sub/Add
//  These sub/add may overflow if unnormalized data is input.
assign  m_re = sc_arbr - sc_aibi;
assign  m_im = sc_arbi + sc_aibr;

endmodule
