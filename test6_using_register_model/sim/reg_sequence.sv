`ifndef REG_SEQ
`define REG_SEQ

`include "uvm_macros.svh"
`include "register_model.sv"

class reg_seq extends uvm_sequence;
    `uvm_object_utils(reg_seq)
    register_model my_regmodel;
    
    function new(string name = "reg_seq");
        super.new(name);
    endfunction

    task body();
        uvm_status_e status;
        `uvm_delay(500ns)
        // test0_1(status);
        // test0_2(status);
        // test1(status);
        test2(status);
        // test3(status);
        // test4(status);
        // test5(status);
        // test6(status);
        // test7(status);
        // test8(status);
        // test9(status);
        // test10(status);
        // test11(status);
        // test12(status);
    endtask

    // Write to all registers
    task test0_1(input uvm_status_e status);
        my_regmodel.reg_command.write(status, 1);
        my_regmodel.reg_transmit.write(status, 2);
        my_regmodel.reg_address.write(status, 3);
        my_regmodel.reg_receive.write(status, 4);
        my_regmodel.reg_status.write(status, 5);
        `uvm_delay(1000ns)
    endtask

    // Read from all registers
    task test0_2(input uvm_status_e status);
        uvm_reg_data_t data;
        my_regmodel.reg_command.read(status, data);
        my_regmodel.reg_status.read(status, data);
        my_regmodel.reg_transmit.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_address.read(status, data);
        `uvm_delay(500ns)
    endtask

    // Receive Adress NACK
    task test1(input uvm_status_e status);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b1110_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(5000ns)
    endtask

    // Transmit 1 data
    task test2(input uvm_status_e status);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(10000ns)
    endtask

    // Write to full FIFO TX then continue to write
    task test3(input uvm_status_e status);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_transmit.write(status, 2);
        my_regmodel.reg_transmit.write(status, 3);
        my_regmodel.reg_transmit.write(status, 4);
        my_regmodel.reg_transmit.write(status, 5);
        my_regmodel.reg_transmit.write(status, 6);
        my_regmodel.reg_transmit.write(status, 7);
        my_regmodel.reg_transmit.write(status, 8);
        my_regmodel.reg_transmit.write(status, 9);
        my_regmodel.reg_transmit.write(status, 10);
        my_regmodel.reg_transmit.write(status, 11);
        my_regmodel.reg_transmit.write(status, 12);
        my_regmodel.reg_transmit.write(status, 13);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(20000ns)
    endtask

    // Modify I2C slave to receive NACK data
    task test4(input uvm_status_e status);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_transmit.write(status, 2);
        my_regmodel.reg_transmit.write(status, 3);
        my_regmodel.reg_transmit.write(status, 4);
        my_regmodel.reg_transmit.write(status, 5);
        my_regmodel.reg_transmit.write(status, 6);
        my_regmodel.reg_transmit.write(status, 7);
        my_regmodel.reg_transmit.write(status, 8);
        my_regmodel.reg_transmit.write(status, 9);
        my_regmodel.reg_transmit.write(status, 10);
        my_regmodel.reg_transmit.write(status, 11);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(20000ns)
    endtask

    // Write 4 bytes then reset
    task test5(input uvm_status_e status);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
    endtask

    // Write with repeated start
    task test6(input uvm_status_e status);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_transmit.write(status, 2);
        my_regmodel.reg_transmit.write(status, 3);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(10000ns)
    endtask

    // Write many data
    task test7(input uvm_status_e status);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_transmit.write(status, 2);
        my_regmodel.reg_transmit.write(status, 3);
        my_regmodel.reg_transmit.write(status, 4);
        my_regmodel.reg_transmit.write(status, 5);
        my_regmodel.reg_transmit.write(status, 6);
        my_regmodel.reg_transmit.write(status, 7);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(20000ns)

        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 8);
        my_regmodel.reg_transmit.write(status, 9);
        my_regmodel.reg_transmit.write(status, 10);
        my_regmodel.reg_transmit.write(status, 11);
        my_regmodel.reg_transmit.write(status, 12);
        my_regmodel.reg_transmit.write(status, 13);
        my_regmodel.reg_transmit.write(status, 14);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(20000ns)
    endtask

    // Read 1 byte
    task test8(input uvm_status_e status);
        uvm_reg_data_t data;
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(5000ns)

        
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        `uvm_delay(5000ns)
        my_regmodel.reg_receive.read(status, data);
        `uvm_delay(500ns)
    endtask

    // Write 8 bytes and Read to FIFO RX empty then continue reading
    task test9(input uvm_status_e status);
        uvm_reg_data_t data;
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_transmit.write(status, 2);
        my_regmodel.reg_transmit.write(status, 3);
        my_regmodel.reg_transmit.write(status, 4);
        my_regmodel.reg_transmit.write(status, 5);
        my_regmodel.reg_transmit.write(status, 6);
        my_regmodel.reg_transmit.write(status, 7);
        my_regmodel.reg_transmit.write(status, 8);
        my_regmodel.reg_transmit.write(status, 9);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(20000ns)

        
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        `uvm_delay(10000ns)
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data);
        my_regmodel.reg_receive.read(status, data); 
    endtask

    // // Write and read combination
    // task test10(input uvm_status_e status);
    //     uvm_reg_data_t data;
    //     my_regmodel.reg_command.write(status, 8'b11110110);
    //     my_regmodel.reg_address.write(status, 8'b0010_0000);
    // endtask

    // // Read reset value
    // task test11(input uvm_status_e status);
    //     `uvm_delay(1000ns)
    //     uvm_reg_data_t data;
    //     my_regmodel.reg_command.read(status, data);
    //     my_regmodel.reg_status.read(status, data);
    // endtask

    // Reset to complete fsm transaction
    task test12(input uvm_status_e status);
        uvm_reg_data_t data;
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(200ns)

        // reset in start state
        my_regmodel.reg_command.write(status, 8'b0000_1110);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(300ns)

        // Reset in write address state
        my_regmodel.reg_command.write(status, 8'b0000_1110);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(1650ns)

        // Reset in address ack state
        my_regmodel.reg_command.write(status, 8'b0000_1110);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(1800ns)

        // Reset in write data state
        my_regmodel.reg_command.write(status, 8'b0000_1110);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(3150ns)

        // Reset in data ack state
        my_regmodel.reg_command.write(status, 8'b0000_1110);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        my_regmodel.reg_transmit.write(status, 0);
        my_regmodel.reg_transmit.write(status, 1);
        my_regmodel.reg_command.write(status, 8'b11111110);
        `uvm_delay(5000ns)

        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0000);
        `uvm_delay(3300ns)

        // Reset to read state
        my_regmodel.reg_command.write(status, 8'b0000_1110);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0001);
        my_regmodel.reg_command.write(status, 8'b11111100);
        `uvm_delay(4700ns)

        // Reset to read state
        my_regmodel.reg_command.write(status, 8'b0000_1110);
        my_regmodel.reg_command.write(status, 8'b11110110);
        my_regmodel.reg_address.write(status, 8'b0010_0001);
        my_regmodel.reg_command.write(status, 8'b11111100);
        `uvm_delay(5000ns)

        my_regmodel.reg_receive.read(status, data);
        `uvm_delay(1000ns)
    endtask
endclass
`endif
 