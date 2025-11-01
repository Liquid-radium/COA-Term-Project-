`timescale 1ns/1ps

module tb_4x4_multiplier;
    reg [3:0] A, B;
    wire [7:0] P;

    // Instantiate the 4x4 multiplier
    mult4x4 uut (
        .A(A),
        .B(B),
        .P(P)
    );

    initial begin
        $display("A\tB\tP\tExpected");
        // Test cases
        A = 4'b0000; B = 4'b0000; #10;
        $display("%d\t%d\t%d\t%d", A, B, P, A*B);

        A = 4'b0001; B = 4'b0001; #10;
        $display("%d\t%d\t%d\t%d", A, B, P, A*B);

        A = 4'b0011; B = 4'b0101; #10;
        $display("%d\t%d\t%d\t%d", A, B, P, A*B);

        A = 4'b1111; B = 4'b1111; #10;
        $display("%d\t%d\t%d\t%d", A, B, P, A*B);

        A = 4'b1010; B = 4'b0110; #10;
        $display("%d\t%d\t%d\t%d", A, B, P, A*B);

        $finish;
    end
endmodule