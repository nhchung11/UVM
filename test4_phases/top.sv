`include "uvm_macros.svh"
import uvm_pkg::*;

module top();
    bit clk = 0;
    always #10 clk = ~clk;

    intf my_intf(clk);
    Adder dut
    (
        .clk(my_intf.clk),
        .A(my_intf.input_1),
        .B(my_intf.input_2),
        .sum(my_intf.output_3)
    );
    


    initial begin
        uvm_config_db#(virtual intf)::set(null, "*", "my_intf", my_intf);
        run_test("test");
    end
endmodule
