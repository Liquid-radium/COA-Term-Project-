// Approximate 4x4 multiplier using LUT sharing (LSAM variant)
module approx_mult4x4_lsam (
    input [3:0] A,
    input [3:0] B,
    output [7:0] P
);
    wire [5:0] P_low, P_high;

    // Partial products: lower and upper as before
    assign P_low  = A * B[1:0];

    // For LUT sharing: Use same partial product for two product positions (simplified concept)
    // e.g., only calculate one partial product for B[3:2], apply result to two product places
    wire [5:0] shared_high = A * {B[2], B[2]}; // Share B[2] for approximation

    // Combine, shifting the shared value
    assign P = P_low + (shared_high << 2);

    // Note: This is a simplified illustration! The real sharing structure can be made more
    // precise by mapping which bits to merge based on actual logical overlap.
endmodule
