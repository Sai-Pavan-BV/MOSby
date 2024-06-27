`timescale 1ps/1ps
`include "mem_access.v"
`include "../clk_gen/clk_gen.v"
module mem_access_tb();
wire clk_1,clk_2;
reg clk,rst,en,pc_data,w_rd;
reg[15:0] address,pc;

wire[7:0] data_out,data_bus;
reg[7:0] data_out_buff,data_bus_buff;

wire[15:0] address_out;
clk_gen cg(clk,rst,clk_1,clk_2);
mem_access m(rst,clk_1,clk_2,en,pc_data,w_rd,
                    address,pc,
                    data_out,data_bus,
                    address_out);

assign data_out=(!rst&en&w_rd)?8'hzz:data_out_buff;
assign data_bus=(!rst&en&!w_rd)?8'hzz:data_bus_buff;

always #2 clk=~clk;
initial begin
    $dumpfile("mem_access.vcd");
    $dumpvars(1,m);
    clk<=0;
    rst<=0;
    data_bus_buff<=$random;
    data_out_buff<=$random;
    en<=0;
    pc_data<=0;
    w_rd<=0;
    address<=$random;
    pc<=$random;
    #2
    rst=1;
    #1
    rst=0;
    en=0;
    pc_data=1;
    #8
    pc_data=0;
    #20
    $finish;
end

endmodule