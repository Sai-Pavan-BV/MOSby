`include "adder.v"
`include "l_shift.v"
`include "r_shift.v"
module alu_tb();
reg en,sh_r,cin;
reg[7:0] operand;
wire[7:0] result;
wire cout;
r_shift ls(en,sh_r,cin,operand,cout,result);
integer i;
initial begin
    $dumpfile("alu.vcd");
    $dumpvars(1,ls);
    en=0;
    operand=$random;
    cin=1;
    sh_r=1;
    #10
    en=1;
    #20
    sh_r=0;
    #20;
    $finish;

end
    
endmodule