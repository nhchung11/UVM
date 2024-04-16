`ifndef ENV
`define ENV

`include "uvm_macros.svh"
// `include "agent.sv"
import uvm_pkg::*;
class env extends uvm_env;
    `uvm_component_utils(env)
    agent my_agent;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction: 

    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "Start build phase", UVM_MEDIUM)
        my_agent = agent::type_id::create("my_agent", this);
    endfunction

    // // CONNECT PHASE
    // function void connect_phase(uvm_phase phase);

    // endfunction

    // // RUN PHASE
    // task run_phase(uvm_phase phase);

    // endtask
endclass: env;
`endif 