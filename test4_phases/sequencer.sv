`ifndef SEQR
`define SEQR

// `include "packet.sv"
// `include "uvm_macros.svh"
import uvm_pkg::*;

class seqr extends uvm_sequencer #(packet);
    `uvm_component_utils(seqr)
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // // BUILD PHASE
    // function void build_phase(uvm_phase phase);

    // endfunction

    // // CONNECT PHASE
    // function void connect_phase(uvm_phase phase);

    // endfunction

    // // RUN PHASE
    // function void run_phase(uvm_phase phase);

    // endfunction
endclass: seqr
`endif 