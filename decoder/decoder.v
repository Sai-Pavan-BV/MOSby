module decoder (
    rst,clk_1,clk_2,
    in
);

input wire rst,clk_1,clk_2;
input wire[15:0] instruction;

output wire[7:0] immediate;

reg[2:0] counter;


parameter ADC_Immediate =8'h69;

always @(posedge rst) begin
    counter=0;

end

always @(posedge clk_2) begin
    case (instruction[7:0])
        ADC_Immediate:  begin
                            case (counter)
                                0: 
                            endcase
                        end 
        default: 
    endcase
end
    
endmodule