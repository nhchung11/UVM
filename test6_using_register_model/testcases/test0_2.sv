`ifndef TEST0_2 
`define TEST0_2
`include "uvm_macros.svh"
`include "base_sequence.sv"

class reg_seq extends base_sequence;
    `uvm_object_utils(test0_2)

    function new(string name = "test0_2");
        super.new(name);
    endfunction

    virtual task body();
        uvm_reg_data_t data;
        this.my_regmodel.reg_command.read(status, data);
        this.my_regmodel.reg_status.read(status, data);
        this.my_regmodel.reg_transmit.read(status, data);
        this.my_regmodel.reg_receive.read(status, data);
        this.my_regmodel.reg_address.read(status, data);
        `uvm_delay(500ns)
    endtask
endclass

`endif 