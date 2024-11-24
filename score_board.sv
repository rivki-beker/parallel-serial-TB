module score_board#(parameter NUM_ITEMS = 10)(
    input logic [NUM_ITEMS-1:0] [7:0] parallel_in_mon,
    input logic [NUM_ITEMS-1:0] [7:0] serial_in_mon
    );

    int error_cnt = 0;

    final begin  // executes after $finish
      for (int i = 0; i < NUM_ITEMS; i++) begin
        for (int j =0; j < 8; j++) // order of output starts from LSB
            if (serial_in_mon [i] [j] !== parallel_in_mon [i] [j]) begin  // use !== to capture &#39;x&#39;
                $error("Error in item %0d, bit %0d: EXPECTED: %b, ACTUAL: %b", i, j, parallel_in_mon[i][j], serial_in_mon[i][j]);
                error_cnt++;

            end
        end
        if (error_cnt != 0) $display ("TEST FAIL");
        else $display ("\n\nTEST PASS\n\n");
    end
endmodule