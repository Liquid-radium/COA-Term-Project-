`timescale 1ns/1ps

module tb_4x4_multiplier;

    reg clk;
    reg [3:0] A, B;
    wire [7:0] P;

    // Instantiate DUT
    mult4x4 uut (
        .A(A),
        .B(B),
        .P(P)
    );

    // Clock Generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk; // toggle clock every 5ns

    initial begin
        // Waveform for debugging
        $dumpfile("tb_4x4_multiplier.vcd");
        $dumpvars(0, tb_4x4_multiplier);

        $display("Time\tClk\tA\tB\tP\tExpected");

        A = 4'd0;  B = 4'd0;
        repeat(1) @(posedge clk);
        
        A = 4'd1;  B = 4'd1;
        repeat(1) @(posedge clk);
        
        A = 4'd3;  B = 4'd5;
        repeat(1) @(posedge clk);

        A = 4'd15; B = 4'd15;
        repeat(1) @(posedge clk);

        A = 4'd10; B = 4'd6;
        repeat(1) @(posedge clk);

        $finish;
    end

    // Monitor at each positive clock edge
    always @(posedge clk) begin
        $display("%0dns\t%b\t%d\t%d\t%d\t%d",
                 $time, clk, A, B, P, A*B);
    end

endmodule
