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
        forever #(period/2) clk = ~clk;
    end

    // Test sequence
    initial begin
        enable = 0;
        A = 4'b0000;
        B = 4'b0000;
        Cin = 1'b0;

        @(negedge clk);  apply(4'b0001, 4'b0101, 1'b0);  // 1 + 5
        @(negedge clk);  apply(4'b0111, 4'b0111, 1'b0);  // 7 + 7
        @(negedge clk);  apply(4'b1000, 4'b0111, 1'b1);  // 8 + 7 + 1
        @(negedge clk);  apply(4'b1100, 4'b0100, 1'b0);  // 12 + 4
        @(negedge clk);  apply(4'b1000, 4'b1000, 1'b1);  // 8 + 8 + 1
        @(negedge clk);  apply(4'b1001, 4'b1010, 1'b1);  // 9 + 10 + 1
        @(negedge clk);  apply(4'b1111, 4'b1111, 1'b0);  // 15 + 15

        @(negedge clk);
        $finish;
    end

    // Task to apply inputs on negedge and pulse enable
    task apply(input [3:0] a, input [3:0] b, input c);
        begin
            A <= a;
            B <= b;
            Cin <= c;
            enable <= 1;
            @(negedge clk);  // wait 1 negedge to latch
            enable <= 0;
            @(negedge clk);  // let output settle
            $display("A=%b B=%b Cin=%b | Sum=%b Cout=%b", A, B, Cin, Q[3:0], Q[4]);
        end
    endtask

endmodule
