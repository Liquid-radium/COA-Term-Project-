`timescale 1ns / 1ps

module tb_mult8x8;

    // Inputs
    reg [7:0] A, B;

    // Output
    wire [15:0] P;

    // Instantiate the accurate or approximate multiplier
    // Replace 'mult8x8_accurate' with 'mult8x8_approx_lsam' to test the approximate variant
    mult8x8_accurate uut (
        .A(A),
        .B(B),
        .P(P)
    );

    // Reference output for checking
    reg [15:0] ref;

    initial begin
        // Display header
        $display("A      B      |  HW Result   | Reference   | Match?");
        $display("-----------------------------------------------");
        
        // Apply test vectors
        A = 8'd0;  B = 8'd0;     #10 ref = A*B;  $display("%d %d | %d | %d | %s", A, B, P, ref, (P == ref) ? "YES" : "NO");
        A = 8'd255; B = 8'd1;    #10 ref = A*B;  $display("%d %d | %d | %d | %s", A, B, P, ref, (P == ref) ? "YES" : "NO");
        A = 8'd12;  B = 8'd15;   #10 ref = A*B;  $display("%d %d | %d | %d | %s", A, B, P, ref, (P == ref) ? "YES" : "NO");
        A = 8'd100; B = 8'd200;  #10 ref = A*B;  $display("%d %d | %d | %d | %s", A, B, P, ref, (P == ref) ? "YES" : "NO");
        A = 8'd50;  B = 8'd5;    #10 ref = A*B;  $display("%d %d | %d | %d | %s", A, B, P, ref, (P == ref) ? "YES" : "NO");
        A = 8'd128; B = 8'd128;  #10 ref = A*B;  $display("%d %d | %d | %d | %s", A, B, P, ref, (P == ref) ? "YES" : "NO");
        A = 8'd255; B = 8'd255;  #10 ref = A*B;  $display("%d %d | %d | %d | %s", A, B, P, ref, (P == ref) ? "YES" : "NO");

        // Random test loop
        repeat (10) begin
            A = $random;
            B = $random;
            #10 ref = A * B;
            $display("%d %d | %d | %d | %s", A, B, P, ref, (P == ref) ? "YES" : "NO");
        end

        $stop;
    end

endmodule
// Note: To test the approximate multiplier, change the instantiated module