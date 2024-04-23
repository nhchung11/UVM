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
        packet my_packet = packet::type_id::create("my_packet");
        start_item(my_packet);
        test0_1(my_packet);
        #2000;
        test0_2(my_packet);
        #2000;
        test1(my_packet);
        #2000;

        finish_item(my_packet);
    endtask

    task reset(packet reset_packet);
        reset_packet.PRESETn = 0;
        #100;
        reset_packet.PRESETn = 1;
    endtask

    task write(packet write_packet, bit [7:0] addr, bit [7:0] data);
        write_packet.PSELx = 0;
        write_packet.PENABLE = 0;
        write_packet.PADDR = addr;
        write_packet.PWDATA = data;

        @(posedge my_intf.PCLK);
        write_packet.PSELx = 1;
        write_packet.PENABLE = 1;     
        write_packet.PWRITE = 1;

        @(posedge my_intf.PCLK);
        write_packet.PSELx = 0;
        write_packet.PENABLE = 0;
    endtask
    
    task read(packet read_packet, bit [7:0] addr);
        read_packet.PSELx = 0;
        read_packet.PENABLE = 0;
        read_packet.PADDR = addr;

        @(posedge my_intf.PCLK);   
        read_packet.PSELx = 1;
        read_packet.PENABLE = 1;
        read_packet.PWRITE = 0;

        @(posedge my_intf.PCLK);
        read_packet.PSELx = 0;
        read_packet.PENABLE = 0;
    endtask

    task test0_1(packet my_packet);
        reset(my_packet);
        write(my_packet, 8'd02, 8'b11110110);
        write(my_packet, 8'd6, 8'b0010_0000);
        write(my_packet, 8'd5, 8'd0);
        write(my_packet, 8'd5, 8'd1);
        write(my_packet, 8'd5, 8'd2);
        write(my_packet, 8'd2, 8'b11111100);
    endtask

    task test0_2(packet my_packet);
        reset(my_packet);
        write(my_packet, 2, 8'b11110110);
        write(my_packet, 6, 8'b0010_0000);
        write(my_packet, 5, 8'd1);
        write(my_packet, 8'd2, 8'b11111100);
        read(my_packet, 8'd2);
        read(my_packet, 8'd5);
        read(my_packet, 8'd3);
        read(my_packet, 8'd4);
        read(my_packet, 8'd6);
    endtask

    task test1(packet my_packet);
        reset(my_packet);
        write(my_packet, 8'd02, 8'b11110110);
        write(my_packet, 8'd6, 8'b1110_0000);
        write(my_packet, 8'd4, 8'0);
        write(my_packet, 8'd2, 8'b11111100);
    endtask
endclass
`endif 
  
