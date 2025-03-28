`timescale 1ns / 1ps

module rca_4bits_tb;

    reg clk;
    reg enable;
    reg [3:0] A, B;
    reg Cin;
    wire [4:0] Q;

    parameter period = 10;

    RCA_4bits uut (
        .clk(clk),
        .enable(enable),
        .A(A),
        .B(B),
        .Cin(Cin),
        .Q(Q)
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #(period / 2) clk = ~clk;
    end

    initial begin
        enable = 0;
        A = 4'b0000;
        B = 4'b0000;
        Cin = 1'b0;

        @(negedge clk);
        A = 4'b0001; B = 4'b0101; Cin = 1'b0; enable = 1;
        @(negedge clk); enable = 0;

        @(negedge clk);
        A = 4'b0111; B = 4'b0111; Cin = 1'b0; enable = 1;
        @(negedge clk); enable = 0;

        @(negedge clk);
        A = 4'b1000; B = 4'b0111; Cin = 1'b1; enable = 1;
        @(negedge clk); enable = 0;

        @(negedge clk);
        A = 4'b1100; B = 4'b0100; Cin = 1'b0; enable = 1;
        @(negedge clk); enable = 0;

        @(negedge clk);
        A = 4'b1000; B = 4'b1000; Cin = 1'b1; enable = 1;
        @(negedge clk); enable = 0;

        @(negedge clk);
        A = 4'b1001; B = 4'b1010; Cin = 1'b1; enable = 1;
        @(negedge clk); enable = 0;

        @(negedge clk);
        A = 4'b1111; B = 4'b1111; Cin = 1'b0; enable = 1;
        @(negedge clk); enable = 0;

        @(negedge clk);
        $finish;
    end

endmodule
