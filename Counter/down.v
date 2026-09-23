module down_counter_4bit(
    input CLK,
    input RESET,
    output reg [3:0] Q
);

always @(posedge CLK) begin

    if (RESET)
        Q <= 4'b1111;

    else
        Q <= Q - 1'b1;

end

endmodule