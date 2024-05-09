`ifndef SCOREBOARD
`define SCOREBOARD
`include "packet.sv"

import uvm_pkg::*;
class scoreboard extends uvm_component;
    byte data_transmitted [$];
    byte data_DUT_received [$];
    byte data_received [$];
    byte FIFO_status;

    `uvm_component_utils(scoreboard)
    virtual intf my_intf;

    uvm_analysis_imp #(packet, scoreboard) scoreboard_analysis_imp;

    // CONSTUCTOR
    function new(string name = "scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // BUILD PHASE
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "SCOREBOARD BUILD PHASE", UVM_MEDIUM)
        super.build_phase(phase);
        scoreboard_analysis_imp = new("scoreboard_analysis_imp", this); 

        if(!uvm_config_db #(virtual intf)::get(this, "*", "my_intf", my_intf))
            `uvm_fatal("NOVIF", "Virtual interface not set")
    endfunction

    // EXTRACT PHASE
    virtual function void extract_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "---------------------------------------", UVM_MEDIUM)
        `uvm_info(get_name(), "SCOREBOARD EXTRACT PHASE", UVM_MEDIUM)
        `uvm_info(get_name(), $sformatf("Size of data DUT received queue: %0d", data_DUT_received.size()), UVM_MEDIUM)
        foreach (data_DUT_received[i]) begin
            `uvm_info(get_name(), $sformatf("DUT received: %0d", data_DUT_received[i]), UVM_MEDIUM)
        end

        `uvm_info(get_name(), $sformatf("Size of actual data transmitted queue: %0d", data_transmitted.size()), UVM_MEDIUM)
        foreach (data_transmitted[i]) begin
            `uvm_info(get_name(), $sformatf("Transmitted data: %0d", data_transmitted[i]), UVM_MEDIUM)
        end
        `uvm_info(get_name(), $sformatf("Size of received data queue: %0d", data_received.size()), UVM_MEDIUM)  
        `uvm_info(get_name(), $sformatf("FIFO status: %0h (hex)", FIFO_status), UVM_MEDIUM)
        // `uvm_info(get_name(), $sformatf("At time: %0t FIFO status: %0d", $time, FIFO_status), UVM_MEDIUM)
    endfunction

    // CHECK PHASE
    virtual function void check_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "---------------------------------------", UVM_MEDIUM)
        `uvm_info(get_name(), "SCOREBOARD CHECK PHASE", UVM_MEDIUM)
        if (data_transmitted.size() != data_DUT_received.size()) begin
            `uvm_error(get_name(), "*  ERROR  *Data queue size mismatch")
            foreach (data_DUT_received[i]) begin
                if (data_transmitted[i] != data_DUT_received[i])     
                    `uvm_error(get_name(), $sformatf("Data mismatch at index %0d", i))
            end
        end
        else begin
            `uvm_info(get_name(), "*  INFO  *Data queue size match", UVM_MEDIUM)
            foreach (data_transmitted[i]) begin
                if (data_transmitted[i] != data_DUT_received[i])
                    `uvm_error(get_name(), $sformatf("Data mismatch at index %0d", i))
            end
        end
    endfunction

    // WRITE METHOD
    virtual function void write(packet my_packet);
        if (my_packet.PADDR == 4)
            data_transmitted.push_back(my_packet.PWDATA);
    endfunction
endclass: scoreboard
`endif
