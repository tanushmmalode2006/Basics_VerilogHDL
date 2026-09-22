module reg4bit(
    input [3:0] D,
    input CLK,
    input RESET,
    output reg [3:0] Q
);

always @(posedge CLK) begin

    if (RESET)
        Q <= 4'b0000;

    else
        Q <= D;

end

endmodule