`ifndef ENV
`define ENV

`include "uvm_macros.svh"
`include "agent.sv"
`include "scoreboard.sv"

import uvm_pkg::*;
class env extends uvm_env;
    `uvm_component_utils(env)
    agent my_agent;
    scoreboard my_scoreboard;
    virtual intf my_intf;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // BUILD PHASE
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "ENVIRONMENT BUILD PHASE", UVM_MEDIUM)
        my_agent = agent::type_id::create("my_agent", this);
        if (!uvm_config_db #(virtual intf)::get(this, "*", "my_intf", my_intf))
            `uvm_fatal("NOVIF", "Virtual interface not set")
        my_scoreboard = scoreboard::type_id::create("my_scoreboard", this);
    endfunction

    // CONNECT PHASE
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_name(), "ENVIRONMENT CONNECT PHASE", UVM_MEDIUM)
        my_agent.my_monitor.monitor_analysis_port.connect(my_scoreboard.packet_imp);
    endfunction

    // RUN PHASE
    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_name(), "ENVIRONMENT RUN PHASE", UVM_MEDIUM)
        super.run_phase(phase);
        forever @(posedge my_intf.check_data) begin
            my_scoreboard.data_DUT_received.push_back(my_intf.saved_data);
        end
    endtask
endclass: env;
`endif 