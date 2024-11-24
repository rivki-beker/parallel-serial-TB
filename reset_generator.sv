module reset_generator;
    logic rst;

    initial begin
        rst = '0;
        #12 rst = '1;
    end
endmodule