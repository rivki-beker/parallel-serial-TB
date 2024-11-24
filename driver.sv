module driver#(parameter NUM_ITEMS = 10)(
    tb_if.driver_mp tb_if,
    input logic [NUM_ITEMS-1:0] [7:0] parallel_in_gen
    );
    
    int item_cntr;

    initial begin
        item_cntr = 0;
        tb_if.driver_cb.load = 0;
        tb_if.driver_cb.parallel_in = 0;
        
        @ (posedge tb_if.driver_cb.rst);
        repeat (NUM_ITEMS) begin
            @ (tb_if.driver_cb);
            tb_if.driver_cb.load <= '1;
            tb_if.driver_cb.parallel_in <= parallel_in_gen [item_cntr++];
            @ (tb_if.driver_cb);
            tb_if.driver_cb.load <= '0;
            repeat (8) @ (tb_if.driver_cb);
        end
        repeat (10) @ (tb_if.driver_cb);
        $finish();
    end
endmodule
