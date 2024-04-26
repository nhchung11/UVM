`ifndef MONITOR
`define MONITOR

`include "uvm_macros.svh"
`include "sequence.sv"
import uvm_pkg::*;

class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)
    virtual intf my_intf;
    uvm_analysis_port #(packet) monitor_analysis_port;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    // BUILD PHASE
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "MONITOR BUILD PHASE", UVM_MEDIUM)
        monitor_analysis_port = new("monitor_analysis_port", this);
        if (!uvm_config_db #(virtual intf)::get(this, "", "my_intf", my_intf))
            `uvm_fatal("MONITOR", "Virtual interface not set")
    endfunction: build_phase

    // // CONNECT PHASE
    // function void connect_phase(uvm_phase phase);
 
    // endfunction

    // RUN PHASE
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_name(), "MONITOR RUN PHASE", UVM_MEDIUM)
        forever begin
            packet my_packet = new;
            @(posedge my_intf.PENABLE);
            if (my_intf.PADDR == 4) begin
                my_packet.PADDR = my_intf.PADDR;
                my_packet.PWDATA = my_intf.PWDATA;
                // `uvm_info(get_name(), $sformatf("MONITOR Receive: %0d %0d", my_packet.input_1, my_packet.input_2), UVM_LOW)
                
                monitor_analysis_port.write(my_packet);
                // `uvm_info(get_name(), "MONITOR Receive", UVM_LOW)
                // monitor_analysis_port.get_DUT_data(my_intf.saved_data);
            end
            if (my_intf.PADDR == 5) begin
                monitor_analysis_port.read(my_intf.PRDATA);
            end
        end
    endtask
endclass: monitor
`endif 
