module pc(clk,rst,branch,increment,lower_byte,bra_add,address);
input wire clk,rst,branch,increment,lower_byte;
input wire [7:0] bra_add;
output reg [15:0] address;
reg[7:0] address_buffer;
always @(posedge rst) begin
    address<=16'hFFCA;
    address_buffer<=0;
end
always @(posedge clk) begin
    if(!rst) begin
        if(branch) begin
            address={bra_add,address_buffer};
        end
        else if(increment) begin
            address=address+1;
        end
        else begin
            address=address;
        end
        if(lower_byte) begin
            address_buffer=bra_add;
        end
    end
end
endmodule