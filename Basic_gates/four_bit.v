module four_bit (
    input [3:0] a, b,
    input cin,
    output [3:0] s,
    output cout
);

wire cout0, cout1, cout2;

half_adder ha1 (
    .a(a[0]),
    .b(b[0]),
    .s(s[0]),
    .cout(cout0)
);

full_adder fa1 (
    .a(a[1]),
    .b(b[1]),
    .cin(cout0),
    .s(s[1]),
    .cout(cout1)
);

full_adder fa2 (
    .a(a[2]),
    .b(b[2]),
    .cin(cout1),
    .s(s[2]),
    .cout(cout2)
);

full_adder fa3 (
    .a(a[3]),
    .b(b[3]),
    .cin(cout2),
    .s(s[3]),
    .cout(cout)
);



endmodule