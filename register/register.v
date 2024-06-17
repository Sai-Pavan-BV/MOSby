module register (
    rst,clk_1,clk_2,

    data_in_x,data_in_y,
    data_in_accumulator,data_in_stack_pointer,
    data_in_status,
    
    data_out_x,data_out_y,
    data_out_accumulator,data_out_stack_pointer,
    data_out_status
    
);

input wire rst,clk_1,clk_2;

input wire[7:0]    data_in_x,data_in_y,data_in_accumulator,data_in_stack_pointer,data_in_status;
    
output wire[7:0]    data_out_x,data_out_y,data_out_accumulator,data_out_stack_pointer,data_out_status;

reg[7:0] x,y,accumulator,stack_pointer,status;

//status reg contents : carry zero interrput_disable decimal_mode break_cmd overflow negative

always @(rst) begin
    if(rst) begin   
        assign x=0;
        assign y=0;
        assign accumulator=0;
        assign stack_pointer=8'hff;
        assign status=0;
    end
    else begin
        deassign x;
        deassign y;
        deassign accumulator;
        deassign stack_pointer;
        deassign status;
    end

end
    
endmodule