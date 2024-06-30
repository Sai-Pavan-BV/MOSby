module decoder (
    rst,clk_1,clk_2,flush,normal,
    instruction,
);

input wire rst,clk_1,clk_2,flush,normal;
input wire[7:0] instruction;

output wire w_rd,       //memory write or read
            pc_data,    //address from pc or data_bus
            increment,lower_byte,   //program counter controls
            x_con,y_con,accumulator_con,status_con,stack_pointer_con,      //registers controls
            branch_op,branch_uncon,branch_con;              //branch controls

output wire[3:0] alu_op;            //alu controls
output wire [2:0] branch_op;        //branch controls

output wire[7:0] immediate;

reg update_ir;
reg[2:0] counter;
reg[7:0] instruction_register;

reg w_rd_buffer,
    pc_data_buffer,
    increment_buffer, lower_byte_buffer,
    x_con_buffer, y_con_buffer, accumulator_con_buffer, status_con_buffer, stack_pointer_con_buffer,
    branch_uncon_buffer, branch_con_buffer;

reg[3:0] alu_op_buffer;
reg[2:0] branch_op_buffer;

assign w_rd=w_rd_buffer;
assign pc_data=pc_data_buffer;
assign increment=increment_buffer;
assign lower_byte=lower_byte_buffer;
assign x_con=x_con_buffer;
assign y_con=y_con_buffer;
assign accumulator_con=accumulator_con_buffer;
assign status_con=status_con_buffer;
assign stack_pointer_con=stack_pointer_con_buffer;
assign branch_uncon=branch_uncon_buffer;
assign branch_con=branch_con_buffer;
assign alu_op=alu_op_buffer;
assign branch_op=branch_op_buffer;


parameter ADC_Immediate =8'h69;
parameter ADD=0,ADC=1,SBC=2,AND=3,EOR=4,ORA=5,BIT=6,ASL=7,LSR=8,ROL=9,ROR=10,PASS=11; //for alu
/* LIST OF CONTROL SIGNALS
    cache w_rd (write or read cache);
    external memory access:en, pc_data,w_rd;
    program counter: increment,lower_byte;
    registers:x_con,y_con,accumulator_con,status_con,stack_pointer_con;
    alu:op;
    branch:op,branch_uncon,branch_con;
*/
always @(posedge rst) begin
    counter=0;
    update_ir=1;
end

always @(posedge clk_2) begin           //test this out
    if(update_ir) begin
        instruction_register=instruction;
    end
end

always @(negedge clk_2) begin
    if (normal) begin
        case (instruction_register)     //checking for instruction
            ADC_Immediate:  begin           //micro-instruction
                                case (counter)
                                    0: begin
                                        increment_buffer=1;     //increment program counter
                                        update_ir=0;        //update instruction register
                                        w_rd_buffer=0;      //read the immediate
                                        pc_data_buffer=1;   //address from pc
                                        x_con_buffer=0;     //write to x register
                                        y_con_buffer=0;     //write y register
                                        accumulator_con_buffer=1;   //write to accumulator
                                        status_con_buffer=1;    //write to status register
                                        stack_pointer_con_buffer=0;  //write to stack pointer
                                        alu_op_buffer=ADC;     //ADC operation
                                        branch_op_buffer=3'hx;     //no branch
                                        branch_uncon_buffer=0;     //no branch
                                        branch_con_buffer=0;       //no branch
                                        


                                    end
                                endcase
                            end 
            default: 
        endcase
    end
end
    
endmodule