`include "uvm_macros.svh"
import uvm_pkg::*;

module top();
    Adder dut();
    initial begin
        run_test("test");
    end
endmodule
