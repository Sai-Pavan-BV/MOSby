module clk_gen (
    clk,rst,
    clk_1,clk_2
);

input wire clk,rst;
output wire clk_1,clk_2;

reg[1:0] counter;

always @(posedge clk,posedge rst) begin
    if(rst) counter=0;
    else  counter=counter+1;
end
assign clk_1=counter==0?1:0;
assign clk_2=counter==2?1:0;
endmodule