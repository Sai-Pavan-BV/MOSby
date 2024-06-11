`include "adder.v"
`include "l_shift.v"
`include "r_shift.v"

module alu(clk,rst,op,accumulator,operand_2,status,result,status_out);
input wire clk,rst;
input wire[3:0] op;
input wire[7:0] accumulator,operand_2,status;
output reg[7:0] result,status_out;

reg[7:0] alu_sel,operand;

reg cin,sh_r;

//status reg contents : carry zero interrput_disable decimal_mode break_cmd overflow negative

parameter ADD=0,ADC=1,SBC=2,AND=3,EOR=4,ORA=5,BIT=6,ASL=7,LSR=8,ROL=9,ROR=10;
parameter add=7'b0000001,L_shift=7'b0000010,R_shift=7'b0000100,AND_L=7'b0001000,EOR_L=7'b0010000,ORA_L=7'b0100000,BIT_L=7'b1000000;
always @(posedge clk) begin
    case (op)
        ADD: begin
                alu_sel=add;
                cin=0;
                operand=operand_2;
                sh_r=1'bx;
        end
        ADC: begin
                alu_sel=add;
                cin=status[7];
                operand=operand_2;
                sh_r=1'bx;
        end
        SBC: begin
                alu_sel=add;
                cin=~status[7];
                operand=(~operand_2+8'h1);
                sh_r=1'bx;
        end
        AND: begin
                alu_sel=AND_L;
                cin=1'bx;
                operand=operand_2;
                sh_r=1'bx;
        end
        EOR: begin
                alu_sel=EOR_L;
                cin=1'bx;
                operand=operand_2;
                sh_r=1'bx;
        end
        ORA: begin
                alu_sel=ORA_L;
                cin=1'bx;
                operand=operand_2;
                sh_r=1'bx;
        end
        BIT: begin
                alu_sel=BIT_L;
                cin=1'bx;
                operand=operand_2;
                sh_r=1'bx;
        end
        ASL: begin
                alu_sel=L_shift;
                cin=status[7];
                operand=operand_2;
                sh_r=1'b1;
        end
        LSR: begin
                alu_sel=R_shift;
                cin=status[7];
                operand=operand_2;
                sh_r=1'b1;
        end
        ROL: begin
                alu_sel=L_shift;
                cin=status[7];
                operand=operand_2;
                sh_r=1'b0;
        end
        ROR: begin
                alu_sel=R_shift;
                cin=status[7];
                operand=operand_2;
                sh_r=1'b0;
        end
        default: begin
            alu_sel=0;
            operand=operand_2;
            cin=0;
            sh_r=1'bx;
        end
    endcase
end
adder ad();
endmodule

module and_l (
    en,operand_1,operand_2,result
);

input wire en;
input wire [7:0] operand_1,operand_2;
output wire[7:0] result;

wire[7:0] result_buff;

assign result_buff=en?operand_1&operand_2:8'hzz;
    
endmodule

module eor_l (
    en,operand_1,operand_2,result
);

input wire en;
input wire [7:0] operand_1,operand_2;
output wire[7:0] result;

wire[7:0] result_buff;

assign result_buff=en?operand_1^operand_2:8'hzz;
    
endmodule

module ora_l (
    en,operand_1,operand_2,result
);

input wire en;
input wire [7:0] operand_1,operand_2;
output wire[7:0] result;

wire[7:0] result_buff;

assign result_buff=en?operand_1|operand_2:8'hzz;
    
endmodule

module bit_l (
    en,operand_1,operand_2,result,over
);

input wire en;
input wire [7:0] operand_1,operand_2;
output wire[7:0] result;
output wire over;

wire[7:0] result_buff;
wire over_buff;

assign result_buff=en?operand_1&operand_2:8'hzz;
assign over_buff=en?operand_2[6]:1'bz;
endmodule