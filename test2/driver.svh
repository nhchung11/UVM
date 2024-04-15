`ifndef DRIVER
`define DRIVER

class my_driver extends uvm_driver #(my_transaction);

    `uvm_component_utils(my_driver)

    virtual dut_if dut_vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        // Get interface reference from config database
        if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_vif", dut_vif)) begin
            // If get database config not success
            `uvm_error("", "uvm_config_db::get failed")
        end
    endfunction 

    task run_phase(uvm_phase phase);
        // First toggle reset
        dut_vif.reset = 1;
        @(posedge dut_vif.clock);
        #1;
        dut_vif.reset = 0;
        
        // Now drive normal traffic
        forever begin
            seq_item_port.get_next_item(req);

            // Drive to DUT
            dut_vif.cmd  = req.cmd;
            dut_vif.addr = req.addr;
            dut_vif.data = req.data;
            @(posedge dut_vif.clock);

            seq_item_port.item_done();
        end
    endtask

endclass: my_driver
`endif 
  

// Truy cập tới UVM configuration database bằng class uvm_config_db
// Truyền dữ liệu giữa các thành phần của UVM testbench
// 2 primary functions: get  &  set
