`include "uvm_macros.svh"
import uvm_pkg::*;

module top();
    intf my_intf();
    Adder dut();

    initial begin
        uvm_config_db#(virtual intf)::set(null, "*", "my_intf", my_intf);
    end

    initial begin
        run_test("test");
    end
endmodule
