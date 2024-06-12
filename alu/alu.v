`include "adder.v"
`include "l_shift.v"
`include "r_shift.v"
`include "../mux.v"

module alu(clk,rst,op,accumulator,operand_2,status,result,status_out);
input wire clk,rst;
input wire[3:0] op;
input wire[7:0] accumulator,operand_2,status;
output wire[7:0] result,status_out;

wire[7:0] result_temp_adder,result_temp_sub,status_out_temp_add,status_out_temp_sub;

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
                cin=1'b1;
                operand=~operand_2;
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

adder ad(accumulator,operand,cin,alu_sel[0],result_temp_adder,status_out_temp_add[7],status_out_temp_add[1]);
adder ads(result_temp_adder,~{7'd0,status[7]},1'b1,alu_sel[0],result_temp_sub,status_out_temp_sub[7],status_out_temp_sub[1]);
mux_2x1 #(8) m1(alu_sel[0],!(op==SBC),result_temp_adder,result_temp_sub,result);
mux_2x1 #(8) m2(alu_sel[0],!(op==SBC),status_out_temp_add,status_out_temp_sub,status_out);
l_shift ls(alu_sel[1],sh_r,cin,operand,status_out[7],result);
r_shift rs(alu_sel[2],sh_r,cin,operand,status_out[7],result);
and_l an(alu_sel[3],accumulator,operand,result);
eor_l er(alu_sel[4],accumulator,operand,result);
ora_l ol(alu_sel[5],accumulator,operand,result);
bit_l bt(alu_sel[6],accumulator,operand,result,status_out[1]);

assign status_out[6]=~(|result);
assign status_out[0]=result[7];


endmodule

module and_l (
    en,operand_1,operand_2,result
);

input wire en;
input wire [7:0] operand_1,operand_2;
output wire[7:0] result;

assign result=en?operand_1&operand_2:8'hzz;
    
endmodule

module eor_l (
    en,operand_1,operand_2,result
);

input wire en;
input wire [7:0] operand_1,operand_2;
output wire[7:0] result;

assign result=en?operand_1^operand_2:8'hzz;
    
endmodule

module ora_l (
    en,operand_1,operand_2,result
);

input wire en;
input wire [7:0] operand_1,operand_2;
output wire[7:0] result;

assign result=en?operand_1|operand_2:8'hzz;
    
endmodule

module bit_l (
    en,operand_1,operand_2,result,over
);

input wire en;
input wire [7:0] operand_1,operand_2;
output wire[7:0] result;
output wire over;

assign result=en?operand_1&operand_2:8'hzz;
assign over=en?operand_2[6]:1'bz;
endmodule