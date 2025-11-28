`default_nettype none
module sixbitcounter(
    input  wire clk,     
    input  wire reset,
    input wire button,
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
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 6'b000000;
        else if( Q == 6'b100001 && button)
            Q <= 6'b000000;
        else if(Q == 6'b011101 && !button)
            Q <= 6'b000000;
        else
            Q <= nextQ;
    end
endmodule