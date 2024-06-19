module mem_access ();
input wire clk_1,clk_2,rst,r_w,pc_data,address_ready;
input wire[15:0] pc;
inout[7:0] data_bus;
inout[7:0] data;
output wire[15:0] address;

reg[7:0] address_buff;
reg[15:0] address_reg;
reg[7:0] data,data_bus;
always @(negedge clk_1 ) begin
    if(pc_data) begin       //instruction fetch
        address_reg<=pc;
    end
    else begin
        if(address_ready) begin
            address_reg={data_bus,address_buff};
        end
        else begin
            address_buff<=data_bus;
        end
    end
end

always @(data,r_w) begin
    if()
end

assign address=address_reg;

endmodule