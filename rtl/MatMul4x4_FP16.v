module MatMul4x4_FP16 (
    input clk,
    input rst,
    input signed [15:0] A [0:3][0:3],
    input signed [15:0] B [0:3][0:3],
    output signed [31:0] C [0:3][0:3]
);

    integer i, j, k;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 4; i = i + 1)
                for (j = 0; j < 4; j = j + 1)
                    C[i][j] <= 0;
        end else begin
            for (i = 0; i < 4; i = i + 1)
                for (j = 0; j < 4; j = j + 1)
                    for (k = 0; k < 4; k = k + 1)
                        C[i][j] <= C[i][j] + A[i][k] * B[k][j];
        end
    end
endmodule

