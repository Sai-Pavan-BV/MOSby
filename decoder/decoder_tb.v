`timescale 1ps/1ps
`include "decoder.v"
`include "../clk_gen/clk_gen.v"

module decoder_tb();
reg rst,clk,flush,normal;
reg [7:0] instruction;

wire w_rd,       //memory write or read
            pc_data,    //address from pc or data_bus
            increment,lower_byte,   //program counter controls
            x_con,y_con,accumulator_con,status_con,stack_pointer_con,      //registers controls
            branch_uncon,branch_con;              //branch controls

wire[3:0] alu_op;            //alu controls
wire [2:0] branch_op;        //branch controls
wire[1:0] operand_mux_con;    //control for operand_2 input for alu
wire clk_1,clk_2;
decoder d(
    rst,clk_1,clk_2,flush,normal,
    instruction,
     w_rd,pc_data,increment,lower_byte,
     x_con,y_con,accumulator_con,status_con,stack_pointer_con,
     branch_uncon,branch_con,
    alu_op,branch_op,operand_mux_con
);
clk_gen cg(clk,rst,clk_1,clk_2);

always #5 clk=~clk;

initial begin
    $dumpfile("decoder.vcd");
    $dumpvars(1,d);
    clk=0;
    rst=0;
    flush=0;
    normal=1;
    instruction=$random;
    wait(clk==1);
    #10 rst=1;
    #5 rst=0;
    #30
    instruction=$random;
    #30
    instruction=8'h69;
    #30
    instruction=8'hEA;
    #30
    $finish;
end

endmodule
