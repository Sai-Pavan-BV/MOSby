`include "pc.v"
module pc_tb();
reg clk,rst,branch,increment;
reg[15:0] bra_add;
wire[15:0] address;
pc p(clk,rst,branch,increment,bra_add,address);
always #5 clk=~clk;
initial begin
    $dumpfile("tb.vcd");
    $dumpvars(1,p);
    clk=0;
    increment=1;
    #10 rst=1;
    #20 rst=0;
    #40 branch=1;
        bra_add=$random;
    #20
        branch=0;
    #40
        increment=0;
    #50
    $finish;
end
endmodule