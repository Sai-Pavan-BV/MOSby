`include "./alu/adder.v"                //please change the addresses accordingly
`include "./alu/l_shift.v"
`include "./alu/r_shift.v"
//`include "../mux.v"                      //turn on while testing alu individually

module alu(rst,clk_1,clk_2,accumulator,operand_2,status_in,alu_op,result,status_out);

input wire rst,clk_1,clk_2;
input wire[7:0] accumulator,operand_2,status_in;
input wire[3:0] alu_op;
output wire[7:0] result,status_out;

wire cout;
reg[7:0] accumulator_buffer,operand_2_buffer,status_buffer;
wire[7:0] result_buff;
parameter ADD=0,ADC=1,SBC=2,AND=3,EOR=4,ORA=5,BIT=6,ASL=7,LSR=8,ROL=9,ROR=10,PASS=11; //for alu
reg[6:0] alu_sel;

//status reg contents : carry zero interrput_disable decimal_mode break_cmd overflow negative

always @(posedge rst ) begin
    accumulator_buffer<=8'h00;
    operand_2_buffer<=8'h00;
    status_buffer<=8'h00;
    alu_sel<=7'b0000000;
end

always @(posedge clk_2 ) begin
        accumulator_buffer<=accumulator;
        operand_2_buffer<=operand_2;
        status_buffer<=status_in;
        case(alu_op) 
                ADD: alu_sel<=7'b0000001;
                ADC: alu_sel<=7'b0000001;
                SBC: alu_sel<=7'b0000001;
                AND: alu_sel<=7'b0000010;
                EOR: alu_sel<=7'b0000100;
                ORA: alu_sel<=7'b0001000;
                BIT: alu_sel<=7'b0010000;
                ASL: alu_sel<=7'b0100000;
                ROL: alu_sel<=7'b0100000;
                LSR: alu_sel<=7'b1000000;
                ROR: alu_sel<=7'b1000000;
                PASS: alu_sel<=7'b0000000;
        endcase
end

adder ad(alu_sel[0],(alu_op==SBC?1'b0:1'b1),accumulator_buffer,operand_2_buffer,status_buffer[7],result_buff,cout);
l_shift ls (alu_sel[5],(alu_op==ASL?1'b1:1'b0),status_buffer[7],accumulator_buffer,cout,result_buff);

r_shift rs (alu_sel[6],(alu_op==LSR?1'b1:1'b0),status_buffer[7],accumulator_buffer,cout,result_buff);

and_l an(alu_sel[1],accumulator_buffer,operand_2_buffer,result_buff);

eor_l eor(alu_sel[2],accumulator_buffer,operand_2_buffer,result_buff);

ora_l org(alu_sel[3],accumulator_buffer,operand_2_buffer,result_buff);

bit_l bit(alu_sel[4],accumulator_buffer,operand_2_buffer,result_buff,status_out[2]);

mux_2x1 #(8) m1(1'b1,|alu_sel,operand_2_buffer,result_buff,result);

assign status_out[7]=(alu_sel[0]|alu_sel[5]|alu_sel[6])?cout:status_buffer[7];              //carry
assign status_out[6]=alu_op==PASS?status_buffer[6]:~|result_buff;              //zero
assign status_out[5]=status_buffer[5];      //interrupt_disable
assign status_out[4]=status_buffer[4];      //decimal_mode
assign status_out[3]=status_buffer[3];      //break_cmd
assign status_out[2]=status_buffer[2];      //overflow
assign status_out[1]=alu_op==PASS?status_buffer[1]:result_buff[7];             //negative
assign status_out[0]=status_buffer[0];      //unused


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