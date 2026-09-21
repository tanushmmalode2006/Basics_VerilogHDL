module encoder_tb;

reg I0, I1, I2, I3;
wire Y0, Y1;

encoder uut (
    .I0(I0),
    .I1(I1),
    .I2(I2),
    .I3(I3),
    .Y0(Y0),
    .Y1(Y1)
);

initial begin

    $monitor("I0 = %b | I1 = %b | I2 = %b | I3 = %b | Y1 = %b | Y0 = %b",
              I0, I1, I2, I3, Y1, Y0);

    // No input active
    I0 = 0; I1 = 0; I2 = 0; I3 = 0; #10;

    // I0 active -> Y1Y0 = 00
    I0 = 1; I1 = 0; I2 = 0; I3 = 0; #10;

    // I1 active -> Y1Y0 = 01
    I0 = 0; I1 = 1; I2 = 0; I3 = 0; #10;

    // I2 active -> Y1Y0 = 10
    I0 = 0; I1 = 0; I2 = 1; I3 = 0; #10;

    // I3 active -> Y1Y0 = 11
    I0 = 0; I1 = 0; I2 = 0; I3 = 1; #10;

    $finish;

end

endmodule