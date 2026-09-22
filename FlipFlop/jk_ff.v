module jk_ff(
    input J,
    input K,
    input CLK,
    output reg Q
);

always @(posedge CLK) begin

    if (J == 1'b0 && K == 1'b0)
        Q <= Q;

    else if (J == 1'b0 && K == 1'b1)
        Q <= 1'b0;

    else if (J == 1'b1 && K == 1'b0)
        Q <= 1'b1;

    else
        Q <= ~Q;

end

endmodule