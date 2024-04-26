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
        // test0_1(my_packet); 
        // test0_2(my_packet);
        // test1(my_packet);
        // test2(my_packet);   
        // test3(my_packet);
        // test4(my_packet);
        // test5(my_packet);
        // test6(my_packet);
        // test7(my_packet);
        test8(my_packet);   
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

    task read(packet my_packet, int PADDR); 
        start_item(my_packet);
        my_packet.PADDR = PADDR;
        my_packet.PRESETn = 1;
        my_packet.PSELx = 1;
        my_packet.PENABLE = 0;
        my_packet.PWRITE = 0;   
        finish_item(my_packet);

        `uvm_info(get_name(), $sformatf("APB Read from register %0d", my_packet.PADDR), UVM_LOW)
        start_item(my_packet);
        my_packet.PENABLE = 1;
        finish_item(my_packet);

        start_item(my_packet);
        my_packet.PSELx = 0;
        my_packet.PENABLE = 0;  
        finish_item(my_packet);
    endtask

    task reset(packet my_packet);           // APB RESET
        start_item(my_packet);
        my_packet.PRESETn = 0;
        my_packet.PSELx = 0;
        my_packet.PENABLE = 0;
        my_packet.PWRITE = 0;   
        my_packet.PWDATA = 0;
        my_packet.PADDR = 0;
        finish_item(my_packet);
        `uvm_info(get_name(), "APB RESET", UVM_LOW)

        start_item(my_packet);
        my_packet.PRESETn = 1;
        finish_item(my_packet);
    endtask

    task test0_1(packet my_packet);         // Write to all registers
        reset(my_packet);
        write(my_packet, 1, 2);
        write(my_packet, 1, 3);
        write(my_packet, 1, 4);
        write(my_packet, 1, 5);
        write(my_packet, 1, 6);
        `uvm_delay(1000ns) 
    endtask

    task test0_2(packet my_packet);         // Read default values from all registers
        reset(my_packet);
        `uvm_delay(500ns);
        read(my_packet, 2);
        read(my_packet, 3);
        read(my_packet, 4);
        read(my_packet, 5);
        read(my_packet, 6);
        `uvm_delay(1000ns)
    endtask

    task test1(packet my_packet);           // Receive Address NACK
        reset(my_packet);
        write(my_packet, 8'b11110110, 2);
        write(my_packet, 8'b1110_0000, 6);
        write(my_packet, 0, 4);
        write(my_packet, 1, 4);
        write(my_packet, 8'b11111110, 2);
        `uvm_delay(5000ns)
    endtask

    task test2(packet my_packet);           // Write 1 data
        reset(my_packet);
        write(my_packet, 8'b11110110, 2);
        write(my_packet, 8'b0010_0000, 6);
        write(my_packet, 0, 4);
        write(my_packet, 1, 4);
        write(my_packet, 8'b11111110, 2);
        `uvm_delay(5000ns)
    endtask
    
    task test3(packet my_packet);           // Write to full FIFO TX and continue writing
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
        write(my_packet, 11, 4);
        write(my_packet, 12, 4);
        write(my_packet, 13, 4);
        write(my_packet, 8'b11111110, 2);
        `uvm_delay(20000ns)
    endtask

    task test4(packet my_packet);           // Receive data NACK by write to full I2C slave
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
        write(my_packet, 11, 4);
        write(my_packet, 8'b11111110, 2);
        `uvm_delay(20000ns)
    endtask

    task test5(packet my_packet);           // Write 4 bytes then reset
        reset(my_packet);
        write(my_packet, 8'b11110110, 2);
        write(my_packet, 8'b0010_0000, 6);
        write(my_packet, 0, 4);
        write(my_packet, 1, 4);
        write(my_packet, 2, 4);
        write(my_packet, 3, 4);
        write(my_packet, 4, 4);
        write(my_packet, 8'b11111110, 2);
        `uvm_delay(10000ns)
        
        reset(my_packet);
        write(my_packet, 8'b11110110, 2);
        write(my_packet, 8'b0010_0000, 6);
        write(my_packet, 4, 4);
        write(my_packet, 5, 4);
        write(my_packet, 6, 4);
        write(my_packet, 7, 4);
        write(my_packet, 8'b11111110, 2);
        `uvm_delay(10000ns)        
    endtask

    task test6(packet my_packet);           // Write with repeated start
        reset(my_packet);
        write(my_packet, 8'b11110110, 2);
        write(my_packet, 8'b0010_0000, 6);
        write(my_packet, 0, 4);
        write(my_packet, 1, 4);
        write(my_packet, 2, 4);
        write(my_packet, 3, 4);
        write(my_packet, 8'b11111110, 2);
        `uvm_delay(10000ns)
    endtask

    task test7(packet my_packet);           // Write many data
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
        write(my_packet, 8'b11111110, 2);
        `uvm_delay(20000ns)

        write(my_packet, 8'b11110110, 2);
        write(my_packet, 8'b0010_0000, 6);
        write(my_packet, 0, 4);
        write(my_packet, 8, 4);
        write(my_packet, 9, 4);
        write(my_packet, 10, 4);
        write(my_packet, 11, 4);
        write(my_packet, 12, 4);
        write(my_packet, 13, 4);
        write(my_packet, 14, 4);
        write(my_packet, 8'b11111110, 2);
        `uvm_delay(20000ns)
    endtask

    task test8(packet my_packet);
        reset(my_packet);
        write(my_packet, 8'b11110110, 2);
        write(my_packet, 8'b0010_0000, 6);
        write(my_packet, 0, 4);
        write(my_packet, 1, 4);
        write(my_packet, 8'b11111110, 2);
        `uvm_delay(5000ns)

        
        write(my_packet, 8'b0010_0001, 6);
        write(my_packet, 8'b11111100, 2);
        `uvm_delay(5000ns)
        read(my_packet, 5);
        `uvm_delay(500ns)
    endtask
endclass
`endif 
  
