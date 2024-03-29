`include "define.v"
module R2SDF_FFT(
    input   wire                        clk     ,
    input   wire                        rstn    ,
    input   wire                        di_en   ,
    input   wire [`DATA_IN_WIDTH-1:0]   di_re   ,
    input   wire [`DATA_IN_WIDTH-1:0]   di_im   ,

    output  wire                        do_en   ,
    output  wire [`DATA_IN_WIDTH-1:0]   do_re   ,
    output  wire [`DATA_IN_WIDTH-1:0]   do_im    
);

// /****中间信号声明****/
//     wire                            sdf1_do_en   ;
//     wire    [`DATA_IN_WIDTH-1:0]    sdf1_do_re   ;
//     wire    [`DATA_IN_WIDTH-1:0]    sdf1_do_im   ;

//     wire                            sdf2_do_en   ;
//     wire    [`DATA_IN_WIDTH-1:0]    sdf2_do_re   ;
//     wire    [`DATA_IN_WIDTH-1:0]    sdf2_do_im   ;

//     wire                            sdf3_do_en   ;
//     wire    [`DATA_IN_WIDTH-1:0]    sdf3_do_re   ;
//     wire    [`DATA_IN_WIDTH-1:0]    sdf3_do_im   ;

//     wire                            sdf4_do_en   ;
//     wire    [`DATA_IN_WIDTH-1:0]    sdf4_do_re   ;
//     wire    [`DATA_IN_WIDTH-1:0]    sdf4_do_im   ;

// /*****第1级 R2SDF****/
// SdfUnit2Rotate #(
//     .DELAY_DEPTH    (8),
//     .FFT_STAGE      (1) 
// )sdf_1st(
//     .clk    (clk        ),
//     .rstn   (rstn       ),
//     .di_en  (di_en      ),
//     .di_re  (di_re      ),
//     .di_im  (di_im      ),
//     .do_en  (sdf1_do_en ),
//     .do_re  (sdf1_do_re ),
//     .do_im  (sdf1_do_im ) 
// );

// /*****第2级 R2SDF****/
// SdfUnit2Rotate #(
//     .DELAY_DEPTH    (4),
//     .FFT_STAGE      (2) 
// )sdf_2nd(
//     .clk    (clk        ),
//     .rstn   (rstn       ),
//     .di_en  (sdf1_do_en ),
//     .di_re  (sdf1_do_re ),
//     .di_im  (sdf1_do_im ),

//     .do_en  (sdf2_do_en ),
//     .do_re  (sdf2_do_re ),
//     .do_im  (sdf2_do_im ) 
// );

// /*****第3级 R2SDF****/
// SdfUnit2Rotate #(
//     .DELAY_DEPTH    (2),
//     .FFT_STAGE      (3) 
// )sdf_3rd(
//     .clk    (clk        ),
//     .rstn   (rstn       ),
//     .di_en  (sdf2_do_en ),
//     .di_re  (sdf2_do_re ),
//     .di_im  (sdf2_do_im ),
//     .do_en  (sdf3_do_en ),
//     .do_re  (sdf3_do_re ),
//     .do_im  (sdf3_do_im ) 
// );

// /*****第4级 R2SDF****/
// SdfUnit2Rotate #(
//     .DELAY_DEPTH    (1),
//     .FFT_STAGE      (4) 
// )sdf_4th(
//     .clk    (clk        ),
//     .rstn   (rstn       ),
//     .di_en  (sdf3_do_en ),
//     .di_re  (sdf3_do_re ),
//     .di_im  (sdf3_do_im ),
//     .do_en  (sdf4_do_en ),
//     .do_re  (sdf4_do_re ),
//     .do_im  (sdf4_do_im ) 
// );

// assign do_en = sdf4_do_en ;
// assign do_re = sdf4_do_re ;
// assign do_im = sdf4_do_im ;

/****中间信号声明****/
    wire                         sdf_do_en[0:`C2LOG_FFT_POINTS-1];
    wire    [`DATA_IN_WIDTH-1:0] sdf_do_re[0:`C2LOG_FFT_POINTS-1];
    wire    [`DATA_IN_WIDTH-1:0] sdf_do_im[0:`C2LOG_FFT_POINTS-1];
genvar num;
generate
    for(num=0;num<`C2LOG_FFT_POINTS;num=num+1)begin
        if(num==0)begin
            SdfUnit2Rotate #(
                .DELAY_DEPTH    (2**(`C2LOG_FFT_POINTS-num-1)),
                .FFT_STAGE      (num+1)
            )sdf_1st(
                .clk    (clk        ),
                .rstn   (rstn       ),
                .di_en  (di_en      ),
                .di_re  (di_re      ),
                .di_im  (di_im      ),
                .do_en  (sdf_do_en[num] ),
                .do_re  (sdf_do_re[num] ),
                .do_im  (sdf_do_im[num] ) 
            );
        end
        else if(num==`C2LOG_FFT_POINTS-1)begin
            SdfUnit2Rotate_last_stage #(
                .DELAY_DEPTH    (2**(`C2LOG_FFT_POINTS-num-1)),
                .FFT_STAGE      (num+1)
            )sdf_last(
                .clk    (clk        ),
                .rstn   (rstn       ),
                .di_en  (sdf_do_en[num-1] ),
                .di_re  (sdf_do_re[num-1] ),
                .di_im  (sdf_do_im[num-1] ),
                .do_en  (sdf_do_en[num] ),
                .do_re  (sdf_do_re[num] ),
                .do_im  (sdf_do_im[num] ) 
            );
        end
        else begin
            SdfUnit2Rotate #(
                .DELAY_DEPTH    (2**(`C2LOG_FFT_POINTS-num-1)),
                .FFT_STAGE      (num+1)
            )sdf(
                .clk    (clk        ),
                .rstn   (rstn       ),
                .di_en  (sdf_do_en[num-1] ),
                .di_re  (sdf_do_re[num-1] ),
                .di_im  (sdf_do_im[num-1] ),
                .do_en  (sdf_do_en[num] ),
                .do_re  (sdf_do_re[num] ),
                .do_im  (sdf_do_im[num] ) 
            );
        end
    end
endgenerate

assign do_en = sdf_do_en[`C2LOG_FFT_POINTS-1] ;
assign do_re = sdf_do_re[`C2LOG_FFT_POINTS-1] ;
assign do_im = sdf_do_im[`C2LOG_FFT_POINTS-1] ;

/********逆序变为正序，将结果存储在RAM中*********/
reg [`C2LOG_FFT_POINTS-1:0] reorderCnt;
always@(posedge clk)begin
    if(do_en)
        reorderCnt<=reorderCnt+1'b1;
    else
        reorderCnt<=0;
end

reg [`C2LOG_FFT_POINTS-1:0] saveAddr;
integer i;
always@(*)begin
    if(~rstn)
        saveAddr =0;
    else begin
        for(i=0;i<`C2LOG_FFT_POINTS;i=i+1)
            saveAddr[i] = reorderCnt[`C2LOG_FFT_POINTS-1-i];
    end
end

reg [`DATA_IN_WIDTH-1:0]   fft_re_ram [0:`FFT_POINTS-1];
reg [`DATA_IN_WIDTH-1:0]   fft_im_ram [0:`FFT_POINTS-1];
integer j;
always@(posedge clk or negedge rstn)begin
    if(~rstn)begin
        for(j=0;j<`FFT_POINTS;j=j+1)begin
            fft_re_ram[j]<=0;
            fft_im_ram[j]<=0;
        end
    end
    else if(do_en)begin
        fft_re_ram[saveAddr]<= do_re;
        fft_im_ram[saveAddr]<= do_im;
    end
end

endmodule
