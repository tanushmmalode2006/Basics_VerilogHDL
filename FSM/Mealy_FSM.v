// In a Mealy FSM, the output depends on current state + current input.

// For 1011, we can use 4 states:

// S0 → Nothing matched
// S1 → Received 1
// S2 → Received 10
// S3 → Received 101

// When we are in S3 and receive X = 1, we have received 1011, so:

// DETECT = 1


module sequence_detector_mealy(
    input CLK,
    input RESET,
    input X,
    output reg DETECT
);

localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;
localparam S3 = 2'b11;

reg [1:0] state;
reg [1:0] next_state;


// State register
always @(posedge CLK) begin

    if (RESET)
        state <= S0;
    else
        state <= next_state;

end


// Next-state logic
always @(*) begin

    case (state)

        // Nothing matched
        S0: begin
            if (X)
                next_state = S1;
            else
                next_state = S0;
        end

        // Received 1
        S1: begin
            if (X)
                next_state = S1;
            else
                next_state = S2;
        end

        // Received 10
        S2: begin
            if (X)
                next_state = S3;
            else
                next_state = S0;
        end

        // Received 101
        S3: begin
            if (X)
                next_state = S1;
            else
                next_state = S0;
        end

        default:
            next_state = S0;

    endcase

end


// Mealy output logic
always @(*) begin

    if ((state == S3) && (X == 1'b1))
        DETECT = 1'b1;
    else
        DETECT = 1'b0;

end

endmodule