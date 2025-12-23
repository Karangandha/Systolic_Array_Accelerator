module PE_FP16 (
    input clk,
    input rst,
    input signed [15:0] a_in,
    input signed [15:0] b_in,
    input signed [31:0] sum_in,
    output reg signed [31:0] sum_out,
    output reg signed [15:0] a_out,
    output reg signed [15:0] b_out
);

    wire signed [31:0] mul;
    assign mul = a_in * b_in;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sum_out <= 0;
            a_out   <= 0;
            b_out   <= 0;
        end else begin
            sum_out <= sum_in + mul;
            a_out   <= a_in;
            b_out   <= b_in;
        end
    end
endmodule
