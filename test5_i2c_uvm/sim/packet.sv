`ifndef PKT
`define PKT
`include "uvm_macros.svh"

import uvm_pkg::*;
class packet extends uvm_sequence_item;
    `uvm_object_utils(packet)
    bit PRESETn;
    bit PSELx;
    bit PENABLE;
    bit PWRITE;
    bit [7:0] PADDR;
    bit [7:0] PWDATA;
    function new(string name = "packet");
        super.new(name);
    endfunction


endclass
`endif 