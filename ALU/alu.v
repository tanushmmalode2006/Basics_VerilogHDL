
module alu(
    input [3:0] A,
    input [3:0] B,
    input [2:0] opcode,
    output reg [3:0] result,
    output reg carry,
    output reg zero,
    output reg negative,
    output reg overflow
);

always @(*) begin

    // Default values
    result = 4'b0000;
    carry = 0;
    overflow = 0;

    case(opcode)

        3'b000: begin
            // Addition
            {carry, result} = A + B;
        end

        3'b001: begin
            // Subtraction
            {carry, result} = A - B;
        end

        3'b010: begin
            // AND
            result = A & B;
        end

        3'b011: begin
            // OR
            result = A | B;
        end

        3'b100: begin
            // XOR
            result = A ^ B;
        end

        3'b101: begin
            // Comparison
            if(A > B)
                result = 4'b0001;
            else if(A == B)
                result = 4'b0000;
            else
                result = 4'b1111;
        end

        default: begin
            result = 4'b0000;
        end

    endcase

    // Common flags
    zero = (result == 4'b0000);
    negative = result[3];

end

endmodule