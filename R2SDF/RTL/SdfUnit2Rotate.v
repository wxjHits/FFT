//----------------------------------------------------------------------
//  SdfUnit2: Radix-2 SDF Dedicated for Twiddle Resolution M = 2
//----------------------------------------------------------------------
`include "define.v"
module SdfUnit2Rotate #(
    parameter   DELAY_DEPTH = 1,
    parameter   FFT_STAGE   = 1 //处于第几级FFT运算的SDF
)(
    input   wire                            clk     ,
    input   wire                            rstn    ,
    input   wire                            di_en   ,
    input   wire    [`DATA_IN_WIDTH-1:0]    di_re   ,
    input   wire    [`DATA_IN_WIDTH-1:0]    di_im   ,
    output  wire                            do_en   ,
    output  wire    [`DATA_IN_WIDTH-1:0]    do_re   ,
    output  wire    [`DATA_IN_WIDTH-1:0]    do_im    
);

/**********cnt的处理***********/
reg di_en_delay_ram [0:DELAY_DEPTH-1];
integer n;
always @(posedge clk) begin
    for (n = DELAY_DEPTH-1; n > 0; n = n - 1) begin
        di_en_delay_ram[n] <= di_en_delay_ram[n-1];
    end
    di_en_delay_ram[0] <= di_en;
end
assign  do_en = di_en_delay_ram[DELAY_DEPTH-1];

reg    [`C2LOG_FFT_POINTS-FFT_STAGE:0] cnt     ;//FFT输入点数计数器，上限为FFT点数
always@(posedge clk or negedge rstn)begin
    if(~rstn)
        cnt<=0;
    else
        cnt<= di_en ? (cnt+1'b1):0;
end

wire select = di_en & cnt[`C2LOG_FFT_POINTS-FFT_STAGE];

/***********在 select==0 情况下对旋转因子表进行索引************/
wire select_not = ~select;
reg [`C2LOG_FFT_POINTS-1:0] tw_cnt;
always@(posedge clk or negedge rstn)begin
    if(~rstn)
        tw_cnt<=0;
    else
        tw_cnt<=select_not ? tw_cnt+1'b1 : 0;
end
wire [`C2LOG_FFT_POINTS-1:0] tw_addr;
assign tw_addr = select_not ? tw_cnt<<(FFT_STAGE-1):0;

/*********信号声明********/
wire [`DATA_IN_WIDTH-1:0] tw_re;
wire [`DATA_IN_WIDTH-1:0] tw_im;

wire [`DATA_IN_WIDTH-1:0] sdfUints_in_re;
wire [`DATA_IN_WIDTH-1:0] sdfUints_in_im;
wire [`DATA_IN_WIDTH-1:0] sdfUints_out_re;
wire [`DATA_IN_WIDTH-1:0] sdfUints_out_im;

wire [`DATA_IN_WIDTH-1:0] multi_out_re;
wire [`DATA_IN_WIDTH-1:0] multi_out_im;

assign sdfUints_in_re = di_en ? di_re:{`DATA_IN_WIDTH{1'b0}};
assign sdfUints_in_im = di_en ? di_im:{`DATA_IN_WIDTH{1'b0}};

/**************/
SdfUnit2 #(
    .DELAY_DEPTH (DELAY_DEPTH)
)u_SdfUnit2(
    .clk    (clk                ),
    .select (select             ),
    .di_re  (sdfUints_in_re     ),
    .di_im  (sdfUints_in_im     ),
    .do_re  (sdfUints_out_re    ),
    .do_im  (sdfUints_out_im    ) 
);

/**************/
Multiply u_Multiply(
    .a_re(sdfUints_out_re   ),
    .a_im(sdfUints_out_im   ),
    .b_re(tw_re             ),
    .b_im(tw_im             ),
    .m_re(multi_out_re      ),
    .m_im(multi_out_im      )
);

/**************/
Twiddle #(
    .TW_FF(0)
)u_Twiddle(
    .clk    (clk    ),
    .addr   (tw_addr),
    .tw_re  (tw_re  ),
    .tw_im  (tw_im  ) 
);

/******输出结果赋值*****/
assign do_re = multi_out_re;
assign do_im = multi_out_im;

endmodule
