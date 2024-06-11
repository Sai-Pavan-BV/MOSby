module mux_8x1 #(parameter width) (i0,i1,i2,i3,i4,i5,i6,i7,select,en,out);
input wire[width-1:0] i0,i1,i2,i3,i4,i5,i6,i7;
input wire[2:0] select;
output wire[width-1:0] out;
assign out=en?
            case (select)
                0:i0
                1:i1
                2:i2
                3:i3
                4:i4
                5:i5
                6:i6
                7:i7  
            endcase:(width)'dz;
endmodule