
module alu_tb;

reg [3:0] A;
reg [3:0] B;
reg [2:0] opcode;

wire [3:0] result;
wire carry;
wire zero;
wire negative;
wire overflow;

alu uut(
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .carry(carry),
    .zero(zero),
    .negative(negative),
    .overflow(overflow)
);

initial begin

$monitor("A=%b B=%b opcode=%b result=%b carry=%b zero=%b negative=%b",
         A, B, opcode, result, carry, zero, negative);


    // Addition: 7 + 3 = 10
    A = 4'b0111;
    B = 4'b0011;
    opcode = 3'b000;
    #10;

    // Subtraction: 7 - 3 = 4
    opcode = 3'b001;
    #10;

    // AND
    A = 4'b1100;
    B = 4'b1010;
    opcode = 3'b010;
    #10;

    // OR
    opcode = 3'b011;
    #10;

    // XOR
    opcode = 3'b100;
    #10;

    // Comparison: A > B
    A = 4'b1001;
    B = 4'b0110;
    opcode = 3'b101;
    #10;

    $finish;

end

endmodule