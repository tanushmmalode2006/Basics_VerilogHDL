module d_latch_tb;

reg D;
reg EN; 
wire Q;

d_latch uut (
    .D(D),
    .EN(EN),
    .Q(Q)
);

initial begin
    $monitor("D = %b | EN = %b | Q = %b", D, EN, Q);

    D = 0; EN = 0; #10;
    D = 1; EN = 0; #10;
    D = 0; EN = 1; #10;
    D = 1; EN = 1; #10;

    $finish;
end

endmodule