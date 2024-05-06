class command extends uvm_reg;
    `uvm_object_utils(command)
    uvm_reg_field write_reset_n_tx;
    uvm_reg_field read_reset_n_tx;
    uvm_reg_field write_reset_n_rx;
    uvm_reg_field read_reset_n_rx;
    uvm_reg_field i2c_reset;
    uvm_reg_field i2c_enable;
    uvm_reg_field i2c_repeat_start;

    function new(string name = "command");
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        write_reset_n_tx = uvm_reg_field::type_id::create("write_reset_n_tx");
        write_reset_n_tx.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(7)
        );

        read_reset_n_tx = uvm_reg_field::type_id::create("read_reset_n_tx");
        read_reset_n_tx.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(6)
        );

        write_reset_n_rx = uvm_reg_field::type_id::create("write_reset_n_rx");
        write_reset_n_rx.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(5)
        );

        read_reset_n_rx = uvm_reg_field::type_id::create("read_reset_n_rx");
        read_reset_n_rx.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(4)
        );

        i2c_reset = uvm_reg_field::type_id::create("i2c_reset");
        i2c_reset.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(3)
        );

        i2c_enable = uvm_reg_field::type_id::create("i2c_enable");
        i2c_enable.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(2)
        );

        i2c_repeat_start = uvm_reg_field::type_id::create("i2c_repeat_start");
        i2c_repeat_start.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(1)
        );
    endfunction
endclass

class status extends uvm_reg;
    `uvm_object_utils(status)
    uvm_reg_field tx_full;
    uvm_reg_field tx_empty;
    uvm_reg_field rx_full;
    uvm_reg_field rx_empty;
    uvm_reg_field i2c_ready;

    function new(string name = "status");
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        tx_full = uvm_reg_field::type_id::create("tx_full");
        tx_full.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(7)
        );

        tx_empty = uvm_reg_field::type_id::create("tx_empty");
        tx_empty.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(6)
        );

        rx_full = uvm_reg_field::type_id::create("rx_full");
        rx_full.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(5)
        );

        rx_empty = uvm_reg_field::type_id::create("rx_empty");
        rx_empty.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(4) 
        );

        i2c_ready = uvm_reg_field::type_id::create("i2c_ready");
        i2c_ready.configure(
            .parent(this),
            .size(1),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(3)
        );
    endfunction
endclass

class transmit extends uvm_reg;
    `uvm_object_utils(transmit)
    uvm_reg_field data_to_fifo;

    // CONSTRUCTOR
    function new(string name = "transmit");
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction

    // CONFIGURE
    virtual function void build();
        data_to_fifo = uvm_reg_field::type_id::create("data_to_fifo");
        tx_data.configure(
            .parent(this),
            .size(8),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(0)
        );
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
        rx_data.configure(
            .parent(this),
            .size(8),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(0)
        );
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
        address.configure(
            .parent(this),
            .size(8),
            .access(UVM_RW),
            .volatile(0),
            .reset(0),
            .has_reset(1),
            .is_rand(0),
            .lsb_pos(0)
        );
    endfunction
endclass


class register_map extends uvm_reg_block;
    `uvm_object_utils(register_map)
    command     reg_command;
    status      reg_status;
    transmit    reg_transmit;
    receive     reg_receive;
    address     reg_address;

    // CONSTRUCTOR
    function new(string name = "register_map");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    // BUILD
    virtual function void build();
        reg_command = reg_command::type_id::create("reg_command");
        reg_command.build();
        reg_command.configure(this);

        reg_status = reg_status::type_id::create("reg_status");
        reg_status.build();
        reg_status.configure(this);

        reg_transmit = reg_transmit::type_id::create("reg_transmit");
        reg_transmit.build();
        reg_transmit.configure(this);

        reg_receive = reg_receive::type_id::create("reg_receive");
        reg_receive.build();
        reg_receive.configure(this);    

        reg_address = reg_address::type_id::create("reg_address");
        reg_address.build();
        reg_address.configure(this);    

        default_map = create_map("default_map", 0, 8, UVM_LITTLE_ENDIAN);
        default_map.add_reg(reg_command, 2, "RW");
        default_map.add_reg(reg_status, 3, "RW");
        default_map.add_reg(reg_transmit, 4, "RW");
        default_map.add_reg(reg_receive, 5, "RW");
        default_map.add_reg(reg_address, 6, "RW");
        lock_model();
    endfunction
endclass