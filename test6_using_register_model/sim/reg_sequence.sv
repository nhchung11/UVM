`ifndef REG_SEQ
`define REG_SEQ

`include "uvm_macros.svh"
`include "register_model.sv"

class reg_seq extends uvm_sequence;
    `uvm_object_utils(reg_seq)
    register_model regmodel;
    function new(string name = "reg_seq");
        super.new(name);
    endfunction

    task body();
        uvm_status_e status;
        // Write to registers
        // regmodel.reg_command.write(status, 8'hFF); 
        // regmodel.reg_transmit.write(status, 8'hAB);
        `uvm_info(get_name(), "SEQUENCE", UVM_MEDIUM)
    endtask
endclass

`endif
