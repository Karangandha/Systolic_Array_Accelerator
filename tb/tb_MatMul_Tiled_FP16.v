module tb_MatMul_Tiled_FP16;

    reg clk;
    reg rst;
    wire [31:0] cycle_count;

    MatMul_Tiled_FP16 dut (
        .clk(clk),
        .rst(rst),
        .cycle_count(cycle_count)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #20 rst = 0;

        #500;
        $display("Simulation completed");
        $display("Total cycles: %d", cycle_count);
        $stop;
    end
endmodule

