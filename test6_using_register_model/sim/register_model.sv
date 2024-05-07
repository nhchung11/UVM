`ifndef REGS
`define REGS
`include "uvm_macros.svh"
import uvm_pkg::*;

class command extends uvm_reg;
    `uvm_object_utils(command)
    uvm_reg_field apb_command;

    function new(string name = "command");
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        apb_command = uvm_reg_field::type_id::create("apb_command");
        apb_command.configure(this, 8, 0, "RW", 0, 8'h0, 1, 1, 1);
    endfunction
endclass

class status extends uvm_reg;
    `uvm_object_utils(status)
    uvm_reg_field tx_full;
    uvm_reg_field tx_empty;
    uvm_reg_field rx_full;
    uvm_reg_field rx_empty;
    uvm_reg_field i2c_ready;

    covergroup status_cg;
        tx_full_cg: coverpoint tx_full.value[0:0];
        tx_empty_cg: coverpoint tx_empty.value[0:0];
        rx_full_cg: coverpoint rx_full.value[0:0];
        rx_empty_cg: coverpoint rx_empty.value[0:0];
        i2c_ready_cg: coverpoint i2c_ready.value[0:0];
    endgroup

    function new(string name = "status");
        super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    endfunction

    virtual function void build();
        tx_full = uvm_reg_field::type_id::create("tx_full");
        tx_full.configure(this, 1, 7, "RW", 1, 0, 1, 0, 0);
    
        tx_empty = uvm_reg_field::type_id::create("tx_empty");
        tx_empty.configure(this, 1, 6, "RW", 1, 1, 1, 0, 0);

        rx_full = uvm_reg_field::type_id::create("rx_full");
        rx_full.configure(this, 1, 5, "RW", 1, 0, 1, 0, 0);

        rx_empty = uvm_reg_field::type_id::create("rx_empty");
        rx_empty.configure(this, 1, 4, "RW", 1, 1, 1, 0, 0);

        i2c_ready = uvm_reg_field::type_id::create("i2c_ready");
        i2c_ready.configure(this, 1, 3, "RW", 1, 0, 1, 0, 0);
    endfunction
endclass

class transmit extends uvm_reg;
    `uvm_object_utils(transmit)
    rand uvm_reg_field data_to_fifo;

    covergroup transmit_cg;
        data_to_fifo_cg: coverpoint data_to_fifo.value[7:0];
    endgroup

    // CONSTRUCTOR
    function new(string name = "transmit");
        super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    endfunction

    // CONFIGURE
    virtual function void build();
        data_to_fifo = uvm_reg_field::type_id::create("data_to_fifo");
        tx_data.configure(this, 8, 0, "RW", 0, 8'h0, 1, 1, 0);
    endfunction
endclass

class receive extends uvm_reg;
    `uvm_object_utils(receive)
    uvm_reg_field data_i2c_out;

    // CONSTRUCTOR
    function new(string name = "receive");
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction

    // CONFIGURE
    virtual function void build();
        data_i2c_out = uvm_reg_field::type_id::create("data_i2c_out");
        rx_data.configure(this, 8, 0, "RW", 0, 8'h0, 1, 0, 0);
    endfunction
endclass

class address extends uvm_reg;
    `uvm_object_utils(address)
    uvm_reg_field address_i2c_slave;

    // CONSTRUCTOR
    function new(string name = "address");
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction

    // CONFIGURE
    virtual function void build();
        address_i2c_slave = uvm_reg_field::type_id::create("address_i2c_slave");
        address_i2c_slave.configure(this, 8, 0, "RW", 0, 8'h0, 1, 1, 0);
    endfunction
endclass


class register_model extends uvm_reg_block;
    `uvm_object_utils(register_map)
    command         reg_command;
    status          reg_status;
    rand transmit   reg_transmit;
    receive         reg_receive;
    address         reg_address;

    // CONSTRUCTOR
    function new(string name = "register_model");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    // BUILD
    virtual function void build();
        // Create and configure registers
        reg_command = command::type_id::create("reg_command", , get_full_name());
        reg_command.configure(this);
        reg_command.build();

        reg_status = status::type_id::create("reg_status", , get_full_name());
        reg_status.configure(this);
        reg_status.build();

        reg_transmit = transmit::type_id::create("reg_transmit", , get_full_name());
        reg_transmit.configure(this);
        reg_transmit.build();

        reg_receive = receive::type_id::create("reg_receive", , get_full_name());
        reg_receive.configure(this);    
        reg_receive.build();

        reg_address = address::type_id::create("reg_address", , get_full_name());
        reg_address.configure(this);    
        reg_address.build();
        
        // Define addres mapping
        default_map = create_map("default_map", 2, 1, UVM_LITTLE_ENDIAN);       // Create uvm_reg_map
        default_map.add_reg(reg_command, 2, "RW");
        default_map.add_reg(reg_status, 3, "RO");
        default_map.add_reg(reg_transmit, 4, "RW");
        default_map.add_reg(reg_receive, 5, "RO");
        default_map.add_reg(reg_address, 6, "RW");
        lock_model();
    endfunction
endclass
`endif