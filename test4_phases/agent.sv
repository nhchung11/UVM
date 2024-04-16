`ifndef AGENT
`define AGENT

`include "uvm_macros.svh"
`include "driver.sv"
`include "monitor.sv"
`include "sequencer.sv"
import uvm_pkg::*;

class agent extends uvm_agent;
    `uvm_component_utils(agent)
    driver my_driver;
    seqr my_sequencer;
    monitor my_monitor;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        my_driver = driver::type_id::create("my_driver", this);
        my_sequencer = seqr::type_id::create("my_sequencer", this);
        my_monitor = monitor::type_id::create("my_monitor", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        my_driver.seq_item_port.connect(my_sequencer.seq_item_export);
    endfunction
endclass
`endif