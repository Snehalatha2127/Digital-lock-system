`timescale 1ns / 1ps
 module digital_lock (
    input wire clk,
    input wire reset,
    input wire [3:0] key,
    input wire key_valid,
    output reg lock_open,
    output reg wrong_key
);

    reg [2:0] state;

    parameter S0 = 3'd0,
              S1 = 3'd1,
              S2 = 3'd2,
              S3 = 3'd3;

    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            lock_open <= 1'b0;
            wrong_key <= 1'b0;
        end
        else begin
            // Clear the wrong-key indication after one clock cycle
            wrong_key <= 1'b0;

            // Process keys only while the lock is closed
            if (key_valid && !lock_open) begin
                case (state)

                    S0: begin
                        if (key == 4'd1)
                            state <= S1;
                        else begin
                            state <= S0;
                            wrong_key <= 1'b1;
                        end
                    end

                    S1: begin
                        if (key == 4'd2)
                            state <= S2;
                        else begin
                            state <= S0;
                            wrong_key <= 1'b1;
                        end
                    end

                    S2: begin
                        if (key == 4'd3)
                            state <= S3;
                        else begin
                            state <= S0;
                            wrong_key <= 1'b1;
                        end
                    end

                    S3: begin
                        if (key == 4'd4) begin
                            lock_open <= 1'b1;
                            state <= S0;
                        end
                        else begin
                            state <= S0;
                            wrong_key <= 1'b1;
                        end
                    end

                    default: state <= S0;

                endcase
            end
        end
    end

endmodule
