module adder(en,a_s,a,b,cin,result,cout);
input wire en,a_s,cin;
input wire [7:0] a,b;
output wire cout;
output wire [7:0] result;
assign {cout,result}=en? a_s?a+b+cin:a-b-cin :9'bz;
endmodule

module full_adder(a_s,a,b,cin,r,cout);
input wire a_s,a,b,cin;
output wire r,cout;
assign r=(a_s?a:~a)^b^cin;
assign cout=(a_s?a:~a)&b|(a_s?a:~a)&cin|b&cin;
endmodule