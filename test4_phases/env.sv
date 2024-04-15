`ifdef ENV
`define ENV
`include "uvm_macros.svh"
import uvm_pkg::*;
class env extends uvm_env;
    `uvm_component_utils(env)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        
    endfunction

    // CONNECT PHASE
    function void connect_phase(uvm_phase phase);

    endfunction

    // RUN PHASE
    task run_phase(uvm_phase phase);

    endtask
endclass: env;
`endif 