`ifndef TEST12
`define TEST12  
`include "uvm_macros.svh"
`include "base_sequence.sv"

class test12 extends uvm_sequence;
    `uvm_object_utils(test12)

    function new(string name = "test12");
        super.new(name);
    endfunction

    virtual task body();
        uvm_status_e status;    
        uvm_reg_data_t data;
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        this.my_regmodel.reg_transmit.write(status, 1);
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(200ns)

        // reset in start state
        this.my_regmodel.reg_command.write(status, 8'b0000_1110);
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        this.my_regmodel.reg_transmit.write(status, 1);
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(300ns)

        // Reset in write address state
        this.my_regmodel.reg_command.write(status, 8'b0000_1110);
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        this.my_regmodel.reg_transmit.write(status, 1);
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(1650ns)

        // Reset in address ack state
        this.my_regmodel.reg_command.write(status, 8'b0000_1110);
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        this.my_regmodel.reg_transmit.write(status, 1);
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(1800ns)

        // Reset in write data state
        this.my_regmodel.reg_command.write(status, 8'b0000_1110);
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        this.my_regmodel.reg_transmit.write(status, 1);
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(3150ns)

        // Reset in data ack state
        this.my_regmodel.reg_command.write(status, 8'b0000_1110);
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        this.my_regmodel.reg_transmit.write(status, 1);
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(5000ns)

        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        `uvm_delay(3300ns)

        // Reset to read state
        this.my_regmodel.reg_command.write(status, 8'b0000_1110);
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0001);
        this.my_regmodel.reg_command.write(status, 8'b11111100);
        `uvm_delay(4700ns)

        // Reset to read state
        this.my_regmodel.reg_command.write(status, 8'b0000_1110);
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0001);
        this.my_regmodel.reg_command.write(status, 8'b11111100);
        `uvm_delay(5000ns)

        this.my_regmodel.reg_receive.read(status, data);
        `uvm_delay(1000ns)
    endtask
endclass

`endif 
