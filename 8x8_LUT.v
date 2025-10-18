// 4x4 Approximate Multiplier using (Simple) LUT Sharing
module approx_mult4x4_lsam (
    input [3:0] A,
    input [3:0] B,
    output [7:0] P
);
    // Partial products (share B[2] for approximation in both upper/lower half)
    wire [5:0] P_low = A * B[1:0];
    wire [5:0] shared_high = A * {B[2], B[2]}; // Approximate by merging B[3] and B[2]
    assign P = {2'b00, shared_high} + {2'b00, P_low}; // Shift shared_high as needed
    // Note: You can customize this further based on your preferred approximation degree!
endmodule

// 8x8 Approximate Multiplier (using four LSAM 4x4 units)
module mult8x8_approx_lsam (
    input [7:0] A,
    input [7:0] B,
    output [15:0] P
);
    // Split into nibbles
    wire [3:0] A_hi = A[7:4];
    wire [3:0] A_lo = A[3:0];
    wire [3:0] B_hi = B[7:4];
    wire [3:0] B_lo = B[3:0];

    // Partial products
    wire [7:0] P0, P1, P2, P3;
    approx_mult4x4_lsam u0 (.A(A_lo), .B(B_lo), .P(P0));
    approx_mult4x4_lsam u1 (.A(A_hi), .B(B_lo), .P(P1));
    approx_mult4x4_lsam u2 (.A(A_lo), .B(B_hi), .P(P2));
    approx_mult4x4_lsam u3 (.A(A_hi), .B(B_hi), .P(P3));

    // Combine partial products
    assign P = {P3, 8'b0} + ({P2, 4'b0}) + ({P1, 4'b0}) + P0;
endmodule
