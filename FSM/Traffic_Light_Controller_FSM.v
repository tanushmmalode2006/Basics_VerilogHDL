module traffic_light(
    input CLK,
    input RESET,
    input TIMER_DONE,

    output reg RED_LED,
    output reg GREEN_LED,
    output reg YELLOW_LED
);

localparam RED    = 2'b00;
localparam GREEN  = 2'b01;
localparam YELLOW = 2'b10;

reg [1:0] state;
reg [1:0] next_state;


// State register
always @(posedge CLK) begin

    if (RESET)
        state <= RED;
    else
        state <= next_state;

end


// Next-state logic
always @(*) begin

    case (state)

        RED: begin
            if (TIMER_DONE)
                next_state = GREEN;
            else
                next_state = RED;
        end

        GREEN: begin
            if (TIMER_DONE)
                next_state = YELLOW;
            else
                next_state = GREEN;
        end

        YELLOW: begin
            if (TIMER_DONE)
                next_state = RED;
            else
                next_state = YELLOW;
        end

        default:
            next_state = RED;

    endcase

end


// Output logic
always @(*) begin

    RED_LED = 1'b0;
    GREEN_LED = 1'b0;
    YELLOW_LED = 1'b0;

    case (state)

        RED:
            RED_LED = 1'b1;

        GREEN:
            GREEN_LED = 1'b1;

        YELLOW:
            YELLOW_LED = 1'b1;

        default:
            RED_LED = 1'b1;

    endcase

end

endmodule