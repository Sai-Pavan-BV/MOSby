module pc(clk,rst,branch,increment,bra_add,address);
input wire clk,rst,branch,increment;
input wire [15:0] bra_add;
output reg [15:0] address;
always @(rst) begin
    if (rst) begin
        assign address=16'hFFCA;
    end
    else begin 
        deassign address;
    end
end
always @(posedge clk) begin
    if(branch) address=bra_add;
    else if(increment) address=address+1;
    else address=address;
end
endmodule