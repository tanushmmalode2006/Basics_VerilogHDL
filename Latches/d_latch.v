module d_latch(
    input D,
    input EN,
    output reg Q
);

always @(*) begin
    if (EN)
        Q = D;
end

endmodule