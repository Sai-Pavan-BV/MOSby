`timescale 1ps/1ps
`include "./branch/branch.v"
`include "./pc/pc.v"
`include "./clk_gen/clk_gen.v"
module mosby (clk,rst,
                branch_uncon,branch_con,pc_inc_decoder,lower_byte_decoder,
                branch_op,
                status);
input wire clk,rst;

input  wire branch_uncon,branch_con,pc_inc_decoder,lower_byte_decoder;
input wire[2:0] branch_op;
input wire[7:0] status;

wire clk_1, clk_2,pc_increment,lower_byte;

wire[7:0] data_bus;

wire[15:0] address;

clk_gen cg(clk,rst,clk_1,clk_2);

pc p(clk_1,rst,branch,pc_increment,lower_byte,data_bus,address);

branch br (rst,clk_1,clk_2,branch_uncon,branch_con,pc_inc_decoder,lower_byte_decoder,
                branch_op,
                status,
                branch,lower_byte,normal,pc_increment);
assign data_bus=8'h69;
endmodule