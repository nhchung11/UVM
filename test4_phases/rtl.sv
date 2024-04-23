module Adder (
    input clk,
    input logic [7:0] A,
    input logic [7:0] B,
    output logic [15:0] sum
);

    always @(*) begin
        sum = A + B;
    end
endmodule
