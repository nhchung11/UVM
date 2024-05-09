`ifndef REG_SEQ
`define REG_SEQ

`include "uvm_macros.svh"
`include "register_model.sv"

class reg_seq extends uvm_sequence;
    `uvm_object_utils(reg_seq)
    register_model my_regmodel;
    
    function new(string name = "reg_seq");
        super.new(name);
    endfunction

    task body();
        uvm_status_e status;
        // Write to registers
        // regmodel.reg_command.write(status, 8'hFF); 
        `uvm_delay(500ns)
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(10000ns)
    endtask
endclass
`endif
