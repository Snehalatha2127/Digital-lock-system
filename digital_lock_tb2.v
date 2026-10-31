`timescale 1ns / 1ps

module digital_lock_tb;

    reg clk;
    reg reset;
    reg [3:0] key;
    reg key_valid;

    wire lock_open;
    wire wrong_key;

    // Instantiate the Digital Lock
    digital_lock uut (
        .clk(clk),
        .reset(reset),
        .key(key),
        .key_valid(key_valid),
        .lock_open(lock_open),
        .wrong_key(wrong_key)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    // Enter one key and allow the circuit to process it
    task enter_key;
        input [3:0] value;
        begin
            @(negedge clk);
            key = value;
            key_valid = 1'b1;

            @(negedge clk);
            key_valid = 1'b0;

            @(negedge clk);
        end
    endtask

    // Reset the lock
    task reset_lock;
        begin
            @(negedge clk);
            reset = 1'b1;
            key_valid = 1'b0;

            @(negedge clk);
            reset = 1'b0;

            @(negedge clk);
        end
    endtask

    initial begin

        // Initialize signals
        clk = 1'b0;
        reset = 1'b1;
        key = 4'd0;
        key_valid = 1'b0;

        // Initial reset
        repeat (2) @(negedge clk);
        reset = 1'b0;

        // TEST 1: Correct password 1, 2, 3, 4
        enter_key(4'd1);
        enter_key(4'd2);
        enter_key(4'd3);
        enter_key(4'd4);

        // Keep lock_open HIGH long enough to see
        repeat (4) @(negedge clk);

        // TEST 2: Reset and enter reverse password 4, 3, 2, 1
        reset_lock();

        enter_key(4'd4);
        enter_key(4'd3);
        enter_key(4'd2);
        enter_key(4'd1);

        // Keep outputs visible
        repeat (3) @(negedge clk);

        // TEST 3: Reset and enter incorrect sequence 1, 3, 2, 4
        reset_lock();

        enter_key(4'd1);
        enter_key(4'd3);
        enter_key(4'd2);
        enter_key(4'd4);

        // Finish after all tests
        repeat (3) @(negedge clk);
        $finish;

    end

endmodule
