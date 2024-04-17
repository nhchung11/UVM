`ifndef SCOREBOARD
`define SCOREBOARD
`include "packet.sv"

import uvm_pkg::*;
class scoreboard extends uvm_component;
    `uvm_component_utils(scoreboard)
    packet result;
    uvm_analysis_imp #(packet, scoreboard) packet_imp;
    function new(string name = "scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "SCOREBOARD BUILD PHASE", UVM_MEDIUM)
        super.build_phase(phase);
        packet_imp = new("packet_imp", this);   
    endfunction

    virtual function void write(packet my_packet);
        if (result.output_3 == my_packet.output_3)
            `uvm_info(get_name(), "PASSED", UVM_LOW)
        else
            `uvm_info(get_name(), "FAILED", UVM_LOW)
    endfunction
endclass: scoreboard
`endif


