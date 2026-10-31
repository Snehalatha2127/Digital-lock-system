Digital Lock System Using Verilog

Project Overview

This project implements a digital lock system using Verilog Hardware Description Language (HDL). The system checks a predefined password sequence and generates outputs indicating whether the lock is open or an incorrect key has been entered.

Password

The predefined password is:

1 → 2 → 3 → 4

The lock opens when the keys are entered in the correct order.

Features

- Clock-driven digital lock.
- Synchronous reset.
- Password verification using a Finite State Machine (FSM).
- Detection of incorrect key entries.
- Simulation using a Verilog testbench.

Tools Used

- Xilinx Vivado
- Verilog HDL
- Behavioral Simulation

Input Signals

Signal| Description
"clk"| Clock input
"reset"| Resets the lock
"key[3:0]"| Four-bit input representing each key value
"key_valid"| Indicates that a key is being entered

Output Signals

Signal| Description
"lock_open"| Becomes HIGH when the correct password is entered
"wrong_key"| Pulses HIGH when an incorrect key is detected

Project Files

- "digital_lock.v" — Main design module.
- "digital_lock_tb.v" — Testbench for simulation.
- "digital_lock_waveform.png" — Simulation waveform.
- "Digital_Lock_Demo.mp4" — Simulation demonstration video.
- "digital_lock.png"

How to Run

1. Open Xilinx Vivado.
2. Create or open a Verilog project.
3. Add "digital_lock.v" as a design source.
4. Add "digital_lock_tb.v" as a simulation source.
5. Run Behavioral Simulation.
6. Inspect the input and output waveforms.

Expected Result

The lock opens when the keys "1 → 2 → 3 → 4" are entered in the correct order. Incorrect key sequences should keep the lock closed and activate the "wrong_key" output.
