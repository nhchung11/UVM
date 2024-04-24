`ifndef SCOREBOARD
`define SCOREBOARD
`include "packet.sv"

import uvm_pkg::*;
class scoreboard extends uvm_component;
    byte data_transmitted [$];
    byte data_DUT_received [$];

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
        if (my_packet.PADDR == 4)
            data_transmitted.push_back(my_packet.PWDATA);
    endfunction

    virtual function void extract_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "SCOREBOARD EXTRACT PHASE", UVM_MEDIUM)
        `uvm_info(get_name(), $sformatf("Size of DUT saved queue: %0d", data_DUT_received.size()), UVM_MEDIUM)
        foreach (data_DUT_received[i]) begin
            `uvm_info(get_name(), $sformatf("DUT received: %0d", data_DUT_received[i]), UVM_MEDIUM)
        end

        `uvm_info(get_name(), $sformatf("Size of transmitted data queue: %0d", data_transmitted.size()), UVM_MEDIUM)
        foreach (data_transmitted[i]) begin
            `uvm_info(get_name(), $sformatf("Transmitted data: %0d", data_transmitted[i]), UVM_MEDIUM)
        end
    endfunction

    virtual function void check_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "SCOREBOARD CHECK PHASE", UVM_MEDIUM)
        if (data_transmitted.size() != data_DUT_received.size())
            `uvm_error(get_name(), "*  ERROR  *Data queue size mismatch")
        else begin
            foreach (data_transmitted[i]) begin
                if (data_transmitted[i] != data_DUT_received[i])
                    `uvm_error(get_name(), $sformatf("Data mismatch at index %0d", i))
            end
        end
    endfunction
    
endclass: scoreboard
`endif

