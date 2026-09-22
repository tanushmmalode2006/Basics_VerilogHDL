// Data enters one bit at a time. Data comes out one bit at a time

module siso_4bit(           
    input SI,
    input CLK,
    output reg SO
);

reg [3:0] Q;

always @(posedge CLK) begin
    Q[3] <= SI;
    Q[2] <= Q[3];
    Q[1] <= Q[2];
    Q[0] <= Q[1];
end

assign SO = Q[0];

endmodule