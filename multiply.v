/* Multiplier for nanoV
 *
 * 32x32 -> 32 multiply (mullo)
 *
 * Multiply runs over bits(b) cycles.
 * The user provides the 32-bit value a and the low bit of b.
 * Each cycle:
 * a is added to the result if b is true.
 * a is shifted left (by the user).
 * b is shifted right (by the user).
 *
 * The low bit of the result is presented as d.
 * The full result can be read over 32 cycles by holding read_out high,
 * which causes the result to be shifted right.
 */

module nanoV_mul (
    input clk,

    input [31:0] a,
    input b,

    output d
);

    reg [31:0] accum;
    wire [31:0] next_accum = accum + a;

    always @(posedge clk) begin
        accum <= {1'b0, b ? next_accum[31:1] : accum[31:1]};
    end

    assign d = b ? next_accum[0] : accum[0];

endmodule
