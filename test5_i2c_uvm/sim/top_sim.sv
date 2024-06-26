`include "uvm_macros.svh"
`include "interface.sv"
`include "test.sv"
`include "assertion.sv"
import uvm_pkg::*;

module top_sim();
    bit PCLK = 0;
    bit clk = 0;
    always #5 PCLK = ~PCLK;
    always #20 clk = ~clk;

    intf my_intf(PCLK, clk);
    apb_to_i2c_top DUT
    (
        .PCLK       (PCLK),
        .clk        (clk),
        .PRESETn    (my_intf.PRESETn),
        .PSELx      (my_intf.PSELx),
        .PENABLE    (my_intf.PENABLE),
        .PWRITE     (my_intf.PWRITE),
        .i2c_sda    (my_intf.sda),
        .i2c_scl    (my_intf.scl),
        .PADDR      (my_intf.PADDR),
        .PWDATA     (my_intf.PWDATA),
        .PREADY     (my_intf.PREADY),
        .PRDATA     (my_intf.PRDATA)
    );

    i2c_slave_model SLAVE
    (
        .sda        (my_intf.sda),
        .scl        (my_intf.scl),
        .check_data (my_intf.check_data),
        .read_data  (my_intf.read_data),
        .saved_data (my_intf.saved_data)
    ); 

    assertion_cov acov(my_intf);


    initial begin
        uvm_config_db#(virtual intf)::set(null, "*", "my_intf", my_intf);
        run_test("test");
    end
endmodule
