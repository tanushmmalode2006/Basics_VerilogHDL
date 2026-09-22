module t_ff(
    input T,
    input CLK,
    output reg Q
);

always @(posedge CLK) begin

    if (T == 1'b0)
        Q <= Q;

    else
        Q <= ~Q;

end

endmodule