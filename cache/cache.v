module cache ( rst,clk_1,clk_2,w_rd,
                address,
                hit,
                data);
input wire rst,clk_1,clk_2,w_rd;
input wire [15:0] address;
output wire hit;
inout[7:0] data;
reg[7:0] mem[127:0];
reg[8:0] tag[127:0];
reg hit_buff;
reg[7:0] data_buffer;

/*  This is a direct mapped 128 bytes of cache, 15:7 bits of address are tags.
    the output change one when address changes, w_rd should be stready before the address is changed.
    For some reason, using non-blocking assignments(for w_rd and address ) works. */

integer i;
always @(posedge rst ) begin
    for(i=0;i<128;i=i+1) begin
        mem[i]=0;
        tag[i]=0;
        mem[0]=8'h69;
        mem[1]=8'h03;
        mem[2]=8'h69;
        mem[3]=8'h04;
        mem[4]=8'hA9;
        mem[5]=8'h05;
        mem[6]=8'h69;
        mem[7]=8'h02;
        mem[7'b1001010]=8'h00;
        tag[7'b1001010]=9'b111111111;
        mem[17'b1001011]=8'h00;
        tag[17'b1001011]=9'b111111111;
    end
    hit_buff=0;
end

always @(clk_1) begin
     if(clk_1) begin
        if(!w_rd) begin             //read
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
    end
end
    assign data=w_rd?8'hzz:data_buffer;
    assign hit=hit_buff;
endmodule