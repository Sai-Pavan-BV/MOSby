`timescale 1ps/1ps
`include "branch.v"
`include "../pc/pc.v"
`include "../clk_gen/clk_gen.v"
module branch_tb();
reg rst, clk, branch_uncon, branch_con, pc_inc_decoder, lower_byte_decoder;
reg [2:0] branch_op;
reg [7:0] status;
reg[7:0] bra_add;
wire clk_1, clk_2;
wire branch, lower_byte, normal, pc_increment;
wire[15:0] address;

branch br(rst, clk_1, clk_2, branch_uncon, branch_con, pc_inc_decoder, lower_byte_decoder,
            branch_op,
            status,
            branch, lower_byte, normal, pc_increment);

pc p(clk_1,rst,branch,pc_increment,lower_byte,bra_add,address);

clk_gen cg(clk,rst,clk_1,clk_2);


always #5 clk = ~clk;
    initial begin
        $dumpfile("branch.vcd");
        $dumpvars(1,branch_tb);
        clk = 0;
        branch_uncon = 0;
        branch_con = 0;
        pc_inc_decoder = 0;
        lower_byte_decoder = 0;
        branch_op = 0;
        status = 0;
        bra_add = 8'h55;
        #13 rst = 1;
        #5 rst = 0;
        wait(lower_byte==1);
        wait(lower_byte==0);
        bra_add=8'h44;
        #100;
        $finish;

    end
endmodule