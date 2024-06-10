`include "adder.v"
module alu_tb();
reg cin;
reg[7:0] a,b;
wire cout,over;
wire[7:0] s;

adder ad(a,b,cin,s,cout,over);
integer i;
initial begin
    $dumpfile("alu.vcd");
    $dumpvars(1,ad);
        for (i=0;i<10;i=i+1) begin
            cin=$random;
            a=$random;
            b=$random;
            #5;
        end

end
    
endmodule