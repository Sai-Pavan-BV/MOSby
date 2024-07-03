module r_shift(
    en,sh_r,cin,operand,
    cout,result
);
input wire en,sh_r,cin;
input wire[7:0] operand;
output wire[7:0] result;
output wire cout;
wire cout_buff;

wire[7:0] result_buff;

assign {result_buff,cout_buff}=sh_r?{1'b0,operand}:{cin,operand};

assign result=en?result_buff:8'hzz;
assign cout=en?cout_buff:1'bz;


endmodule