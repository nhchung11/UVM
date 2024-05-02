`ifndef ENV
`define ENV

`include "uvm_macros.svh"
`include "agent.sv"
`include "scoreboard.sv"
`include "subscriber.sv"

import uvm_pkg::*;
class env extends uvm_env;
    `uvm_component_utils(env)
    agent my_agent;
    scoreboard my_scoreboard;
    subscriber my_subscriber;
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
        my_subscriber = subscriber::type_id::create("my_subscriber", this);
    endfunction

    // CONNECT PHASE
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_name(), "ENVIRONMENT CONNECT PHASE", UVM_MEDIUM)
        my_agent.my_monitor.monitor_port.connect(my_scoreboard.scoreboard_imp);
        my_agent.my_monitor.monitor_port.connect(my_subscriber.subscriber_imp);
    endfunction

    // RUN PHASE
    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_name(), "---------------------------------------", UVM_MEDIUM)
        `uvm_info(get_name(), "ENVIRONMENT RUN PHASE", UVM_MEDIUM)
        super.run_phase(phase);
        fork
            begin : dut_receive_data
                forever @(posedge my_intf.check_data) begin
                    my_scoreboard.data_DUT_received.push_back(my_intf.saved_data);
                end
            end

            begin: scoreboard_receive_prdata
                forever @(posedge my_intf.read_data) begin
                    if (my_intf.PADDR == 5)
                        my_scoreboard.data_received.push_back(my_intf.PRDATA);
                end
            end

            begin : FIFO_status
                forever @(posedge my_intf.PCLK) begin
                    if (my_intf.PADDR == 3)
                        my_scoreboard.FIFO_status = my_intf.PRDATA;
                end
            end
        join
    endtask
endclass: env;
`endif 