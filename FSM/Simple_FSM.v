module simple_fsm(
    input CLK,
    input RESET,
    input X,
    output reg Q
);

localparam S0 = 1'b0;
localparam S1 = 1'b1;

reg state;
reg next_state;


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

        S0: begin
            if (X)
                next_state = S1;
            else
                next_state = S0;
        end

        S1: begin
            if (X)
                next_state = S0;
            else
                next_state = S1;
        end

        default:
            next_state = S0;

    endcase

end


// Output logic
assign Q = state;

endmodule