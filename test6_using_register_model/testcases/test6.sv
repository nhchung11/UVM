`ifndef TEST6
`define TEST6  
`include "uvm_macros.svh"
`include "base_sequence.sv"

class test6 extends uvm_sequence;
    `uvm_object_utils(test6)

    function new(string name = "test6");
        super.new(name);
    endfunction

    virtual task body();
        uvm_status_e status;    
        this.my_regmodel.reg_command.write(status, 8'b11110110);
        this.my_regmodel.reg_address.write(status, 8'b0010_0000);
        this.my_regmodel.reg_transmit.write(status, 0);
        for (int i = 0; i < 3; i++) begin
            if (!this.random_data.randomize()) begin
                `uvm_error("MY_TEST", "Randomization failed")
            end
            this.my_regmodel.reg_transmit.write(status, this.random_data);
        end
        this.my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(10000ns)
    endtask
endclass

`endif 
