module clock_generator;
    logic clk;

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
endmodule