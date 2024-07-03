`include "alu.v"

module alu_tb();
reg clk_2,rst;
reg [3:0] op;
reg [7:0] accumulator,operand_2,status;
wire[7:0] result,status_out;
integer i;

alu al(rst,clk_1,clk_2,accumulator,operand_2,status,op,result,status_out);

always #5 clk_2=~clk_2;
initial begin
    $dumpfile("alu.vcd");
    $dumpvars(1,al);
    clk_2=0;
    rst=0;
    accumulator=8'd66;
    operand_2=8'd30;
    status=8'b00000000;
    #2 rst=1;
    #1 rst=0;
    for (i=0;i<12;i=i+1) begin
        op=i;
        #15;
    end
    #15;
    $finish;
end
    
endmodule