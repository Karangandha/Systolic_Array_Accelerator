module tb_MatMul_Tiled;

    reg clk;
    reg rst;
    wire [31:0] cycle_count;
    wire [31:0] mac_count;
    wire [31:0] skipped_mac_count;

    MatMul_Tiled dut (
        .clk(clk),
        .rst(rst),
        .cycle_count(cycle_count),
        .mac_count(mac_count),
        .skipped_mac_count(skipped_mac_count)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #20 rst = 0;

        #1000;
        $display("Cycles          : %d", cycle_count);
        $display("MACs executed   : %d", mac_count);
        $display("MACs skipped    : %d", skipped_mac_count);
        $stop;
    end
endmodule
