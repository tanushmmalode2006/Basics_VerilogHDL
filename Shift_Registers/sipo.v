// Data enters one bit at a time, but after shifting, we can read all the stored bits at once.

module sipo_4bit(
    input SI,
    input CLK,
    output reg [3:0] Q
);

always @(posedge CLK) begin
    Q[3] <= SI;
    Q[2] <= Q[3];
    Q[1] <= Q[2];
    Q[0] <= Q[1];
end

endmodule