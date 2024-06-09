`timescale 1ps/1ps
module freq_div(clk,clk_1,clk_2,clk_3);
input wire clk;
output wire clk_1,clk_2,clk_3;
reg[1:0] counter;
initial counter=0;
always @(posedge clk) begin
    counter=counter+1;
end
assign clk_1=counter==1;
assign clk_2=counter==2;
assign clk_3=counter==3;
endmodule