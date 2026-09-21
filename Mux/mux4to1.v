module mux4to1(
    input [3:0] I,
    input [1:0] sel,
    output y
);

always @(*) begin
    y = 1'b0;
    y = I[sel];
end

endmodule