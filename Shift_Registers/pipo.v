// Data enters all at once and comes out all at once.
// This is same as 4bit reg

module pipo_4bit(
    input [3:0] D,
    input CLK,
    output reg [3:0] Q
);

always @(posedge CLK) begin
    Q <= D;
end

endmodule