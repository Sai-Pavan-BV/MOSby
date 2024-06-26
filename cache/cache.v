module cache ( rst,clk_1,clk_2,w_en,
                address,
                hit,
                data);
input wire rst,clk_1,clk_2,w_en;
input wire [15:0] address;
output wire hit;
inout[7:0] data;
reg[7:0] mem[127:0];
reg[8:0] tag[127:0];
reg hit_buff;
reg[7:0] data_buffer;

/*128 bytes of cache, 15:7 bits of address are tags*/

integer i;
always @(posedge rst ) begin
    for(i=0;i<128;i=i+1) begin
        mem[i]=0;
        tag[i]=0;
    end
end

always @(address) begin
    // if(clk_1) begin
        if(!w_en) begin             //read
            if(address[15:7]==tag[address[6:0]]) begin      //cache hit
                hit_buff<=1;
                data_buffer<=mem[address[6:0]];
            end
            else begin
                hit_buff<=0;
                data_buffer<=8'hxx;
            end
        end
        else begin          //write
            hit_buff<=1'bx;
            mem[address[6:0]]<=data;
            tag[address[6:0]]<=address[15:7];
        end
    //end
end
    assign data=w_en?8'hzz:data_buffer;
    assign hit=hit_buff;
endmodule