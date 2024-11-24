module generator #(parameter NUM_ITEMS = 10)(
  output logic [NUM_ITEMS-1:0] [7:0] parallel_in_gen);
    initial begin
      // Generate here all random inputs at time = 0
      //  This is NOT ideal, since uses lots of storage, but is required in Verilog TB
      for (int i = 0; i < NUM_ITEMS; i++)
        parallel_in_gen [i] = $random () % (2^8);
    end
endmodule
