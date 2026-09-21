module sr_latch_tb;

reg S;
reg R;
wire Q;

sr_latch uut (
    .S(S),
    .R(R),
    .Q(Q)
);

initial begin
    $monitor("S = %b | R = %b | Q = %b", S, R, Q);

    S = 0; R = 0; #10;
    S = 1; R = 0; #10;
    S = 0; R = 1; #10;
    S = 1; R = 1; #10;

    $finish;
end

endmodule
