`ifndef DRIVER
`define DRIVER
`include "uvm_macros.svh"

import uvm_pkg::*;
class driver extends uvm_driver;
    int delay;
    `uvm_component_utils(driver)
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "Build phase", UVM_MEDIUM)
    endfunction
    
    task config_phase(uvm_phase phase);
        delay = 5;
        `uvm_info(get_name(), "Config phase start", UVM_MEDIUM)
        phase.raise_objection(this);
        #(delay);
        phase.drop_objection(this);
        `uvm_info(get_name(), "Config phase stop", UVM_MEDIUM)
    endtask

    task run_phase(uvm_phase phase);
        delay = 10;
        `uvm_info(get_name(), "Run phase start", UVM_MEDIUM)
        phase.raise_objection(this);
        #(delay);
        phase.drop_objection(this);
        `uvm_info(get_name(), "Run phase stop", UVM_MEDIUM)
    endtask

    function void shutdown_phase(uvm_phase phase);
        `uvm_info(get_name(), "Shutdown phase", UVM_MEDIUM)
    endfunction
endclass

`endif 

