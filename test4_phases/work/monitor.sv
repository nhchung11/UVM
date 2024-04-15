import uvm_pkg::*;

class monitor extends uvm_monitor
    `uvm_component_utils(monitor)
    function new(string name, uvm_component parent);
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
endclass: monitor