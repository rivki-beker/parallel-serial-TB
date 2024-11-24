module parallel_to_serial (
    tb_if.dut_mp tb_if 
);
    reg [7:0] shift_register;
    
    always_ff @(posedge tb_if.clk or posedge tb_if.rst) begin
        if(tb_if.rst)
            shift_register <= 8'b0;
        else if (tb_if.load)
            shift_register <= tb_if.parallel_in;
        else
            shift_register <= {1'b0, shift_register[7:1]};
    end
    
    assign tb_if.serial_out = shift_register[0];
endmodule
