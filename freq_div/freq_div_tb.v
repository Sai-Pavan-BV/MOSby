`timescale 1ps/1ps
`include "freq_div.v"
module freq_div_tb();
reg clk,rst;
wire clk_1,clk_2;
freq_div fd(clk,rst,clk_1,clk_2);
always #5 clk=~clk;
initial begin
    $dumpfile("test.vcd");
    $dumpvars(1,fd);
    //$monitor($time," clk_1=%b clk_2=%b clk_3=%b ",clk_1,clk_2,clk_3,clk);
    clk=0;
    #9 rst=1;
    #4 rst=0;
    #100
    $finish;
end
    
endmodule