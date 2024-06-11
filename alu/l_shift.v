module l_shift(
    en,sh_r,operand,
    ,cout,result
);
input wire en,sh_r;
input wire[7-:8] operand;
output wire[7-:8] result;

reg[7-:8] result_buff;

assign {cout_buff,result}={operand,1b'0}>>1



endmodule