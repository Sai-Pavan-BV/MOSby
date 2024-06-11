module alu(clk,rst,op,operand_1,operand_2,status,result,status_out);
input wire clk,rst;
input wire[7:0] op,operand_1,operand_2,status;
output reg[7:0] result,status_out
endmodule