`timescale 1ns/1ps

module CLA_4bits (
    input clk,
    input enable,
    input [3:0] A, B,
    input Cin,
    output [4:0] Q
);
    // Declare wires
    wire [3:0] G, P, S;
    wire [4:0] C;
    wire [3:0] Sum;
    wire Cout;
    wire [4:0] result;

    // Assign initial carry-in
    assign C[0] = Cin;

// propogate:
assign P = A ^ B;

//assign P[0] = A[0] ^ B[0];
//assign P[1] = A[1] ^ B[1];
//assign P[2] = A[2] ^ B[2];
//assign P[3] = A[3] ^ B[3];

// Generate
assign G = A & B;
//assign G[0] = A[0] & B[0];
//assign G[1] = A[1] & B[1];
//assign G[2] = A[2] & B[2];
//assign G[3] = A[3] & B[3];

//carry outs
assign C[1]= G[0] | (P[0]&C[0]);
assign C[2]= G[1] | (P[1]&(G[0] | (P[1] & P[0]& C[0])));
assign C[3]= G[2] | (P[2]&(G[1]) | (P[2] & P[1]& G[0]) | (P[2] & P[1] & P[0] & C[0]));
assign C[4]= G[3] | (P[3]&G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1]&G[0]) | (P[3] & P[2] & P[1] & P[0]&C[0]);
  
                
// sum
  assign S[0] = P[0] ^ C[0];
  assign S[1] = P[1] ^ G[0] | (P[0]&C[0]);
  assign S[2] = P[2] ^ G[1] | (P[1]&(G[0] | (P[1] & P[0]& C[0])));
  assign S[3] = P[3] ^ G[2] | (P[2]&(G[1]) | (P[2] & P[1]& G[0]) | (P[2] & P[1] & P[0] & C[0]));
  
  assign Cout = C[4];
  assign Sum = S;
  assign result = {Cout, Sum};  // MSB = carry out, LSB = sum

    register_logic reg1 (.clk(clk), .enable(enable), .Data(result), .Q(Q));
endmodule


