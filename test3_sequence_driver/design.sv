interface adpcm_if;

    logic clk;
    logic frame;
    logic[3:0] data;
    logic bozo;
        
    clocking cb @(posedge clk);
        inout frame;
        //input other;
        inout data;
    endclocking
        
    modport mon_mp (clocking cb);

endinterface: adpcm_if