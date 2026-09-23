module up_counter_4bit_tb;

reg CLK;
wire [3:0] Q;

up_counter_4bit uut (
    .CLK(CLK),
    .Q(Q)
);

integer i;

initial begin

    $monitor("CLK = %b | Q = %b", CLK, Q);

    CLK = 0;

    for (i = 0; i < 20; i = i + 1) begin
        #5 CLK = 1;
        #5 CLK = 0;
    end

    $finish;

end

endmodule