module Adder (
    input logic [7:0] A,
    input logic [7:0] B,
    output logic [8:0] sum
);

    always_comb begin
        sum = A + B;
    end
endmodule
