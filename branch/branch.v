module branch (rst,clk_1,clk_2,branch_uncon,branch_con,
                branch_op,
                status,data_bus,pc_inc_decoder,
                branch,lower_byte,normal);

input  wire rst,clk_1,clk_2,branch_uncon,branch_con,pc_inc_decoder,lower_byte_decoder;
input wire[2:0] branch_op;
input wire[7:0] status,data_bus;
output wire branch,lower_byte,normal,pc_increment;

reg branch_internal,test,pc_inc_internal;
reg lower_byte_buffer;
reg[1:0] reset_counter;

parameter bcc = 0, // Branch if carry flag clear
    bcs = 1, // Branch if carry flag set
    beq = 2, // Branch if zero flag set
    bmi = 3, // Branch if negative flag set
    bne = 4, // Branch if zero flag clear
    bpl = 5, // Branch if negative flag clear
    bvc = 6, // Branch if overflow flag clear
    bvs = 7; // Branch if overflow flag set

assign lower_byte=lower_byte_buffer|(normal&lower_byte_decoder);
assign normal=reset_counter==0;
assign branch=branch_uncon|branch_con&test|branch_internal;
assign pc_increment=pc_inc_internal?1:pc_inc_decoder;

always @(posedge rst ) begin        //reset sequence
    reset_counter=2;
    lower_byte_buffer=0;
    branch_internal=0;
    pc_inc_internal=1;
end

always @(negedge clk_2 ) begin    
    if(!rst) begin  
        if(reset_counter ==2) begin     //branching to reset vector
            lower_byte_buffer=1;
            reset_counter=1;
            branch_internal=0;
            pc_inc_internal=1;
        end
        else if (reset_counter==1) begin
            lower_byte_buffer=0;
            reset_counter=0;
            branch_internal=1;
            pc_inc_internal=0;
        end
        else if(reset_counter==0) begin
            lower_byte_buffer=0;
            branch_internal=0;
        end
        case(branch_op)             //status reg contents : carry zero interrput_disable decimal_mode break_cmd overflow negative
            bcc: test = ~status[7];
            bcs: test = status[7];
            beq: test = status[6];
            bmi: test = status[0];
            bne: test = ~status[6];
            bpl: test = ~status[0];
            bvc: test = status[2];
            bvs: test = status[2];
        endcase
    end
end

endmodule