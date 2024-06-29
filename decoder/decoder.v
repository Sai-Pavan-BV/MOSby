module decoder (
    rst,clk_1,clk_2,
    in
);

input wire rst,clk_1,clk_2;
input wire[15:0] instruction;

output wire[7:0] immediate;

reg[2:0] counter;


parameter ADC_Immediate =8'h69;

/* LIST OF CONTROL SIGNALS
    cache w_rd (write or read cache);
    external memory access:en, pc_data,w_rd;
    program counter: increment,branch,lower_byte;
    registers:x_con,y_con,accumulator_con,status_con,stack_pointer_con;
    alu:op;
*/
always @(posedge rst) begin
    counter=0;
end

always @(posedge clk_2) begin
    case (instruction[7:0])
        ADC_Immediate:  begin
                            case (counter)
                                0: 
                            endcase
                        end 
        default: 
    endcase
end
    
endmodule