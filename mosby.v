`timescale 1ps/1ps
`include "./branch/branch.v"
`include "./pc/pc.v"
`include "./clk_gen/clk_gen.v"
`include "./cache/cache.v"
`include "./decoder/decoder.v"
`include "./register/register.v"
`include "./mux.v"
`include "./alu/alu.v"
module mosby (rst,clk);
input wire clk,rst;

wire branch_uncon,branch_con,pc_inc_decoder,lower_byte_decoder;
wire[2:0] branch_op;
wire[7:0] status;

wire clk_1, clk_2,pc_increment,lower_byte;
wire pc_data,w_rd,x_con,y_con,accumulator_con,status_con,stack_pointer_con;
wire[3:0] alu_op;
wire[1:0] operand_mux_con;

wire[7:0] data_bus,data_status,data_out_accumulator,data_out_sp,data_out_status,data_out_x,data_out_y,
            data_alu_result,operand_2;

wire[15:0] address;

clk_gen cg(clk,rst,clk_1,clk_2);

pc p(clk_1,rst,branch,pc_increment,lower_byte,data_bus,address);

branch br (rst,clk_1,clk_2,branch_uncon,branch_con,pc_inc_decoder,lower_byte_decoder,
                branch_op,
                status,
                branch,lower_byte,normal,pc_increment);

cache c( rst,clk_1,clk_2,w_rd,
                address,
                hit,
                data_bus);

decoder d(rst,clk_1,clk_2,1'b0,normal,
    data_bus,
     w_rd,pc_data,pc_inc_decoder,lower_byte_decoder,
     x_con,y_con,accumulator_con,status_con,stack_pointer_con,
     branch_uncon,branch_con,
    alu_op,branch_op,operand_mux_con
);

register r(
    rst,clk_1,clk_2,
    x_con,y_con,accumulator_con,
    stack_pointer_con,status_con,

    data_alu_result,data_status,

    data_out_x,data_out_y,data_out_accumulator,
    data_out_sp,data_out_status


);

mux_4x1 #(8) m1(1'b1,
    operand_mux_con,
    data_out_x,data_out_y,data_out_sp,data_bus,
    operand_2);

alu a(clk_2,rst,alu_op,data_out_accumulator,operand_2,data_out_status,data_alu_result,data_status);


endmodule