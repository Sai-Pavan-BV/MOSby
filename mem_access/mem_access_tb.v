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

assign data_out=!(!rst&en&w_rd)?data_out_buff:8'hzz;
assign data_bus=!(!rst&en&!w_rd)?data_bus_buff:8'hzz;

always #2 clk=~clk;
initial begin
    $dumpfile("mem_access.vcd");
    $dumpvars(1,m);
    $finish;
end

endmodule