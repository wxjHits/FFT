/*
    双端口ram
*/
module dual_ram#(
    parameter WIDTH = 16,
    parameter DEPTH = 16,
    parameter ADDR_WIDTH = $clog2(DEPTH)
)(
    input   wire                        clk     ,
    input   wire                        rstn    ,
    //write
    input   wire                        wr_en   ,
    input   wire    [ADDR_WIDTH-1:0]    wr_addr ,
    input   wire    [WIDTH-1:0]         wdata   ,
    //read
    input   wire                        rd_en   ,
    input   wire    [ADDR_WIDTH-1:0]    rd_addr ,
    output  reg     [WIDTH-1:0]         rdata   
);

// localparam ADDR_WIDTH = $clog2(DEPTH);
/**********双端 ram***********/
    (*ram_style="block"*)reg [WIDTH-1:0] ram [0:DEPTH-1];
    integer i;
    always @(posedge clk) begin
        // if(~rstn)begin
        //     for(i=0;i<DEPTH+1;i=i+1)
        //         ram[i]<=0;
        // end
        // else if(wr_en)
        //     ram[wr_addr]<=wdata;
        if(wr_en)
            ram[wr_addr]<=wdata;
    end

    // wire addr_same_flag = (wr_addr==rd_addr);
    always@(posedge clk)begin
        if(rd_en)begin
            // if(wr_en && addr_same_flag)
            //     rdata<=wdata;
            // else
                rdata<=ram[rd_addr];
        end
    end
endmodule
