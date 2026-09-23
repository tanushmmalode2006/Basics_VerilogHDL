module up_counter_4bit(
    input CLK,
    output reg [3:0] Q
);

initial
    Q = 4'b0000;

always @(posedge CLK) begin
    Q <= Q + 1'b1;
end

endmodule