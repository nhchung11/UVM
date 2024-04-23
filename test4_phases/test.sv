`ifndef TEST
`define TEST

`include "uvm_macros.svh"
`include "environment.sv"
import uvm_pkg::*;

class test extends uvm_test;
    `uvm_component_utils(test)
    env my_env;
    virtual intf my_intf;

    // Constructor                                                                   
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // BUILD PHASE
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "TEST BUILD PHASE", UVM_MEDIUM)
        my_env = env::type_id::create("my_env", this);
        if (!uvm_config_db #(virtual intf)::get(this, "*", "my_intf", my_intf))
            `uvm_fatal("NOVIF", "Virtual interface not set")
        uvm_config_db #(virtual intf)::set(this, "my_env.my_agent.*", "my_intf", my_intf);  
    endfunction

    // // CONNECT PHASE
    // function void connect_phase(uvm_phase phase);

    // endfunction

    // RUN PHASE
    virtual task run_phase(uvm_phase phase);
        seq my_seq = seq::type_id::create("my_seq");
        phase.raise_objection(this);
        my_seq.randomize();
        my_seq.start(my_env.my_agent.my_sequencer);
        #200;
        phase.drop_objection(this);
        #100;
        $finish;
    endtask
endclass
`endif 