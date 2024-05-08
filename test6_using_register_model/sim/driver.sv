`ifndef DRIVER
`define DRIVER

`include "uvm_macros.svh"
`include "packet.sv"
// `include "interface.sv"
import uvm_pkg::*;

class driver extends uvm_driver #(packet);
    `uvm_component_utils(driver)
    packet my_packet;
    virtual intf my_intf;
    
    // CONSTRUCTOR
    function new (string name = "driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // BUILD PHASE
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "DRIVER BUILD PHASE", UVM_MEDIUM)
        my_packet = packet::type_id::create("my_packet");
        if(!uvm_config_db #(virtual intf)::get(this, "*", "my_intf", my_intf))
            `uvm_fatal("NOVIF", "Virtual interface not set")
    endfunction
    
    // // CONNECT PHASE
    // function void connect_phase (uvm_phase phase);
       
    // endfunction

    // RUN PHASE
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_name(), "DRIVER RUN PHASE", UVM_MEDIUM)
        forever begin
            // `uvm_info(get_name(), $sformatf("Write %0d to register %0d", my_packet.PWDATA, my_packet.PADDR), UVM_LOW) 
            @(posedge my_intf.PCLK)
            seq_item_port.get_next_item(my_packet);
            my_intf.PRESETn     <= my_packet.PRESETn;
            my_intf.PSELx       <= my_packet.PSELx; 
            my_intf.PENABLE     <= my_packet.PENABLE;
            my_intf.PWRITE      <= my_packet.PWRITE;
            my_intf.PADDR       <= my_packet.PADDR;
            my_intf.PWDATA      <= my_packet.PWDATA;
            seq_item_port.item_done();
        end
    endtask
endclass
`endif 

