`ifndef PKG
`define PKG

package my_testbench_pkg;
    import uvm_pkg::*;

    // The UVM sequence, transaction item, and driver are in these files:
    `include "sequence.svh"
    `include "driver.svh"
    // `include "design.sv"

    // The agent contains sequencer, driver, and monitor (not included)
    class my_agent extends uvm_agent;
        `uvm_component_utils(my_agent)
            // Macro có sẵn của UVM để tự động định nghĩa phương thức và thuộc tính cần thiết của my_agent
        
        my_driver driver;
        uvm_sequencer#(my_transaction) sequencer;
        
        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction
        
        // BUILD PHASE
        function void build_phase(uvm_phase phase);
            driver = my_driver ::type_id::create("driver", this);
            sequencer = uvm_sequencer#(my_transaction)::type_id::create("sequencer", this);
        endfunction    
        
        // CONNECT PHASE: connect sequencer to driver
        function void connect_phase(uvm_phase phase);
            driver.seq_item_port.connect(sequencer.seq_item_export);    // Using TLM
        endfunction
        
        // RUN PHASE
        task run_phase(uvm_phase phase);
            // We raise objection to keep the test from completing
            phase.raise_objection(this);
            begin
                my_sequence seq;
                seq = my_sequence::type_id::create("seq");
                seq.start(sequencer);
            end
            // We drop objection to allow the test to complete
            phase.drop_objection(this);
        endtask

    endclass

    class my_env extends uvm_env;
        // Environment includes agent and scoreboard
        `uvm_component_utils(my_env)
        
        my_agent agent;

        function new(string name, uvm_component parent);
        super.new(name, parent);
        endfunction
        
        function void build_phase(uvm_phase phase);
        agent = my_agent::type_id::create("agent", this);
        endfunction

    endclass

    class my_test extends uvm_test;
        // Test includes environment and sequences
        `uvm_component_utils(my_test)
        
        my_env env;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction
        
        function void build_phase(uvm_phase phase);
        env = my_env::type_id::create("env", this);
        endfunction
        
        task run_phase(uvm_phase phase);
        // We raise objection to keep the test from completing
        phase.raise_objection(this);
        #10;
        `uvm_warning("", "Hello World!")
        // We drop objection to allow the test to complete
        phase.drop_objection(this);
        endtask

    endclass

endpackage
`endif 