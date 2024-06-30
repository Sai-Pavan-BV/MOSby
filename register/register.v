module register (
    rst,clk_1,clk_2,
    x_con,y_con,accumulator_con,
    stack_pointer_con,status_con,

    data_in,data_status,

    data_out_x,data_out_y,data_out_accumulator,
    data_out_sp,data_out_status


);
input wire rst,clk_1,clk_2,
    x_con,y_con,accumulator_con,
    stack_pointer_con,status_con;

input wire [7:0] data_in,data_status;

output wire [7:0] data_out_x,data_out_y,data_out_accumulator,
    data_out_sp,data_out_status;
reg[7:0] x,y,accumulator,stack_pointer,status;
always @(posedge rst) begin
    x<=0;
    y<=0;
    accumulator<=0;
    stack_pointer<=0;
    status<=0;
end

always @(negedge clk_2 ) begin
    if(accumulator_con) accumulator=data_in;
    else if(x_con) x=data_in;
    else if(y_con) y=data_in;
    else if(stack_pointer_con) stack_pointer=data_in;

    if(status_con) status=data_status;

end


assign data_out_x=x;
assign data_out_y=y;
assign data_out_sp=stack_pointer;
assign data_out_status=status;
assign data_out_accumulator=accumulator;
endmodule