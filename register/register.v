module register (
    rst,clk_1,clk_2,
    status_con,
    x_con,x_en,
    y_con,y_en,
    accumulator_con,accumulator_en,
    stack_pointer_con,


    data_in,
    data_in_status,
    
    data_out_x,data_out_y,
    data_out_accumulator,data_out_stack_pointer,
    data_out_status
    
);

input wire rst,clk_1,clk_2, status_con,x_con,x_en,y_con,y_en,accumulator_con,accumulator_en,stack_pointer_con;

input wire[7:0]    data_in,data_in_status;
    
output[7:0]    data_out_x,data_out_y,data_out_accumulator,data_out_stack_pointer,data_out_status;

reg[7:0] x,y,accumulator,stack_pointer,status;

//status reg contents : carry zero interrput_disable decimal_mode break_cmd overflow negative

always @(posedge rst,posedge clk_1,posedge clk_2) begin
    if(rst) begin   
        x=0;
        y=0;
        accumulator=0;
        stack_pointer=8'hff;
        status=0;
    end
    else begin
        if(clk_2) begin
            if(accumulator_con) accumulator=data_in;
            else if(x_con) x=data_in;
            else if (y_con) y=data_in;
            else if(stack_pointer_con) stack_pointer=data_in;
        end
    end

end
    
endmodule