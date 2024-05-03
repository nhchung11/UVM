`ifndef ASSERT
`define ASSERT

module assertion_cov(intf my_intf);
    // PREADY CHECK
    PREADY_CHECK: cover property (@(posedge my_intf.PCLK) (my_intf.PSELx & !my_intf.PENABLE) |=> (my_intf.PENABLE));

    WRITE_REGISTER_CHECK: cover property(@(posedge my_intf.PCLK) ((my_intf.PADDR == 2) || (my_intf.PADDR == 4) || (my_intf.PADDR == 6)) |-> (my_intf.PWRITE));

    READ_REGISTER_CHECK: cover property (@(posedge my_intf.PCLK) ((my_intf.PADDR == 3) || (my_intf.PADDR == 5)) |-> (!my_intf.PWRITE));
endmodule
`endif 