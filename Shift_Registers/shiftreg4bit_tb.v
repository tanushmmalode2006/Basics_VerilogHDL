module shiftreg4bit_tb;

reg SI;
reg CLK;
wire [3:0] Q;

shiftreg4bit uut (
    .SI(SI),
    .CLK(CLK),
    .Q(Q)
);

initial begin
$monitor("SI = %b | CLK = %b | Q = %b", SI, CLK, Q);

// Initial values
SI = 0;
CLK = 0;

// Start with 4-bit value 1010
// Send bits: 1, 0, 1, 0

SI = 1;
#5;
CLK = 1;
#5;
CLK = 0;

SI = 0;
#5;
CLK = 1;
#5;
CLK = 0;

SI = 1;
#5;
CLK = 1;
#5;
CLK = 0;

SI = 0;
#5;
CLK = 1;
#5;
CLK = 0;


// Now Q contains 1010
// Add new SI = 1
// 1010 -> 1101

SI = 1;
#5;
CLK = 1;
#5;
CLK = 0;


// Add new SI = 0
// 1101 -> 0110

SI = 0;
#5;
CLK = 1;
#5;
CLK = 0;


// Add new SI = 1
// 0110 -> 1011

SI = 1;
#5;
CLK = 1;
#5;
CLK = 0;

$finish;

end

endmodule