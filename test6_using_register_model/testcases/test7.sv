`ifndef TEST7
`define TEST7  
`include "uvm_macros.svh"
`include "base_sequence.sv"

class test7 extends uvm_sequence;
    `uvm_object_utils(test7)

    function new(string name = "test7");
        super.new(name);
    endfunction

    virtual task body();
        uvm_status_e status;    
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        for (int i = 0; i < 7; i++) begin
            if (!this.random_data.randomize()) begin
                `uvm_error("TEST7", "Randomization failed")
            end
            this.my_regmodel.reg_transmit.write(status, this.random_data);
        end
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(20000ns)

        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        for (int i = 0; i < 7; i++) begin
            if (!this.random_data.randomize()) begin
                `uvm_error("TEST7", "Randomization failed")
            end
            this.my_regmodel.reg_transmit.write(status, this.random_data);
        end
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(20000ns)
    endtask
endclass

`endif 
