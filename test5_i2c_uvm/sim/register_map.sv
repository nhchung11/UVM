class register_map extends uvm_object;
    `uvm_object_utils(register_map)
    uvm_reg reg_command;
    uvm_reg reg_transmit;
    uvm_reg reg_status;
    uvm_reg reg_address;
    uvm_reg reg_receive;

    function new(string name = "register_map");
        super.new(name);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "REGISTER MAP BUILD PHASE", UVM_MEDIUM)
        reg_command = uvm_reg::type_id::create("reg_command");
        reg_transmit = uvm_reg::type_id::create("reg_transmit");
        reg_status = uvm_reg::type_id::create("reg_status");
        reg_address = uvm_reg::type_id::create("reg_address");
        reg_receive = uvm_reg::type_id::create("reg_receive");
    endfunction

    
endclass