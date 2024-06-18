`include "register.v"
`include "../clk_gen/clk_gen.v"
module register_tb ();

reg rst,clk,
    x_con,y_con,accumulator_con,
    stack_pointer_con,status_con;

reg [7:0] data_in,data_status;

wire [7:0] data_out_x,data_out_y,data_out_accumulator,
    data_out_sp,data_out_status;

wire clk_1,clk_2;

register r(rst,clk_1,clk_2,x_con,y_con,accumulator_con,
    stack_pointer_con,status_con,

    data_in,data_status,

    data_out_x,data_out_y,data_out_accumulator,
    data_out_sp,data_out_status
);
clk_gen cg (clk,rst,clk_1,clk_2);

always #5 clk=~clk;
initial begin
    $dumpfile("register.vcd");
    $dumpvars(1,r);
    $dumpvars(1,cg);
    clk=0;
    rst=0;
    x_con=0;
    y_con=0;
    accumulator_con=0;
    stack_pointer_con=0;
    status_con=0;

    data_in=$random;
    data_status=$random;

    #10;
    rst=1;
    #15;
    rst=0;
    #15
    x_con=1;
    #40
    x_con=0;
    y_con=1;
    #40;
    y_con=0;
    accumulator_con=1;
    #40;
    accumulator_con=0;
    stack_pointer_con=1;
    #40;
    stack_pointer_con=0;
    status_con=1;
    #50
    $finish;
end

endmodule