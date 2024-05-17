`ifndef SCOREBOARD
`define SCOREBOARD
`include "packet.sv"

import uvm_pkg::*;
class scoreboard extends uvm_scoreboard;
    byte    data_write [$];
    byte    data_DUT_received [$];
    byte    data_read [$];
    byte    FIFO_status;
    byte    count_reset;
    logic   address_check;
    logic   reset_check;
    integer current_rst_time;
    integer prev_rst_time;
    integer rst_time_diff;
    

    `uvm_component_utils(scoreboard)

    uvm_analysis_imp #(packet, scoreboard) scoreboard_analysis_imp;

    // CONSTUCTOR
    function new(string name = "scoreboard", uvm_component parent);
        super.new(name, parent);
        count_reset         = 0;
        address_check       = 0;
        reset_check         = 0;
        current_rst_time    = 0;
        prev_rst_time       = 0;
        rst_time_diff       = 0;
    endfunction: new

    // BUILD PHASE
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "SCOREBOARD BUILD PHASE", UVM_MEDIUM)
        super.build_phase(phase);
        scoreboard_analysis_imp = new("scoreboard_analysis_imp", this); 
    endfunction

    // EXTRACT PHASE
    virtual function void extract_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "\n--------------------------------------------------------------------------------------------------------", UVM_MEDIUM)
        `uvm_info(get_name(), "SCOREBOARD EXTRACT PHASE", UVM_MEDIUM)

        // Size of data queue DUT received
        `uvm_info(get_name(), $sformatf("Size of data DUT received queue: %0d", data_DUT_received.size()), UVM_MEDIUM)
        foreach (data_DUT_received[i]) begin
            `uvm_info(get_name(), $sformatf("DUT received: %0h", data_DUT_received[i]), UVM_MEDIUM)
        end
        `uvm_info(get_name(), "\n", UVM_MEDIUM)

        // Size of data queue APB write
        `uvm_info(get_name(), $sformatf("Size of APB write data queue: %0d", data_write.size()), UVM_MEDIUM)
        foreach (data_write[i]) begin
            `uvm_info(get_name(), $sformatf("APB write: %0h", data_write[i]), UVM_MEDIUM)
        end
        `uvm_info(get_name(), "\n", UVM_MEDIUM)

        // Size of data queue APB read
        if (data_read.size() != 0) begin
            `uvm_info(get_name(), $sformatf("Size of APB read data queue: %0d", data_read.size()), UVM_MEDIUM)  
            foreach (data_read[i]) begin
                `uvm_info(get_name(), $sformatf("APB read: %0h", data_read[i]), UVM_MEDIUM)
            end
        end 
        `uvm_info(get_name(), "\n", UVM_MEDIUM)

        // Status and Reset
        `uvm_info(get_name(), $sformatf("FIFO status: %0h (hex)", FIFO_status), UVM_MEDIUM)
        `uvm_info(get_name(), $sformatf("Number of Reset applied: %0d", count_reset), UVM_MEDIUM)
    endfunction

    // CHECK PHASE
    virtual function void check_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "\n--------------------------------------------------------------------------------------------------------", UVM_MEDIUM)
        `uvm_info(get_name(), "SCOREBOARD CHECK PHASE", UVM_MEDIUM)
        if (address_check) begin
            if (data_write.size() != data_DUT_received.size()) begin
                if (count_reset == 1) begin
                    `uvm_error(get_name(), "*  ERROR  *Data queue size mismatch")
                end
                foreach (data_DUT_received[i]) begin
                    if (data_write[i] != data_DUT_received[i])     
                        `uvm_error(get_name(), $sformatf("Data mismatch at index %0d", i))
                end
            end
            else begin
                `uvm_info(get_name(), "*  INFO  *Data queue size match", UVM_MEDIUM)
                foreach (data_write[i]) begin
                    if (data_write[i] != data_DUT_received[i]) 
                        `uvm_error(get_name(), $sformatf("*  ERROR  *Data mismatch at index %0d", i))
                end
            end
        end
        else begin
            `uvm_info(get_name(), "Address mismatch", UVM_MEDIUM)
        end
    endfunction

    // WRITE METHOD
    virtual function void write(packet my_packet);
        //  PUSH DATA TO QUEUE
        if (my_packet.PADDR == 4) begin
            data_write.push_back(my_packet.PWDATA);
        end

        // CHECK I2C SLAVE ADDRESS VALID
        if (my_packet.PADDR == 6) begin
            if(my_packet.PWDATA == 8'b0010_0000 || my_packet.PWDATA == 8'b0010_0001) begin
                address_check = 1;
            end
            else begin
                address_check = 0;
            end
        end

        // CHECK RESETn
        if (my_packet.PADDR == 2) begin
            if (my_packet.PWDATA == 8'b11110110 || my_packet.PWDATA == 8'b0000_0110) begin
                reset_check = 1;
                prev_rst_time = current_rst_time;
                current_rst_time = $time;
                rst_time_diff = current_rst_time - prev_rst_time;
                `uvm_info(get_name(), $sformatf("Reset applied at %t", $time), UVM_MEDIUM)
            end
            else begin
                reset_check = 0;
            end
        end

        // IF RESETn IS APPLIED, POP DATA FROM QUEUE
        if (reset_check) begin
            if (rst_time_diff < 1280) begin
                data_write.pop_back();
                `uvm_info(get_name(), $sformatf("Pop back 1 at %t", $time), UVM_MEDIUM)
            end
        end
    endfunction
endclass: scoreboard
`endif

