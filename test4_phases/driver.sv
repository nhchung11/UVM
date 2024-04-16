`ifndef DRIVER
`define DRIVER

`include "uvm_macros.svh"
`include "packet.sv"
`include "interface.sv"
import uvm_pkg::*;

class driver extends uvm_driver #(packet);
    `uvm_component_utils(driver)
    packet my_packet;
    virtual intf my_intf;
    
    // CONSTRUCTOR
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        my_packet = packet::type_id::create("my_packet");
        uvm_config_db #(virtual intf)::get(null, "*", "my_intf", my_intf);
    endfunction
    
    // CONNECT PHASE
    function void connect_phase (uvm_phase phase);
       
    endfunction

    // RUN PHASE
    task run_phase(uvm_phase phase);
        forever begin
            @(posedge my_intf.clk)
            seq_item_port.get_next_item(my_packet);
            my_intf.input_1 <= my_packet.input_1;
            my_intf.input_2 <= my_packet.input_2;
            seq_item_port.item_done();
        end
    endtask
endclass

`endif 

