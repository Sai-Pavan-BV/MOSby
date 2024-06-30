`timescale 1ps/1ps
`include "./branch/branch.v"
`include "./pc/pc.v"
`include "./clk_gen/clk_gen.v"
module mosby ();
input wire clk,rst;

wire clk_1, clk_2,branch,pc_increment,lower_byte;

wire[7:0] data_bus;

wire[15:0] address;

clk_gen cg(clk,rst,clk_1,clk_2);

pc p(clk_1,rst,branch,pc_increment,lower_byte,data_bus,address);

endmodule