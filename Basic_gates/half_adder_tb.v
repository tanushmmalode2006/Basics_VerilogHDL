`timescale 1ns/1ps

module half_adder_tb;

reg a;
reg b;  
wire s;
wire c;

half_adder uut (
    .a(a),
    .b(b),
    .s(s),
    .c(c)
);

initial begin

$monitor("Time=%0t | A=%b B=%b | S=%b C=%b", $time, a, b, s, c);

$dumpfile("half_adder.vcd");
$dumpvars(0, half_adder_tb);

a = 0; b = 0;
#10;
a = 0; b = 1;
#10;
a = 1; b = 0;
#10;
a = 1; b = 1;
#10;
$finish;

end
endmodule