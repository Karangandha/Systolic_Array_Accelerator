module PE_Sparse (
    input clk,
    input rst,
    input signed [15:0] a,
    input signed [15:0] b,
    input signed [31:0] acc_in,
    output reg signed [31:0] acc_out,
    output reg valid_op   // tells if MAC happened
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            acc_out  <= 0;
            valid_op <= 0;
        end else begin
            if (a != 0 && b != 0) begin
                acc_out  <= acc_in + a * b;
                valid_op <= 1;   // MAC executed
            end else begin
                acc_out  <= acc_in;
                valid_op <= 0;   // MAC skipped
            end
        end
    end
endmodule
