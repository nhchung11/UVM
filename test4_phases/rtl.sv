module Adder #(parameter WIDTH = 8) (
    input logic [WIDTH-1:0] A,
    input logic [WIDTH-1:0] B,
    output logic [WIDTH:0] sum
);

    always_comb begin
        sum = A + B;
    end
endmodule
