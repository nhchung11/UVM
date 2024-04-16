`ifndef PKT
`define PKT
`include "uvm_macros.svh"

import uvm_pkg::*;
class packet extends uvm_sequence_item;
    `uvm_component_utils(packet)
    rand bit [7:0] input_1;
    rand bit [7:0] input_2;

    bit [8:0] output_3;
    function new(string name);
        super.new(name);
    endfunction: new
endclass
`endif 