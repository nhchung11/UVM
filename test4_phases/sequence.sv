`ifndef SEQ
`define SEQ

`include "packet.sv"
import uvm_pkg::*;

class seq extends uvm_sequence;
    `uvm_object_utils(seq)
    function new(string name = "sequence");
        super.new(name);
    endfunction

    task body();
        repeat(5) begin
            packet my_packet = packet::type_id::create("my_packet");
            start_item(my_packet);
            my_packet.randomize();
            // `uvm_info(get_name(), $sformatf("Generate new packet: "), UVM_LOW)
            // my_packet.print();
            finish_item(my_packet);
        end
    endtask
endclass
`endif 