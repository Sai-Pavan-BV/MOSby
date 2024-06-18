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
    #10;
    rst=1;
    #15;
    rst=0;
    #100
    $finish;
end

endmodule