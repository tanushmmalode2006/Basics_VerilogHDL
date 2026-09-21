module d_ff_tb;

reg D;
reg CLK;
wire Q;

d_ff uut (
    .D(D),
    .CLK(CLK),
    .Q(Q)
);

initial begin
    $monitor("D = %b | CLK = %b | Q = %b", D, CLK, Q);

    // Initialize signals
    D = 0; CLK = 0; #10;
    D = 1; CLK = 0; #10;
    D = 0; CLK = 1; #10;
    D = 1; CLK = 1; #10;

    // Toggle clock
    CLK = 0; #5;
    CLK = 1; #5;
    CLK = 0; #5;
    CLK = 1; #5;

    $finish;
end 
endmodule