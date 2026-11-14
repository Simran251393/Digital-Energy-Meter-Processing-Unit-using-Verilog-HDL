`timescale 1ns/1ps

module testbench;

    reg clk;
    reg rst;
    reg sample_valid;
    reg [7:0] voltage_in;
    reg [7:0] current_in;

    wire [15:0] power_out;
    wire [31:0] energy_out;

    energy_meter dut (
        .clk(clk),
        .rst(rst),
        .sample_valid(sample_valid),
        .voltage_in(voltage_in),
        .current_in(current_in),
        .power_out(power_out),
        .energy_out(energy_out)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, testbench);

        clk = 0;
        rst = 1;
        sample_valid = 0;
        voltage_in = 0;
        current_in = 0;

        // Apply reset
        #10;
        rst = 0;

        // Test 1: 10 x 5 = 50
        voltage_in = 10;
        current_in = 5;
        sample_valid = 1;
        #10;

        if (power_out == 50 && energy_out == 50)
            $display("PASS: Test 1");
        else
            $display("FAIL: Test 1");

        // Test 2: 6 x 5 = 30
        voltage_in = 6;
        current_in = 5;
        #10;

        if (power_out == 30 && energy_out == 80)
            $display("PASS: Test 2");
        else
            $display("FAIL: Test 2");

        // Test 3: Outputs hold
        sample_valid = 0;
        #10;

        if (power_out == 30 && energy_out == 80)
            $display("PASS: Outputs hold");
        else
            $display("FAIL: Hold behavior");

        // Test 4: Reset clears outputs
        rst = 1;
        #10;

        if (power_out == 0 && energy_out == 0)
            $display("PASS: Reset clears outputs");
        else
            $display("FAIL: Reset test");

        rst = 0;

        // Test 5: Maximum inputs (255 x 255)
        voltage_in = 255;
        current_in = 255;
        sample_valid = 1;
        #10;

        if (power_out == 65025 && energy_out == 65025)
            $display("PASS: Maximum input test");
        else
            $display("FAIL: Maximum input test");

        sample_valid = 0;
        #10;

        $finish;
    end

endmodule
