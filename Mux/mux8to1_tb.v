module mux8to1_tb;

reg [7:0] I;
reg [2:0] sel;
wire y;

mux8to1 uut (
    .I(I),
    .sel(sel),
    .y(y)
);

initial begin

    $monitor("I = %b | sel = %b | y = %b", I, sel, y);


    I = 8'b10110100;

    sel = 3'b000;
    #10;

    sel = 3'b001;
    #10;

    sel = 3'b010;
    #10;

    sel = 3'b011;
    #10;

    sel = 3'b100;
    #10;

    sel = 3'b101;
    #10;

    sel = 3'b110;
    #10;

    sel = 3'b111;
    #10;

    $finish;

end

endmodule