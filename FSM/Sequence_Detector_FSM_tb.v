`timescale 1ns/1ps

module sequence_detector_tb;

reg CLK;
reg RESET;
reg X;

wire DETECT;


// Instantiate DUT
sequence_detector DUT (
    .CLK(CLK),
    .RESET(RESET),
    .X(X),
    .DETECT(DETECT)
);


// Clock generation
always #5 CLK = ~CLK;


// Test
initial begin

    $monitor("Time=%0t X=%b State=%b Detect=%b",
         $time, X, DUT.state, DETECT);

    // Initial values
    CLK = 0;
    RESET = 1;
    X = 0;

    // Keep reset active
    #10;
    RESET = 0;

    // Send 1
    X = 1;
    #10;

    // Send 0
    X = 0;
    #10;

    // Send 1
    X = 1;
    #10;

    // Send 1
    X = 1;
    #10;

    $finish;

end

endmodule