module alu(clk,rst,en,op,operand_1,operand_2,status,result_buff,status_out);
input wire clk,rst,en;
input wire[7:0] op,operand_1,operand_2,status;
output reg[7:0] result_buff,status_out;
reg result
parameter ADD,ADC,CMP,AND,EOR,ORA,BIT,ASL,LSR,ROL,ROR;

case (op)
    ADD: 
    default: 
endcase
endmodule