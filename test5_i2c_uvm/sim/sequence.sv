`ifndef SEQ
`define SEQ

`include "packet.sv"
import uvm_pkg::*;

class seq extends uvm_sequence;
    `uvm_object_utils(seq)
    function new(string name = "sequence");
        super.new(name);
    endfunction

    // virtual intf my_intf; // Declare the interface
// 
//     // BUILD PHASE
//     virtual function void build_phase(uvm_phase phase);
//         super.build_phase(phase);
//         if(!uvm_config_db #(virtual intf)::get(this, "*", "my_intf", my_intf))
//             `uvm_fatal("NOVIF", "Virtual interface not set")
//     endfunction

    task body();
        packet my_packet = packet::type_id::create("my_packet");
        reset(my_packet);
        write(my_packet, 8'b11110110, 2);
        write(my_packet, 8'b0010_0000, 6);
        write(my_packet, 0, 4);
        write(my_packet, 1, 4);
        write(my_packet, 2, 4);
        write(my_packet, 3, 4);
        write(my_packet, 4, 4);
        write(my_packet, 5, 4);
        write(my_packet, 6, 4);
        write(my_packet, 7, 4);
        write(my_packet, 8, 4);
        write(my_packet, 9, 4);
        write(my_packet, 10, 4);
        write(my_packet, 8'b11111110, 2);
        `uvm_delay(20000ns)
    endtask

    task write(packet my_packet, bit [7:0] PWDATA, int PADDR);
        start_item(my_packet);
        my_packet.PWDATA = PWDATA;
        my_packet.PADDR = PADDR;
        my_packet.PRESETn = 1;
        my_packet.PSELx = 1;
        my_packet.PENABLE = 0;
        my_packet.PWRITE = 1;   
        finish_item(my_packet);

        `uvm_info(get_name(), $sformatf("APB Write %0d to register %0d", my_packet.PWDATA, my_packet.PADDR), UVM_LOW)
        start_item(my_packet);
        my_packet.PENABLE = 1;
        finish_item(my_packet);

        start_item(my_packet);
        my_packet.PSELx = 0;
        my_packet.PENABLE = 0;  
        finish_item(my_packet);
    endtask

    task reset(packet my_packet);
        start_item(my_packet);
        my_packet.PRESETn = 0;
        my_packet.PSELx = 0;
        my_packet.PENABLE = 0;
        my_packet.PWRITE = 0;   
        my_packet.PWDATA = 0;
        my_packet.PADDR = 0;
        finish_item(my_packet);
        `uvm_info(get_name(), "APB Reset", UVM_LOW)

        start_item(my_packet);
        my_packet.PRESETn = 1;
        finish_item(my_packet);
    endtask
endclass
`endif 
  
