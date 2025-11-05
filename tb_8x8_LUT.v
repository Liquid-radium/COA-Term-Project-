`timescale 1ns / 1ps

module tb_mult8x8_approx_lsam;

    // Inputs
    reg [7:0] A, B;

    // Output
    wire [15:0] P;

    // Instantiate the LSAM approximate multiplier
    mult8x8_approx_lsam uut (
        .A(A),
        .B(B),
        .P(P)
    );

    // Reference output for checking
    reg [15:0] expected;

    initial begin
        // Display header
        $display("A     B     |  Approx (HW) | Reference | Err | Match?");
        $display("-------------------------------------------------------");

        // Apply explicit vectors
        A = 8'd0;    B = 8'd0;    #10 expected = A*B;    $display("%3d  %3d | %6d       | %6d    | %4d | %s", A, B, P, expected, P-expected, (P==expected) ? "YES" : "NO");
        A = 8'd255;  B = 8'd1;    #10 expected = A*B;    $display("%3d  %3d | %6d       | %6d    | %4d | %s", A, B, P, expected, P-expected, (P==expected) ? "YES" : "NO");
        A = 8'd12;   B = 8'd15;   #10 expected = A*B;    $display("%3d  %3d | %6d       | %6d    | %4d | %s", A, B, P, expected, P-expected, (P==expected) ? "YES" : "NO");
        A = 8'd100;  B = 8'd200;  #10 expected = A*B;    $display("%3d  %3d | %6d       | %6d    | %4d | %s", A, B, P, expected, P-expected, (P==expected) ? "YES" : "NO");
        A = 8'd50;   B = 8'd5;    #10 expected = A*B;    $display("%3d  %3d | %6d       | %6d    | %4d | %s", A, B, P, expected, P-expected, (P==expected) ? "YES" : "NO");
        A = 8'd128;  B = 8'd128;  #10 expected = A*B;    $display("%3d  %3d | %6d       | %6d    | %4d | %s", A, B, P, expected, P-expected, (P==expected) ? "YES" : "NO");
        A = 8'd255;  B = 8'd255;  #10 expected = A*B;    $display("%3d  %3d | %6d       | %6d    | %4d | %s", A, B, P, expected, P-expected, (P==expected) ? "YES" : "NO");

        // Random tests
        repeat (10) begin
            A = $random;
            B = $random;
            #10 expected = A * B;
            $display("%3d  %3d | %6d       | %6d    | %4d | %s", A, B, P, expected, P-expected, (P==expected) ? "YES" : "NO");
        end

        $stop;
    end

endmodule
