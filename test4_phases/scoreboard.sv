`ifndef SCOREBOARD
`define SCOREBOARD
`include "packet.sv"

import uvm_pkg::*;
class scoreboard extends uvm_component;
    `uvm_component_utils(scoreboard)
    virtual intf my_intf;

    uvm_analysis_imp #(packet, scoreboard) packet_imp;
    function new(string name = "scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "SCOREBOARD BUILD PHASE", UVM_MEDIUM)
        super.build_phase(phase);
        packet_imp = new("packet_imp", this);   
        if(!uvm_config_db #(virtual intf)::get(this, "*", "my_intf", my_intf))
            `uvm_fatal("NOVIF", "Virtual interface not set")
    endfunction

    virtual function void write(packet my_packet);
        if (my_packet.output_3 == my_intf.DUT_output)
            `uvm_info(get_name(), "PASSED \n", UVM_LOW)
        else
            `uvm_info(get_name(), "FAILED \n", UVM_LOW)
        // `uvm_info(get_name(), $sformatf("SCOREBOARD: %0d", my_packet.output_3), UVM_LOW)
    endfunction
endclass: scoreboard
`endif

