# Digital Energy-Meter Processing Unit using Verilog HDL

## About the Project

This project implements a digital energy-meter processing unit using Verilog HDL. It takes voltage and current samples as inputs, calculates their product to obtain power, and maintains a cumulative sum of the calculated values.

The design uses synchronous logic and processes new data only when the `sample_valid` signal is enabled.

## Main Features

- 8-bit voltage and current inputs
- 16-bit power output
- 32-bit cumulative energy register
- Synchronous reset
- Sample-based data processing
- Output hold when no valid sample is available

## Working Principle

The unit calculates power using:

**Power = Voltage × Current**

For every valid sample, the calculated value is stored in `power_out` and added to `energy_out`. The accumulated value is cleared when reset is activated.

## Verification

The RTL design was simulated using a Verilog testbench. The following operations were checked:

- Reset and output clearing
- Power calculation
- Accumulation of multiple samples
- Output retention when `sample_valid` is low
- Maximum input multiplication

## Tools Used

- Verilog HDL
- RTL simulation
- Yosys – Logic synthesis


## Project Structure

```text
rtl/          - Verilog design & Testbench files
simulation/   - Simulation results
synthesis/    - Synthesis reports

```

