`include "define.v"
module tb_SdfUnit2Rotate();

    reg                             clk     ;
    reg                             rstn    ;
    reg                             di_en   ;
    reg     [`DATA_IN_WIDTH-1:0]    di_re   ;
    reg     [`DATA_IN_WIDTH-1:0]    di_im   ;
    wire                            do_en   ;
    wire    [`DATA_IN_WIDTH-1:0]    do_re   ;
    wire    [`DATA_IN_WIDTH-1:0]    do_im   ;

    initial begin
        clk=0;
        rstn=0;
        #10
        rstn=1;
    end
    always#1 clk=~clk;

    always@(posedge clk)begin
        if(~rstn)begin
            di_en<=0;
            di_re<=0;
            di_im<=0;
        end
        else begin
            di_en<=1;
            di_re<= di_en ? di_re+1'b1 : 0;
            di_im<=0;
        end
    end

SdfUnit2Rotate #(
    .DELAY_DEPTH    (1      ),
    .FFT_STAGE      (3      )
)SdfUnit2Rotate(
    .clk            (clk    ),
    .rstn           (rstn   ),
    .di_en          (di_en  ),
    .di_re          (di_re  ),
    .di_im          (di_im  ),
    .do_en          (do_en  ),
    .do_re          (do_re  ),
    .do_im          (do_im  ) 
);

//     reg                             clk     ;
//     reg     [`C2LOG_FFT_POINTS-1:0] cnt     ;
//     reg     [`DATA_IN_WIDTH-1:0]    di_re   ;
//     reg     [`DATA_IN_WIDTH-1:0]    di_im   ;
//     wire    [`DATA_IN_WIDTH-1:0]    do_re   ;
//     wire    [`DATA_IN_WIDTH-1:0]    do_im   ;

//     reg rstn;
//     initial begin
//         clk=0;
//         rstn=0;
//         #10
//         rstn=1;
//     end
//     always#1 clk=~clk;

//     always@(posedge clk)begin
//         if(~rstn)begin
//             cnt<=0;
//             di_re<=0;
//             di_im<=0;
//         end
//         else begin
//             di_re<=di_re+1'b1;
//             di_im<=0;
//             cnt<=cnt+1'b1;
//         end
//     end

// SdfUnit2Rotate #(
//     .DELAY_DEPTH    (4      ),
//     .FFT_STAGE      (1      )
// )SdfUnit2Rotate(
//     .clk            (clk    ),
//     .cnt            (cnt    ),//FFT输入点数计数器，上限为FFT点数
//     .di_re          (di_re  ),
//     .di_im          (di_im  ),
//     .do_re          (do_re  ),
//     .do_im          (do_im  ) 
// );

endmodule
