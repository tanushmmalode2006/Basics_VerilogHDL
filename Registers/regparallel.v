module d_ff(
    input D,
    input CLK,
    input RESET,
    output reg Q
);

always @(posedge CLK) begin

    if (RESET)
        Q <= 1'b0;
    else
        Q <= D;

end
endmodule


module regparallel(
    input [3:0] D,
    input CLK,
    input RESET,
    output wire [3:0] Q             // Importannt concept wire is used here because the output of the module is driven by the internal flip-flops, not by a continuous assignment.
);
    
d_ff ff0(
    .D(D[0]),
    .CLK(CLK),
    .RESET(RESET),
    .Q(Q[0])
);
d_ff ff1(
    .D(D[1]),
    .CLK(CLK),
    .RESET(RESET),
    .Q(Q[1])
);
d_ff ff2(
    .D(D[2]),
    .CLK(CLK),
    .RESET(RESET),
    .Q(Q[2])
);
d_ff ff3(
    .D(D[3]),
    .CLK(CLK),
    .RESET(RESET),
    .Q(Q[3])
);

endmodule