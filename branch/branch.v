module branch ();
wire rst,clk_1,clk_2,branch_uncon,branch_con;
input wire[7:0] status,data_bus;
output wire branch,lower_byte;
reg lower_byte_buffer;
reg[1:0] reset_counter;

assign lower_byte=lower_byte_buffer;

always @(posedge rst ) begin
    reset_counter=2;
    lower_byte_buffer=0;
end
always @(negedge clk_2 ) begin
    if(reset_counter!=0) begin
        lower_byte_buffer=1;
        reset_counter=reset_counter-1;
    end
end
endmodule