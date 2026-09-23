// 0000 1000 1100 1110 1111 0111 0011 0001 0000


module johnson_counter_4bit(
    input CLK,
    input RESET,
    output reg [3:0] Q
);

always @(posedge CLK) begin

    if (RESET)
        Q <= 4'b0000;

    else begin
        Q[3] <= Q[2];
        Q[2] <= Q[1];
        Q[1] <= Q[0];
        Q[0] <= ~Q[3];
    end

end

endmodule
