// 0001 0010 0100 1000 0001 0010

module ring_counter_4bit(
    input CLK,
    input RESET,
    output reg [3:0] Q
);

always @(posedge CLK) begin
    if (RESET)
        Q <= 4'b0001;
    else begin
        Q[3] <= Q[2];
        Q[2] <= Q[1];
        Q[1] <= Q[0];
        Q[0] <= Q[3];
    end
end

endmodule