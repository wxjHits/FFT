`timescale 1ns/1ps
`include "define.v"
module tb_R2SDF_FFT ();

    reg                            clk     ;
    reg                            rstn    ;
    reg                            di_en   ;
    reg     [`DATA_IN_WIDTH-1:0]   di_re   ;
    reg     [`DATA_IN_WIDTH-1:0]   di_im   ;
    wire    [`DATA_IN_WIDTH-1:0]   do_re   ;
    wire    [`DATA_IN_WIDTH-1:0]   do_im   ;

    initial begin
        clk=0;
        rstn=0;
        #10;
        rstn=1;

        // #600
        // rstn=0;
        // #10;
        // rstn=1;

    end
    always #1 clk=~clk;

    reg [`DATA_IN_WIDTH-1:0] real_mem [0:`FFT_POINTS-1];
    reg [`DATA_IN_WIDTH-1:0] img_mem [0:`FFT_POINTS-1];
    reg [`C2LOG_FFT_POINTS-1:0] mem_addr;
    initial begin
        $readmemh("C:/Users/hp/Desktop/FFT/R2SDF/matlab/input_real.txt",real_mem);
        $readmemh("C:/Users/hp/Desktop/FFT/R2SDF/matlab/input_img.txt",img_mem);
    end

    always@(posedge clk or negedge rstn)begin
        if(~rstn)begin
            di_en<=0;
            di_re<=0;
            di_im<=0;
            mem_addr<=0;
        end
        else begin
            di_en<=1;
            di_re<=real_mem[mem_addr];
            di_im<=img_mem[mem_addr];
            mem_addr<=mem_addr+1'b1;
        end
    end

    R2SDF_FFT u_R2SDF_FFT(
        .clk    (clk    ),
        .rstn   (rstn   ),
        .di_en  (di_en  ),
        .di_re  (di_re  ),
        .di_im  (di_im  ),
        .do_en  (do_en  ),
        .do_re  (do_re  ),
        .do_im  (do_im  )
    );

endmodule

