`timescale 1ps/1ps  

module full_adder_tb;

reg a,b,cin;
wire s,cout;

full_adder uut (
    .a(a),
    .b(b),
    .cin(cin),
    .s(s),
    .cout(cout)
);

initial begin

$monitor("Time=%0t | A=%b B=%b Cin=%b | S=%b Cout=%b", $time, a, b, cin, s, cout);

// $dumpfile("full_adder.vcd");
// $dumpvars(0, full_adder_tb);

a = 0; b = 0; cin = 0; #10;    
a = 0; b = 0; cin = 1; #10;
a = 0; b = 1; cin = 0; #10;
a = 0; b = 1; cin = 1; #10;
a = 1; b = 0; cin = 0; #10;
a = 1; b = 0; cin = 1; #10;
a = 1; b = 1; cin = 0; #10;
a = 1; b = 1; cin = 1; #10;
$finish;

end
endmodule