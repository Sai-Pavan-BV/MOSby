`timescale 1ps/1ps
`include "branch.v"
`include "../pc/pc.v"
module branch_tb();
reg rst, clk_1, clk_2, branch_uncon, branch_con, pc_inc_decoder, lower_byte_decoder;
reg [2:0] branch_op;
reg [7:0] status;
wire branch, lower_byte, normal, pc_increment;

branch br(rst, clk_1, clk_2, branch_uncon, branch_con, pc_inc_decoder, lower_byte_decoder,
            branch_op,
            status,
            branch, lower_byte, normal, pc_increment);

pc p(clk,rst,branch,increment,lower_byte,bra_add,address);


always #5 clk_2 = ~clk_2;
    initial begin
        $dumpfile("branch.vcd");
        $dumpvars(1,branch_tb);
        clk_1 = 0;
        clk_2 = 0;
        branch_uncon = 0;
        branch_con = 0;
        pc_inc_decoder = 0;
        lower_byte_decoder = 0;
        branch_op = 0;
        status = 0;
        #13 rst = 1;
        #5 rst = 0;
        #50
        $finish;

    end
endmodule