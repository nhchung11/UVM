`ifndef TEST8
`define TEST8  
`include "uvm_macros.svh"
`include "base_sequence.sv"

class test8 extends uvm_sequence;
    `uvm_object_utils(test5)

    function new(string name = "test8");
        super.new(name);
    endfunction

    virtual task body();
        uvm_status_e status;    
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(5000ns)

        
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        `uvm_delay(5000ns)
        my_regmodel.reg_receive.read(status, data);
        `uvm_delay(500ns)
    endtask
endclass

`endif 
