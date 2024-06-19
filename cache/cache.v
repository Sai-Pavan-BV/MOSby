module cache ();
input wire rst,clk_1,clk_2,w_en;
input wire [7:0] data_in;
output wire hit;
output [23:0] data_out;
reg[7:0] mem[127:0];
endmodule