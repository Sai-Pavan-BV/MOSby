`timescale 1ps/1ps
`include "/home/pavan/mos6502/freq_div/freq_div.v"
module req_div_tb();
reg clk;
wire clk_1,clk_2,clk_3;
freq_div fd(clk,clk_1,clk_2,clk_3);
always #5 clk=~clk;
initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,fd);
    //$monitor($time," clk_1=%b clk_2=%b clk_3=%b ",clk_1,clk_2,clk_3,clk);
    clk=0;
    #100
    $finish;
end
    
endmodule