module sr_ff(
    input S,
    input R,
    input CLK,
    output reg Q
);

always @(posedge CLK) begin

    if (S && !R)
        Q <= 1'b1;

    else if (!S && R)
        Q <= 1'b0;

    else if (!S && !R)
        Q <= Q;

    else
        Q <= 1'bx;

end

endmodule