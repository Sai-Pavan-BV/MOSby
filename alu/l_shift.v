module l_shift(
    clk,en,sh_r,operand,
    cout,result
);
input wire clk,en,sh_r;
input wire[7:0] operand;
output wire[7:0] result;
output wire cout;
reg cout_buff;

reg[7:0] result_buff;

always @(posedge clk ) begin
    cout_buff=operand[7];
    result_buff={operand[6:0],1'b0};
end

assign result=en?result_buff:8'hzz;
assign cout=en?cout_buff:1'bz;


endmodule