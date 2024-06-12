module mux_8x1 #(parameter width=8) (i0,i1,i2,i3,i4,i5,i6,i7,select,en,out);
input wire en;
input wire[width-1:0] i0,i1,i2,i3,i4,i5,i6,i7;
input wire[2:0] select;
output wire[width-1:0] out;
assign out=en?(select==0)?i0:
            (select==1)?i1:
            (select==2)?i2:
            (select==3)?i3:
            (select==4)?i4:
            (select==5)?i5:
            (select==6)?i6:i7
            :{width{1'bz}};
endmodule

module mux_2x1 #(parameter width=8) (
    en,sel,i0,i1,out
);
input wire sel,en;
input wire[width-1:0] i0,i1;
output wire[width-1:0] out;
assign out=en?sel?i1:i0:8'hzz;
    
endmodule

// module mux_tb();
// reg en;
// reg[7:0] i0,i1,i2,i3,i4,i5,i6,i7;
// reg[2:0] select;
// wire[7:0] out;
// mux_8x1 #(8) m(i0,i1,i2,i3,i4,i5,i6,i7,select,en,out);
// integer i;
// initial begin
//     $dumpfile("mux.vcd");
//     $dumpvars(1,m);
//     i0=$random;
//     i1=$random;
//     i2=$random;
//     i3=$random;
//     i4=$random;
//     i5=$random;
//     i6=$random;
//     i7=$random;
//     en=0;
//     #20
//     en=1;
//     for (i=0;i<8;i=i+1) begin
//         select=i;
//         #20;
//     end 
//     $finish;
// end
// endmodule