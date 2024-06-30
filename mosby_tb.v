`timescale 1ps/1ps
`include "mosby.v"

module mosby_tb();
reg clk,rst;

reg branch_uncon,branch_con,pc_inc_decoder,lower_byte_decoder;
reg[2:0] branch_op;
reg[7:0] status;

mosby mosby_inst(clk,rst,branch_uncon,branch_con,pc_inc_decoder,lower_byte_decoder,branch_op,status);

always #5 clk = ~clk;

initial begin
    $dumpfile("mosby.vcd");
    $dumpvars(1,mosby_inst);
    clk = 0;
    rst = 0;
    branch_uncon = 0;
    branch_con = 0;
    pc_inc_decoder = 1;
    lower_byte_decoder = 0;
    branch_op = 0;
    status = 8'b00000000;
    #6 rst=1;
    #13 rst=0;
    #100;
    $finish;
end

endmodule