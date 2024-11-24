module monitor#(parameter NUM_ITEMS = 10)(
    tb_if.monitor_mp tb_if,
    output logic [NUM_ITEMS-1:0] [7:0] parallel_in_mon,
    output logic [NUM_ITEMS-1:0] [7:0] serial_in_mon
    );

    int mon_item_cnt = 0;
    int mon_cycle_cnt = 0;
    
    initial begin
        forever begin
            @ (tb_if.monitor_cb);
            if (tb_if.monitor_cb.load == 1'b1) begin
                parallel_in_mon [mon_item_cnt] = tb_if.monitor_cb.parallel_in;

                `ifdef MONITOR_LOG_ON
                $display("TIME [%0t] : ITEM %0d : Received parallel in: %h", $time(), mon_item_cnt, tb_if.parallel_in);
                `endif

                @ (tb_if.monitor_cb);
                mon_cycle_cnt = 0;
                repeat (8) begin
                    serial_in_mon [mon_item_cnt] [mon_cycle_cnt++] = tb_if.monitor_cb.serial_out;
                    `ifdef MONITOR_LOG_ON
                    $display("TIME [%0t] : Received serial out [%0d] = %b", $time(), (mon_cycle_cnt - 1), tb_if.serial_out);
                    `endif
                    @ (tb_if.monitor_cb);
                end
                ++mon_item_cnt;
            end
        end
    end
endmodule
