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
    end
    always #1 clk=~clk;

    reg [`DATA_IN_WIDTH-1:0] mem [0:`FFT_POINTS-1];
    reg [`C2LOG_FFT_POINTS-1:0] mem_addr;
    initial begin
        mem[ 0]=5000;
        mem[ 1]=500;
        mem[ 2]=500;
        mem[ 3]=500;
        mem[ 4]=0;
        mem[ 5]=0;
        mem[ 6]=0;
        mem[ 7]=0;
        mem[ 8]=100;
        mem[ 9]=200;
        mem[10]=300;
        mem[11]=400;
        mem[12]=500;
        mem[13]=600;
        mem[14]=700;
        mem[15]=800;
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
            di_re<=mem[mem_addr];
            di_im<=0;
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

