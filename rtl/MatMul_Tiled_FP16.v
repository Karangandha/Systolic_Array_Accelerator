module MatMul_Tiled_FP16 (
    input clk,
    input rst,
    output reg [31:0] cycle_count
);

    parameter N = 16;
    parameter TILE = 4;

    reg signed [15:0] A [0:N-1][0:N-1];
    reg signed [15:0] B [0:N-1][0:N-1];
    reg signed [31:0] C [0:N-1][0:N-1];

    integer i, j, k, tr, tc;

    always @(posedge clk or posedge rst) begin
        if (rst)
            cycle_count <= 0;
        else
            cycle_count <= cycle_count + 1;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < N; i = i + 1)
                for (j = 0; j < N; j = j + 1)
                    C[i][j] <= 0;
        end else begin
            for (tr = 0; tr < N; tr = tr + TILE)
                for (tc = 0; tc < N; tc = tc + TILE)
                    for (k = 0; k < N; k = k + 1)
                        for (i = 0; i < TILE; i = i + 1)
                            for (j = 0; j < TILE; j = j + 1)
                                C[tr+i][tc+j] <= C[tr+i][tc+j]
                                    + A[tr+i][k] * B[k][tc+j];
        end
    end
endmodule
