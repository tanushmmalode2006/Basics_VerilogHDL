module piso_4bit(
    input [3:0] D,
    input LOAD,
    input CLK,
    output SO
);

reg [3:0] Q;

always @(posedge CLK) begin

    if (LOAD)
        Q <= D;

    else begin
        Q[0] <= Q[1];
        Q[1] <= Q[2];
        Q[2] <= Q[3];
        Q[3] <= 1'b0;
    end

end

assign SO = Q[0];

endmodule