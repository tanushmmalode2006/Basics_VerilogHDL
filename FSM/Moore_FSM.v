// For Moore FSM, the output depends only on the state.

// Therefore, we need an additional state:

// S0 → Nothing matched
// S1 → Received 1
// S2 → Received 10
// S3 → Received 101
// S4 → Received 1011

// When the FSM reaches S4:

// DETECT = 1

module sequence_detector_moore(
    input CLK,
    input RESET,
    input X,
    output reg DETECT
);

localparam S0 = 3'b000;
localparam S1 = 3'b001;
localparam S2 = 3'b010;
localparam S3 = 3'b011;
localparam S4 = 3'b100;

reg [2:0] state;
reg [2:0] next_state;


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
                next_state = S4;
            else
                next_state = S0;
        end

        // Received 1011
        S4: begin
            if (X)
                next_state = S1;
            else
                next_state = S0;
        end

        default:
            next_state = S0;

    endcase

end


// Moore output logic
always @(*) begin

    if (state == S4)
        DETECT = 1'b1;
    else
        DETECT = 1'b0;

end

endmodule