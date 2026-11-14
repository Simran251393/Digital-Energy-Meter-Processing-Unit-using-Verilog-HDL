// Project: Digital Energy-Meter Processing Unit
// Module: energy_meter
// Description: Calculates power and accumulates energy
`timescale 1ns/1ps
module energy_meter (
    input  wire       clk,
    input  wire       rst,
    input  wire       sample_valid,
    input  wire [7:0] voltage_in,
    input  wire [7:0] current_in,

    output reg  [15:0] power_out,
    output reg  [31:0] energy_out
);

    always @(posedge clk) begin
        if (rst) begin
            power_out  <= 16'd0;
            energy_out <= 32'd0;
        end
        else if (sample_valid) begin
            power_out  <= voltage_in * current_in;
            energy_out <= energy_out
                        + (voltage_in * current_in);
        end
    end

endmodule
