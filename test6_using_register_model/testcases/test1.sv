`ifndef TEST1 
`define TEST1
`include "uvm_macros.svh"
`include "base_sequence.sv"

class reg_seq extends base_sequence;
    `uvm_object_utils(test1)

    function new(string name = "test1");
        super.new(name);
    endfunction

    virtual task body();
        uvm_status_e status;    
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b1110_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        this.my_regmodel.reg_transmit.write(status, 1);
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(5000ns)
    endtask
endclass

`endif 