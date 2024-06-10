module adder(a,b,cin,s,cout,over);
input wire cin;
input wire[7:0] a,b;
output wire cout,over;
output wire[7:0] s;
wire c1,c2,c3,cov;
two_bit_adder a1(a[1-:2],b[1-:2],cin,s[1-:2],c1);
two_bit_adder a2(a[3-:2],b[3-:2],c1,s[3-:2],c2);
two_bit_adder a3(a[5-:2],b[5-:2],c2,s[5-:2],c3);
two_bit_adder_ov a4(a[7-:2],b[7-:2],c3,s[7-:2],cout,cov);
assign over=cov^cout;
endmodule

module two_bit_adder(a,b,cin,s,cout);
input wire cin;
input wire[1:0] a,b;
output wire cout;
output wire[1:0] s;
wire c1;
assign s[0]=a[0]^b[0]^cin;
assign c1=(a[0]&b[0])+(a[0]&cin)+(b[0]&cin);
assign s[1]=(a[1]^b[1]^c1);
assign cout=(a[1]&b[1])+((a[0]&a[1]&b[0])+(a[0]&b[0]&b[1])+(a[0]&a[1]&cin)+(a[0]&b[1]&cin)+(a[1]&b[0]&cin)+(b[0]&b[1]&cin));
endmodule

module two_bit_adder_ov(a,b,cin,s,cout,cov);
input wire cin;
input wire[1:0] a,b;
output wire cout,cov;
output wire[1:0] s;

assign s[0]=a[0]^b[0]^cin;
assign cov=(a[0]&b[0])+(a[0]&cin)+(b[0]&cin);
assign s[1]=(a[1]^b[1]^cov);
assign cout=(a[1]&b[1])+((a[0]&a[1]&b[0])+(a[0]&b[0]&b[1])
            +(a[0]&a[1]&cin)+(a[0]&b[1]&cin)+(a[1]&b[0]&cin)
            +(b[0]&b[1]&cin));
endmodule