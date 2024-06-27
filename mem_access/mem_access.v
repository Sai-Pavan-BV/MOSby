module mem_access (rst,clk_1,clk_2,en,pc_data,w_rd,
                    address,pc,
                    data_out,data_bus,
                    address_out);
input wire rst,clk_1,clk_2,en,pc_data,w_rd;
input wire[15:0] address,pc;
inout data_out,data_bus;
output wire[15:0] address_out;
reg[7:0] data_out_buff,data_bus_buff;

assign address_out=(!rst&en)?(pc_data?pc:address):16'hzzzz;
assign data_out=(!rst&en&w_rd)?data_out_buff:8'hzz;
assign data_bus=(!rst&en&!w_rd)?data_bus_buff:8'hzz;

always @(posedge rst ) begin
    data_bus_buff<=0;
    data_out_buff<=0;
end
always @(posedge en ) begin
    if(clk_1) begin
        if(w_rd) begin //write
            data_out_buff=data_bus;
        end
    end
end
always @(posedge clk_2 ) begin
    if (en) begin
        if(!w_rd) begin //read
        data_bus_buff=data_out;
        end
    end
end
endmodule