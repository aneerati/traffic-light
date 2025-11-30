`default_nettype none
module sixbitcounter(
    input  wire clk,     
    input  wire reset,
    output reg  [5:0] Q
);
    reg [5:0] nextQ;
    always_comb begin
        nextQ[5] = Q[5] ^ (Q[4] & Q[3] & Q[2] & Q[1] & Q[0]);
        nextQ[4] = Q[4] ^ (Q[3] & Q[2] & Q[1] & Q[0]);
        nextQ[3] = Q[3] ^ (Q[2] & Q[1] & Q[0]);
        nextQ[2] = Q[2] ^ (Q[1] & Q[0]);
        nextQ[1] = Q[1] ^ Q[0];
        nextQ[0] = ~Q[0];
    end
    always_ff @(posedge clk) begin
        if (reset)
            Q <= 6'b000000;
        else
            Q <= nextQ;
    end
endmodule
