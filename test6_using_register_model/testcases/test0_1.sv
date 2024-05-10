`ifndef TEST0_1 
`define TEST0_1
`include "uvm_macros.svh"
`include "base_sequence.sv"

class reg_seq extends base_sequence;
    `uvm_object_utils(test0_1)

    function new(string name = "test0_1");
        super.new(name);
    endfunction

    virtual task body();
        uvm_status_e status;    
        this.my_regmodel.reg_command.write(status, 1);
        this.my_regmodel.reg_transmit.write(status, 2);
        this.my_regmodel.reg_address.write(status, 3);
        this.my_regmodel.reg_receive.write(status, 4);
        this.my_regmodel.reg_status.write(status, 5);
        `uvm_delay(1000ns)
    endtask
endclass

`endif 