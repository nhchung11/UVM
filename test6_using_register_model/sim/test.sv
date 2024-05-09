`ifndef TEST
`define TEST

// `timescale 1ns/1ns
`include "uvm_macros.svh"
`include "environment.sv"
`include "reg_sequence.sv"
`include "register_model.sv"

import uvm_pkg::*;

class test extends uvm_test;
    `uvm_component_utils(test)
    env my_env;
    virtual intf my_intf;
    reg_seq my_reg_seq;

    // ----------------- CONSTRUCTOR -----------------                                                          
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // ----------------- BUILD PHASE -----------------
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "------------------------------------------------------------", UVM_MEDIUM)
        `uvm_info(get_name(), "TEST BUILD PHASE", UVM_MEDIUM)
        my_env = env::type_id::create("my_env", this);
        if (!uvm_config_db #(virtual intf)::get(this, "*", "my_intf", my_intf))
            `uvm_fatal("NOVIF", "Virtual interface not set")
        uvm_config_db #(virtual intf)::set(this, "my_env.my_agent.*", "my_intf", my_intf);
        
        // Initiate sequence
        my_reg_seq = reg_seq::type_id::create("my_reg_seq");
    endfunction : build_phase

    // ----------------- RUN PHASE -----------------
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        my_reg_seq.my_regmodel = my_env.my_regmodel;
        my_reg_seq.start(my_env.my_agent.my_sequencer);
        phase.drop_objection(this);
    endtask : run_phase
endclass
`endif                                  
