`ifndef SEQ
`define SEQ

// `include "packet.sv"
import uvm_pkg::*;

class seq extends uvm_sequence;
    `uvm_object_utils(seq)
    packet my_packet;
    function new(string name);
        super.new(name);
    endfunction: new

    task body();
        my_packet = packet::type_id::create("my_packet");
        repeat(10)
        begin
            start_item(my_packet);
            my_packet.randomize();
            finish_item(my_packet);
        end
    endtask
endclass
`endif 