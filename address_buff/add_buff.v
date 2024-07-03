module add_buff (rst,clk_1,clk_2,
                access_type,
                data_bus,data_x,data_y,data_sp,
                pc_in,
                address
);

input wire rst,clk_1,clk_2,en;
input wire[1:0] access_type;
input wire [7:0] data_bus,data_x,data_y,data_sp;
input wire [15:0] pc_in;
output wire [15:0] address;

reg[15:0] address_buff;

parameter ZERO=0,STACK=1,PC=2,ABSOL=3;

always @(posedge clk_1) begin
    case (access_type) 
        ZERO: begin
            address_buff[15:8] <= 8'h00;
            address_buff[7:0] <= data_bus;
        end
        STACK: begin
            address_buff[15:8] <= 8'h01;
            address_buff[7:0] <= data_sp;
        end
        ABSOL: address_buff[7:0]<= data_bus;
    endcase
end

assign address[15:0] = access_type == PC ? pc_in : address_buff;
endmodule