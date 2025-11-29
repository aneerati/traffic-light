`default_nettype none
module trafficComp(
    input logic [2:0] m,
    input logic [2:0] s,
    output logic mGTs,
    output logic mEQs,
    output logic mLTs
    );
    always_comb begin
        mGTs = (m > s);
        mEQs = (m == s);
        mLTs = (m < s);
    end
endmodule
