interface tb_if(
    input clk,
    input rst
    );
    logic load;
    logic [7:0] parallel_in;
    logic serial_out;
    
    clocking driver_cb @(posedge clk);
        default input #1step output #1;
        input rst;
        output load;
        output parallel_in;
    endclocking
    
    clocking monitor_cb @(posedge clk);
        default input #1step output #1;
        input load;
        input parallel_in;
        input serial_out;
    endclocking

    modport driver_mp (clocking driver_cb);
    modport monitor_mp (clocking monitor_cb);
    modport dut_mp (input load, input parallel_in, output serial_out, input clk, input rst);
endinterface
