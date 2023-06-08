//----------------------------------------------------------------------
//  SdfUnit2: Radix-2 SDF Dedicated for Twiddle Resolution M = 2
//----------------------------------------------------------------------
`include "define.v"
module SdfUnit2 #(
    parameter   DELAY_DEPTH = 1
)(
    input   wire                            clk     ,  //  Master Clock
    input   wire                            select  ,  //  R2SDF MUX SELECT
    input   wire    [`DATA_IN_WIDTH-1:0]    di_re   ,  //  Input Data (Real)
    input   wire    [`DATA_IN_WIDTH-1:0]    di_im   ,  //  Input Data (Imag)
    output  wire    [`DATA_IN_WIDTH-1:0]    do_re   ,  //  Output Data (Real)
    output  wire    [`DATA_IN_WIDTH-1:0]    do_im      //  Output Data (Imag)
);
wire                        do_en   ;   //  Output Data Enable
//----------------------------------------------------------------------
//  Internal Regs and Nets
//----------------------------------------------------------------------
wire[`DATA_IN_WIDTH-1:0]    x0_re   ;   //  Data #0 to Butterfly (Real)
wire[`DATA_IN_WIDTH-1:0]    x0_im   ;   //  Data #0 to Butterfly (Imag)
wire[`DATA_IN_WIDTH-1:0]    x1_re   ;   //  Data #1 to Butterfly (Real)
wire[`DATA_IN_WIDTH-1:0]    x1_im   ;   //  Data #1 to Butterfly (Imag)
wire[`DATA_IN_WIDTH-1:0]    y0_re   ;   //  Data #0 from Butterfly (Real)
wire[`DATA_IN_WIDTH-1:0]    y0_im   ;   //  Data #0 from Butterfly (Imag)
wire[`DATA_IN_WIDTH-1:0]    y1_re   ;   //  Data #1 from Butterfly (Real)
wire[`DATA_IN_WIDTH-1:0]    y1_im   ;   //  Data #1 from Butterfly (Imag)
wire[`DATA_IN_WIDTH-1:0]    db_di_re;   //  Data to DelayBuffer (Real)
wire[`DATA_IN_WIDTH-1:0]    db_di_im;   //  Data to DelayBuffer (Imag)
wire[`DATA_IN_WIDTH-1:0]    db_do_re;   //  Data from DelayBuffer (Real)
wire[`DATA_IN_WIDTH-1:0]    db_do_im;   //  Data from DelayBuffer (Imag)
wire[`DATA_IN_WIDTH-1:0]    bf_sp_re;   //  Single-Path Data Output (Real)
wire[`DATA_IN_WIDTH-1:0]    bf_sp_im;   //  Single-Path Data Output (Imag)

//----------------------------------------------------------------------
//  Butterfly Add/Sub
//----------------------------------------------------------------------
assign  x1_re = db_do_re    ;
assign  x1_im = db_do_im    ;
assign  x0_re = di_re       ;
assign  x0_im = di_im       ;

Butterfly BF (
    .x0_re  (x0_re  ),  //  i
    .x0_im  (x0_im  ),  //  i
    .x1_re  (x1_re  ),  //  i
    .x1_im  (x1_im  ),  //  i
    .y0_re  (y0_re  ),  //  o +
    .y0_im  (y0_im  ),  //  o +
    .y1_re  (y1_re  ),  //  o -
    .y1_im  (y1_im  )   //  o -
);

DelayBuffer #(.DELAY_DEPTH(DELAY_DEPTH)) DB (
    .clk    (clk        ),  //  i
    .di_re  (db_di_re   ),  //  i
    .di_im  (db_di_im   ),  //  i
    .do_re  (db_do_re   ),  //  o
    .do_im  (db_do_im   )   //  o
);

assign  db_di_re = select    ? y1_re : x0_re;
assign  db_di_im = select    ? y1_im : x0_im;
assign  bf_sp_re = select    ? y0_re : x1_re;
assign  bf_sp_im = select    ? y0_im : x1_im;

//输出信号赋值
// assign  do_en = bf_sp_en;

assign  do_re = bf_sp_re;
assign  do_im = bf_sp_im;

endmodule
