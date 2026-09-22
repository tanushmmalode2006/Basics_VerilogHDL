module reg4bit_tb;

reg [3:0] D;
reg CLK;
reg RESET;
wire [3:0] Q;

reg4bit uut (
    .D(D),
    .CLK(CLK),
    .RESET(RESET),
    .Q(Q)
);


initial begin
    $monitor("D = %b | CLK = %b | RESET = %b | Q = %b", D, CLK, RESET, Q);

    // Initial values
    D = 4'b0000;
    CLK = 0;
    RESET = 0;

    // Apply D = 1010
    #10;
    D = 4'b1010;

    // Rising edge -> Q should become 1010
    #5;
    CLK = 1;
    #5;
    CLK = 0;

    // Apply D = 0101
    #10;
    D = 4'b0101;

    // Rising edge -> Q should become 0101
    #5;
    CLK = 1;
    #5;
    CLK = 0;

    // Apply RESET = 1
    RESET = 1;

    // Rising edge -> Q should become 0000
    #5;
    CLK = 1;
    #5;
    CLK = 0;

    // Remove RESET
    RESET = 0;

    // Apply D = 1111
    D = 4'b1111;

    // Rising edge -> Q should become 1111
    #5;
    CLK = 1;
    #5;
    CLK = 0;

    $finish;
end

endmodule
