`default_nettype none
module reg3(
    input logic [2:0] d,
    input logic reset,
    input logic clk,
    output logic [2:0] q
    );
    always_ff @(posedge clk or posedge reset)
        if (reset)
            q <= 3'd0;
        else
            q <= d;
endmodule
