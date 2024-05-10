`ifndef BASE_SEQ
`define BASE_SEQ
`include "uvm_macros.svh"
`include "../sim/register_model.sv"

class base_sequence extends uvm_sequence;
    `uvm_object_utils(base_sequence)
    register_model my_regmodel;
    rand bit [7:0] random_data;

    function new(string name = "base_sequence");
        super.new(name);
    endfunction
endclass
`endif 