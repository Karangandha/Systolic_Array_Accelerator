module MatMul_Tiled #(
    parameter N = 16,
    parameter TILE = 4
)(
    input clk,
    input rst,
    output reg [31:0] cycle_count,
    output reg [31:0] mac_count,
    output reg [31:0] skipped_mac_count
);

    reg signed [15:0] A [0:N-1][0:N-1];
    reg signed [15:0] B [0:N-1][0:N-1];
    reg signed [31:0] C [0:N-1][0:N-1];

    integer tr, tc, i, j, k;
    wire signed [31:0] acc_out;
    wire valid_op;

    reg signed [15:0] a_reg, b_reg;
    reg signed [31:0] acc_reg;

    PE_Sparse pe (
        .clk(clk),
        .rst(rst),
        .a(a_reg),
        .b(b_reg),
        .acc_in(acc_reg),
        .acc_out(acc_out),
        .valid_op(valid_op)
    );

    // Cycle counter
    always @(posedge clk or posedge rst) begin
        if (rst)
            cycle_count <= 0;
        else
            cycle_count <= cycle_count + 1;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mac_count <= 0;
            skipped_mac_count <= 0;
            for (i = 0; i < N; i = i + 1)
                for (j = 0; j < N; j = j + 1)
                    C[i][j] <= 0;
        end else begin
            for (tr = 0; tr < N; tr = tr + TILE)
                for (tc = 0; tc < N; tc = tc + TILE)
                    for (k = 0; k < N; k = k + 1)
                        for (i = 0; i < TILE; i = i + 1)
                            for (j = 0; j < TILE; j = j + 1) begin
                                a_reg   <= A[tr+i][k];
                                b_reg   <= B[k][tc+j];
                                acc_reg <= C[tr+i][tc+j];

                                C[tr+i][tc+j] <= acc_out;

                                if (valid_op)
                                    mac_count <= mac_count + 1;
                                else
                                    skipped_mac_count <= skipped_mac_count + 1;
                            end
        end
    end
endmodule
