`include "clk_gen.v"

module clkgen_tb();
reg clk,rst;
wire clk_1,clk_2;

clk_gen cg(clk,rst,clk_1,clk_2);
always #5 clk=~clk;
initial begin
    $dumpfile("clkgen.vcd");
    $dumpvars(1,cg);
    clk=0;
    #2;
    rst=1;
    #15
    rst=0;
    #100
    $finish;
end   
endmodule