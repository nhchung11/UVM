`include "uvm_macros.svh"
program automatic test_program;
    import uvm_pkg::*;
    initial begin
        `uvm_info("DEMO", "Hello world", UVM_MEDIUM);
    end
endprogram