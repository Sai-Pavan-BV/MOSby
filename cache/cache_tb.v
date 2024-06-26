`timescale 1ps/1ps
`include "cache.v"
module cache_tb();
reg rst,clk_1,clk_2,w_en;
reg [15:0] address;
wire hit;
wire[7:0] data;
reg[7:0] data_buffer;
cache c( rst,clk_1,clk_2,w_en,address,hit,data);
assign data=w_en?data_buffer:8'hzz;
always #5 clk_1=~clk_1;
initial begin
    $dumpfile("cache.vcd");
    $dumpvars(1,c);
    clk_1<=1;
    data_buffer<=8'd16;
    rst<=0;
    address<=$random;
    w_en<=0;
    #10;
    rst<=1;
    #10;
    rst<=0;
    address<=0;
    #10
    w_en<=1;
    address<=16'h0010;
    #10;
    w_en<=0;
    address<=16'h0005;
    #10
    address<=16'h0010;
    #20;
    $finish;
end
endmodule