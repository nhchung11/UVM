`ifndef ENV
`define ENV

`include "uvm_macros.svh"
`include "packet.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "subscriber.sv"
`include "adapter.sv"
`include "register_model.sv"

import uvm_pkg::*;
class env extends uvm_env;
    `uvm_component_utils(env)
    agent my_agent;
    scoreboard my_scoreboard;
    subscriber my_subscriber;
    adapter my_adapter;
    uvm_reg_predictor #(packet) my_predictor;
    register_model my_regmodel;
    virtual intf my_intf;


    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // BUILD PHASE
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "ENVIRONMENT BUILD PHASE", UVM_MEDIUM)
        if (!uvm_config_db #(virtual intf)::get(this, "*", "my_intf", my_intf))
            `uvm_fatal("NOVIF", "Virtual interface not set")

        // Create instance
        my_agent        = agent::type_id::create("my_agent", this);
        my_scoreboard   = scoreboard::type_id::create("my_scoreboard", this);
        my_subscriber   = subscriber::type_id::create("my_subscriber", this);
        my_adapter      = adapter::type_id::create("my_adapter", this);
        my_predictor    = uvm_reg_predictor #(packet)::type_id::create("my_predictor", this);
        my_regmodel     = register_model::type_id::create("my_regmodel", this); 

        // Set up register model
        my_regmodel.build();
        my_regmodel.lock_model();
        uvm_config_db #(register_model)::set(null, "", "my_reg_model", my_regmodel);
    endfunction

    // CONNECT PHASE
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_name(), "ENVIRONMENT CONNECT PHASE", UVM_MEDIUM)
        // Connect monitor to scoreboard and subscriber
        my_agent.my_monitor.monitor_analysis_port.connect(my_scoreboard.scoreboard_analysis_imp);
        my_agent.my_monitor.monitor_analysis_port.connect(my_subscriber.subscriber_analysis_imp);

        // Map predicter to register map and adapter
        my_predictor.map        = my_regmodel.default_map;
        my_predictor.adapter    = my_adapter;
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