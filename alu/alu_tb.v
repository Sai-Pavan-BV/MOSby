`include "alu.v"

module alu_tb();
reg clk,rst;
reg [3:0] op;
reg [7:0] accumulator,operand_2,status;
wire[7:0] result,status_out;
integer i;

alu al(clk,rst,op,accumulator,operand_2,status,result,status_out);

always #5 clk=~clk;
initial begin
    $dumpfile("alu.vcd");
    $dumpvars(1,al);
    clk=0;
    accumulator=$random;
    operand_2=$random;
    status=8'b00000000;
    op=0;
    #15
    op=1;
    #15
    op=2;
    #15
    op=3;
    #30
    $finish;
end
    
endmodule