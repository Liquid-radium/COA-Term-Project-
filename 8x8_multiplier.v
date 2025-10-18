// 4x4 Accurate Multiplier
module mult4x4 (
    input [3:0] A,
    input [3:0] B,
    output [7:0] P
);
    assign P = A * B; // Synthesis will map this to LUT + carry chain
endmodule

// 8x8 Accurate Multiplier
module mult8x8_accurate (
    input [7:0] A,
    input [7:0] B,
    output [15:0] P
);
    // Split into high and low nibbles
    wire [3:0] A_hi = A[7:4];
    wire [3:0] A_lo = A[3:0];
    wire [3:0] B_hi = B[7:4];
    wire [3:0] B_lo = B[3:0];

    // Partial products
    wire [7:0] P0, P1, P2, P3;
    mult4x4 u0 (.A(A_lo), .B(B_lo), .P(P0));
    mult4x4 u1 (.A(A_hi), .B(B_lo), .P(P1));
    mult4x4 u2 (.A(A_lo), .B(B_hi), .P(P2));
    mult4x4 u3 (.A(A_hi), .B(B_hi), .P(P3));

    // Combine partial products
    assign P = {P3, 8'b0} + ({P2, 4'b0}) + ({P1, 4'b0}) + P0;
endmodule
