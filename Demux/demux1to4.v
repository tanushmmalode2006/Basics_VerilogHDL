module demux1to4(
    input I,
    input [1:0] s,
    output reg [3:0] y
);

always @(*) begin
    y = 4'b0000;
    y[s] = I;
end

endmodule