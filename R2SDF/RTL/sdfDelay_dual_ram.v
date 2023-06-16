/*
    采用双端口RAM作为 delay延时
*/
`include "define.v"
module sdfDelay_dual_ram#(
    parameter DELAY_DEPTH = 1,
    parameter FFT_STAGE = 1
)(
    input   wire                        clk     ,
    input   wire                        rstn    ,
    input   wire    [`DATA_IN_WIDTH-1:0]di_re   ,
    input   wire    [`DATA_IN_WIDTH-1:0]di_im   ,
    output  wire                        do_en   ,
    output  wire    [`DATA_IN_WIDTH-1:0]do_re   ,
    output  wire    [`DATA_IN_WIDTH-1:0]do_im   
);

/*******使能信号的控制********/
localparam CNT_WIDTH = $clog2(DELAY_DEPTH);
reg wr_en;
reg rd_en;
reg [CNT_WIDTH:0] rd_delay_wr_cnt;
always @(*) begin
    if(~rstn)begin
        wr_en=0;
        rd_en=0;
    end
    else begin
        wr_en=1;
        // rd_en= (rd_delay_wr_cnt[CNT_WIDTH]==1);
        rd_en= (rd_delay_wr_cnt==DELAY_DEPTH-1);
    end
end

always@(posedge clk or negedge rstn)begin
    if(~rstn)
        rd_delay_wr_cnt<=0;
    else if(rd_en==0)
        rd_delay_wr_cnt<=rd_delay_wr_cnt+1'b1;
end

/*******对于双端口ram的读写地址控制*******/
localparam ADDR_WIDTH = $clog2(DELAY_DEPTH);
reg [ADDR_WIDTH-1:0] wr_addr;
reg [ADDR_WIDTH-1:0] rd_addr;

always@(posedge clk or negedge rstn)begin
    if(~rstn)
        wr_addr<=0;
    else if(wr_en)begin
        if(wr_addr<DELAY_DEPTH-1)
            wr_addr<=wr_addr+1'b1;
        else
            wr_addr<=0;
    end
end

always@(posedge clk or negedge rstn)begin
    if(~rstn)
        rd_addr<=0;
    else if(rd_en)begin
        if(rd_addr<DELAY_DEPTH-1)
            rd_addr<=rd_addr+1'b1;
        else
            rd_addr<=0;
    end
end

/********双端口的例化******/
dual_ram #(
    .WIDTH(`DATA_IN_WIDTH),
    .DEPTH(DELAY_DEPTH)
)u_delay_re(
    .clk  (clk )    ,
    .wr_en(1'b1)   ,
    .rd_en(1'b1)   ,
    .wr_addr(wr_addr),
    .rd_addr(rd_addr),
    .wdata(di_re)   ,
    .rdata(do_re)   
);

dual_ram #(
    .WIDTH(`DATA_IN_WIDTH),
    .DEPTH(DELAY_DEPTH)
)u_delay_im(
    .clk  (clk )    ,
    .wr_en(1'b1)   ,
    .rd_en(1'b1)   ,
    .wr_addr(wr_addr),
    .rd_addr(rd_addr),
    .wdata(di_im)   ,
    .rdata(do_im)   
);

/*****do_re*****/
reg do_en_r;
always@(posedge clk)begin
    if(~rstn)
        do_en_r<=0;
    else
        do_en_r<=rd_en;
end
assign do_en = do_en_r;
endmodule