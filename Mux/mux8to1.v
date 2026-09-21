module mux8to1(
    input [7:0] I,
    input [2:0] sel,
    output  y
);

wire y0, y1;

mux4to1 mux0 (
    .I(I[3:0]),
    .sel(sel[1:0]),
    .y(y0)
);  

mux4to1 mux1 (
    .I(I[7:4]),
    .sel(sel[1:0]),
    .y(y1)
);

mux2to1 mux2 (
    .a(y0),
    .b(y1),
    .sel(sel[2]),
    .y(y)
);

endmodule