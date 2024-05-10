`ifndef TEST4
`define TEST4  
`include "uvm_macros.svh"
`include "base_sequence.sv"

class test4 extends uvm_sequence;
    `uvm_object_utils(test4)

    function new(string name = "test4");
        super.new(name);
    endfunction

    virtual task body();
        uvm_status_e status;    
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        this.my_regmodel.reg_transmit.write(status, 1);
        this.my_regmodel.reg_transmit.write(status, 2);
        this.my_regmodel.reg_transmit.write(status, 3);
        this.my_regmodel.reg_transmit.write(status, 4);
        this.my_regmodel.reg_transmit.write(status, 5);
        this.my_regmodel.reg_transmit.write(status, 6);
        this.my_regmodel.reg_transmit.write(status, 7);
        this.my_regmodel.reg_transmit.write(status, 8);
        this.my_regmodel.reg_transmit.write(status, 9);
        this.my_regmodel.reg_transmit.write(status, 10);
        this.my_regmodel.reg_transmit.write(status, 11);
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(20000ns)
    endtask
endclass

`endif 
