// In an asynchronous counter, only the first flip-flop gets the external clock. 
// The output of one flip-flop drives the clock of the next flip-flop.

module t_ff(
    input T,
    input CLK,
    input RESET,
    output reg Q
);

always @(posedge CLK or posedge RESET) begin

    if (RESET)
        Q <= 1'b0;
    else if (T)
        Q <= ~Q;

end

endmodule


module async_counter_4bit(
    input CLK,
    input RESET,
    output wire [3:0] Q
);

t_ff ff0(
    .T(1'b1),
    .CLK(CLK),
    .RESET(RESET),
    .Q(Q[0])
);

t_ff ff1(
    .T(1'b1),
    .CLK(Q[0]),
    .RESET(RESET),
    .Q(Q[1])
);

t_ff ff2(
    .T(1'b1),
    .CLK(Q[1]),
    .RESET(RESET),
    .Q(Q[2])
);

t_ff ff3(
    .T(1'b1),
    .CLK(Q[2]),
    .RESET(RESET),
    .Q(Q[3])
);

endmodule