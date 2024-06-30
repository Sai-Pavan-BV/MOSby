module branch ();
wire rst,clk_1,clk_2,branch_uncon,branch_con;
input wire[7:0] status,data_bus;
output wire branch;
reg[1:0] reset_counter;
always @(posedge rst ) begin
    reset_counter=2;
end

endmodule