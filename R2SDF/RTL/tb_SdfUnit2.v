`timescale 1ns/1ps
`include "define.v"
module tb_SdfUnit2();

    reg                             clk;
    reg                             reset;
    reg                             select;
    reg     [`DATA_IN_WIDTH-1:0]    di_re;
    reg     [`DATA_IN_WIDTH-1:0]    di_im;
    wire    [`DATA_IN_WIDTH-1:0]    do_re;
    wire    [`DATA_IN_WIDTH-1:0]    do_im;

SdfUnit2 #(
    .DELAY_DEPTH(1)
)u_SdfUnit2(
    .clk(clk),  //  Master Clock
    .select(select),  //  Input Data Enable
    .di_re(di_re),  //  Input Data (Real)
    .di_im(di_im),  //  Input Data (Imag)
    .do_re(do_re),  //  Output Data (Real)
    .do_im(do_im)   //  Output Data (Imag)
);

initial begin
    clk=0;
    reset=1;
    di_re=0;
    di_im=0;
    #20;
    reset=0;
end
always#1 clk=~clk;

always@(posedge clk or posedge reset)begin
    if(reset)begin
        di_re<=0;
        di_im<=0;
    end
    else begin
        di_re<=di_re+1'b1;
        di_im<=di_im;
    end
end

always@(*)begin
    if(reset)
        select=0;
    else if(di_re[0]<1)
        select=0;
    else
        select=1;
end

endmodule