module demux1to8(
    input I,
    input [2:0] s,
    output  [7:0] y
);

wire [1:0] y_temp;

demux1to2 demux1to2_0 (
    .I(I),
    .s(s[0]),
    .y(y_temp)
);      

demux1to4 demux1to4_0 (
    .I(y_temp[0]),
    .s(s[2:1]),
    .y(y[3:0])
);

demux1to4 demux1to4_1 (
    .I(y_temp[1]),
    .s(s[2:1]),
    .y(y[7:4])
);

endmodule