module tb ();

    localparam NUM_ITEMS = 10;
    
    clock_generator clk_gen();
    reset_generator rst_gen();

    tb_if tb_if(.clk(clk_gen.clk), .rst(rst_gen.rst));

    logic [NUM_ITEMS-1:0] [7:0] parallel_in_gen;

    generator #(.NUM_ITEMS) gen(.*);
    driver #(.NUM_ITEMS) drv (.tb_if(tb_if.driver_mp), .parallel_in_gen);

    logic [NUM_ITEMS-1:0] [7:0] parallel_in_mon;
    logic [NUM_ITEMS-1:0] [7:0] serial_in_mon;

    monitor #(.NUM_ITEMS) mon(.tb_if(tb_if.monitor_mp), .parallel_in_mon, .serial_in_mon);
    score_board #(.NUM_ITEMS) sb(.parallel_in_mon, .serial_in_mon);
    parallel_to_serial dut (.tb_if(tb_if.dut_mp));

endmodule
