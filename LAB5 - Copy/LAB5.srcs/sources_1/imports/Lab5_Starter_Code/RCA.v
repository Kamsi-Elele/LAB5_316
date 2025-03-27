`timescale 1ns/1ps

module RCA_4bits (
    input clk,
    input enable,
    input [3:0] A, B,
    input Cin,
    output reg [4:0] Q
);

wire [3:0] sum;
    wire [3:0] cout;

    // Full Adder instances
    full_adder adder_0(A[0], B[0], Cin,   sum[0], cout[0]);
    full_adder adder_1(A[1], B[1], cout[0], sum[1], cout[1]);
    full_adder adder_2(A[2], B[2], cout[1], sum[2], cout[2]);
    full_adder adder_3(A[3], B[3], cout[2], sum[3], cout[3]);

    // Register logic
    always @(posedge clk) begin
        if (enable)
            Q <= {cout[3], sum};  // Concatenate carry-out and sum
    end

endmodule



module full_adder (
    input A, B, Cin,
    output S, Cout
);
   assign Cout = B&Cin | A&Cin | A&B;
   assign S = A^B^Cin;
endmodule


