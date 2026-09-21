module four_bit_tb;
    
reg [3:0] a, b;
wire [3:0] s;
wire cout;

four_bit uut (
    .a(a),
    .b(b),
    .s(s),
    .cout(cout)
);

initial begin   
    a = 4'b1111; b = 4'b1111; #10;
    $display("A = %b, B = %b, Sum = %b, Cout = %b", a, b, s, cout);
    $finish;
end

endmodule
