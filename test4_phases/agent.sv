`ifndef AGENT
`define AGENT

`include "uvm_macros.svh"
`include "driver.sv"
import uvm_pkg::*;

class agent extends uvm_agent;
    `uvm_component_utils(agent)
    driver drvr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        drvr = driver::type_id:create("drvr", this);
    endfunction
endclass
`endif