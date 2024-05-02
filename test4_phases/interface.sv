`ifndef INTERF
`define INTERF

interface intf(input logic clk);
    logic [7:0] input_1;
    logic [7:0] input_2;
    logic [15:0] output_3;
    logic [15:0] DUT_output;

    always @* begin
        output_3 = input_1 + input_2;
    end
endinterface
`endif 