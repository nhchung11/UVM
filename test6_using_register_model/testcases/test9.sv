`ifndef TEST9
`define TEST9  
`include "uvm_macros.svh"
`include "base_sequence.sv"

class test9 extends uvm_sequence;
    `uvm_object_utils(test9)

    function new(string name = "test9");
        super.new(name);
    endfunction

    virtual task body();
        uvm_status_e status;    
        uvm_reg_data_t data;
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        for (int i = 0; i < 9; i++) begin
            if (!this.random_data.randomize()) begin
                `uvm_error("TEST9", "Randomization failed")
            end
            this.my_regmodel.reg_transmit.write(status, this.random_data);
        end
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(20000ns)

        
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        `uvm_delay(10000ns)
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data); 
    endtask
endclass

`endif 
