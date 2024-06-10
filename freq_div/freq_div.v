`timescale 1ps/1ps
module freq_div(clk,rst,clk_1,clk_2);
input wire clk,rst;
output wire clk_1,clk_2;
reg counter;
always @(posedge clk) begin
    counter=counter+1;
end
always @(rst) begin
    if(rst) assign counter=0;
    else deassign counter;
end
assign clk_1=counter==0;
assign clk_2=counter==1;
endmodule