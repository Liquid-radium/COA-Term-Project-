// 4x2 multiplier module
module mult4x2 (
    input [3:0] A,
    input [1:0] B,
    output [5:0] P
);
    assign P = A * B;
endmodule

// 4x4 multiplier using two 4x2 multipliers
module mult4x4 (
    input [3:0] A,
    input [3:0] B,
    output [7:0] P
);
    wire [5:0] P_low, P_high;

    // Lower 2 bits of B
    mult4x2 u0 (
        .A(A),
        .B(B[1:0]),
        .P(P_low)
    );

    // Upper 2 bits of B
    mult4x2 u1 (
        .A(A),
        .B(B[3:2]),
        .P(P_high)
    );

    // Combine results (shift P_high by 2 bits)
    assign P = P_low + (P_high << 2);
endmodule
