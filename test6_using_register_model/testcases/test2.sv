`ifndef TEST2 
`define TEST2  
`include "uvm_macros.svh"
`include "base_sequence.sv"

class test2 extends uvm_sequence;
    `uvm_object_utils(test2)

    function new(string name = "test2");
        super.new(name);
    endfunction

    virtual task body();
        uvm_status_e status;    
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        this.my_regmodel.reg_transmit.write(status, 1);
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(10000ns)
    endtask
endclass

`endif 
