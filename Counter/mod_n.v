// 0 → 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9 → 0

module mod10_counter(
    input CLK,
    input RESET,
    output reg [3:0] Q
);

always @(posedge CLK) begin

    if (RESET)
        Q <= 4'b0000;

    else if (Q == 4'b1001)
        Q <= 4'b0000;

    else
        Q <= Q + 1'b1;

end

endmodule