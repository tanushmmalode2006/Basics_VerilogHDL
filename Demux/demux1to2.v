module demux1to2(
    input I,    
    input s,
    output reg [1:0] y
);

always @(*) begin
    y[s] = I;
end

endmodule