`ifndef TEST
`define TEST

// `include "uvm_macros.svh"
// `include "environment.sv"
import uvm_pkg::*;

class test extends uvm_test;
    `uvm_component_utils(test)
    env my_env;

    // Constructor                                                                   
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        my_env = env::type_id::create("my_env", this);
    endfunction

    // // CONNECT PHASE
    // function void connect_phase(uvm_phase phase);

    // endfunction

    // // RUN PHASE
    // task run_phase(uvm_phase phase);

    // endtask
endclass

`endif 