module demux1to8_tb;

reg I;
reg [2:0] s;
wire [7:0] y;

demux1to8 uut (
    .I(I),
    .s(s),
    .y(y)
);

initial begin

    $monitor("I = %b | s = %b | y = %b", I, s, y);

    I = 1'b1;

    s = 3'b000; #10;
    s = 3'b001; #10;
    s = 3'b010; #10;
    s = 3'b011; #10;
    s = 3'b100; #10;
    s = 3'b101; #10;
    s = 3'b110; #10;
    s = 3'b111; #10;

    I = 1'b0;

    s = 3'b000; #10;
    s = 3'b101; #10;

    $finish;

end

endmodule