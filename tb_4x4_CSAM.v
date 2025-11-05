`timescale 1ns/1ps

module tb_approx_mult4x4_csam;

    reg clk;
    reg [3:0] A, B;
    wire [7:0] P;

    // Instantiate DUT
    approx_mult4x4_csam uut (
        .A(A),
        .B(B),
        .P(P)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_approx_mult4x4_csam.vcd");
        $dumpvars(0, tb_approx_mult4x4_csam);

        $display("Time\tClk\tA\tB\tP (Approx)\tRef\tError");

        A = 4'd0;  B = 4'd0; repeat(1) @(posedge clk);
        A = 4'd1;  B = 4'd1; repeat(1) @(posedge clk);
        A = 4'd3;  B = 4'd5; repeat(1) @(posedge clk);
        A = 4'd15; B = 4'd15;repeat(1) @(posedge clk);
        A = 4'd10; B = 4'd6; repeat(1) @(posedge clk);
        A = 4'd5;  B = 4'd9; repeat(1) @(posedge clk);

        $finish;
    end

    // Monitor output and error
    always @(posedge clk) begin
        $display("%0dns\t%b\t%d\t%d\t%d\t%d\t%d",
            $time, clk, A, B, P, A*B, (P - (A*B)));
    end

endmodule
