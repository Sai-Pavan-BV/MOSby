`timescale 1ps/1ps
`include "mosby.v"

module mosby_tb();
reg clk,rst;

mosby pro(rst,clk);

always #5 clk = ~clk;

initial begin
    $dumpfile("mosby.vcd");
    $dumpvars(0,pro);
    clk = 0;
    rst = 0;
    #1 rst = 1;
    #1 rst=0;
    #500
    $finish;
end

endmodule