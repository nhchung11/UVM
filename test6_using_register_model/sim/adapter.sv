`ifndef ADAPTER
`define ADAPTER
`include "uvm_macros.svh"
`include "packet.sv"
import uvm_pkg::*;

class adapter extends uvm_reg_adapter;
    `uvm_object_utils(adapter)
    function new(string name = "adapter");
        super.new(name);
    endfunction

    function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        packet my_packet;
        my_packet = packet::type_id::create("my_packet");
        my_packet.PADDR = rw.addr;
        my_packet.PWDATA = rw.data;
        my_packet.PWRITE = rw.kind == UVM_WRITE;
        `uvm_info(get_name(), $sformatf("Write %0d to register %0d", my_packet.PWDATA, my_packet.PADDR), UVM_LOW)
        return my_packet;
    endfunction

    function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        packet my_packet;
        my_packet = packet::type_id::create("my_packet");
        rw.addr = my_packet.PADDR;
        rw.data = my_packet.PWDATA;
        rw.kind = my_packet.PWRITE ? UVM_WRITE : UVM_READ;
        rw.status = UVM_IS_OK;
        `uvm_info(get_name(), $sformatf("Read %0d from register %0d", rw.data, rw.addr), UVM_LOW)
    endfunction
endclass

`endif 