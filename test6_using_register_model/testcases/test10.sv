`ifndef TEST10
`define TEST10  
`include "uvm_macros.svh"
`include "base_sequence.sv"

class test10 extends uvm_sequence;
    `uvm_object_utils(test10)

    function new(string name = "test10");
        super.new(name);
    endfunction

    virtual task body();
        uvm_status_e status;    
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
    endtask
endclass

`endif 
