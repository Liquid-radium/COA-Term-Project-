`timescale 1ns / 1ps

module tb_mult8x8;

    // Inputs
    reg [7:0] A, B;

    // Output
    wire [15:0] P;

    // Instantiate the accurate or approximate multiplier
    mult8x8_accurate uut (
        .A(A),
        .B(B),
        .P(P)
    );

    // Reference output for checking
    reg [15:0] expected;

    initial begin
        // Display header
        $display("A      B      |  HW Result   | Reference   | Match?");
        $display("----------------------------------------------------");

        // Apply test vectors
        A = 8'd0;    B = 8'd0;     expected = A*B;    $display("%d %d | %d | %d | %s", A, B, P, expected, (P == expected) ? "YES" : "NO");
       #10 A = 8'd255;  B = 8'd1;     expected = A*B;    $display("%d %d | %d | %d | %s", A, B, P, expected, (P == expected) ? "YES" : "NO");
       #10  A = 8'd12;   B = 8'd15;    expected = A*B;    $display("%d %d | %d | %d | %s", A, B, P, expected, (P == expected) ? "YES" : "NO");
       #10  A = 8'd100;  B = 8'd200;   expected = A*B;    $display("%d %d | %d | %d | %s", A, B, P, expected, (P == expected) ? "YES" : "NO");
       #10  A = 8'd50;   B = 8'd5;     expected = A*B;    $display("%d %d | %d | %d | %s", A, B, P, expected, (P == expected) ? "YES" : "NO");
       #10  A = 8'd128;  B = 8'd128;   expected = A*B;    $display("%d %d | %d | %d | %s", A, B, P, expected, (P == expected) ? "YES" : "NO");
       #10  A = 8'd255;  B = 8'd255;   expected = A*B;    $display("%d %d | %d | %d | %s", A, B, P, expected, (P == expected) ? "YES" : "NO");

        // Random tests
        repeat (10) begin
            A = $random;
            B = $random;
            expected = A * B;
            $display("%d %d | %d | %d | %s", A, B, P, expected, (P == expected) ? "YES" : "NO");
        end

        $stop;
    end

endmodule
