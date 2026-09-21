module encoder(
    input I0,
    input I1,
    input I2,
    input I3,
    output Y0,
    output Y1
);

assign Y1 = I2 | I3;
assign Y0 = I1 | I3;

endmodule