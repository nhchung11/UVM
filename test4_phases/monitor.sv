`include "uvm_macros.svh"
// `include "sequence.sv"
import uvm_pkg::*;

class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)
    virtual intf my_intf;
    packet my_packet;
    uvm_analysis_port #(seq) mon_port;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        uvm_config_db #(virtual intf)::get(null, "*", "my_intf", my_intf);
        mon_port = new("Monitor port", this);
        my_packet = packet::type_id::create("my_packet");
    endfunction

    // CONNECT PHASE
    function void connect_phase(uvm_phase phase);

    endfunction

    // RUN PHASE
    task run_phase(uvm_phase phase);
        forever begin
            @(posedge my_intf.clk)
            my_packet.input_1 <= my_intf.input_1;
            my_packet.input_2 <= my_intf.input_2;
        end
    endtask
endclass: monitor