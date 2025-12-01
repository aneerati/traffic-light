`default_nettype none
module clock
(
    input logic clk,
    input logic reset, 
    input logic [5:0] counter,
    input logic PED, 
    input logic [2:0] mainTrafficIn,
    input logic [2:0] sideTrafficIn,
    output logic enable
);
    logic [2:0] mainCurrent, mainNext;
    logic [2:0] sideCurrent, sideNext;
    logic mGTs;
    logic mLTs;
    assign mainNext = (counter == 6'd0) ? mainTrafficIn : mainCurrent;
    assign sideNext = (counter == 6'd0) ? sideTrafficIn : sideCurrent;
    reg3 mainReg (.clk(clk), .reset(reset),
                  .d(mainNext), .q(mainCurrent));
    reg3 sideReg (.clk(clk), .reset(reset),
                  .d(sideNext), .q(sideCurrent));
    trafficComp comp (.m(mainCurrent),
                      .s(sideCurrent),
                      .mGTs(mGTs),
                      .mLTs(mLTs));
always_comb begin
    enable = 1'b0;
    if (PED) begin
        if (mGTs)
            enable = (counter == 6'd14 ||
                      counter == 6'd16 ||
                      counter == 6'd18 ||
                      counter == 6'd24 ||
                      counter == 6'd26 ||
                      counter == 6'd28 ||
                      counter == 6'd38);
        else if (mLTs)
            enable = (counter == 6'd10 ||
                      counter == 6'd12 ||
                      counter == 6'd14 ||
                      counter == 6'd28 ||
                      counter == 6'd30 ||
                      counter == 6'd32 ||
                      counter == 6'd42);
        else 
            enable = (counter == 6'd10 ||
                      counter == 6'd12 ||
                      counter == 6'd14 ||
                      counter == 6'd24 ||
                      counter == 6'd26 ||
                      counter == 6'd28 ||
                      counter == 6'd38);
    end
    else begin
        if (mGTs)
            enable = (counter == 6'd14 ||
                      counter == 6'd16 ||
                      counter == 6'd18 ||
                      counter == 6'd24 ||
                      counter == 6'd26 ||
                      counter == 6'd28);
        else if (mLTs)
            enable = (counter == 6'd10 ||
                      counter == 6'd12 ||
                      counter == 6'd14 ||
                      counter == 6'd28 ||
                      counter == 6'd30 ||
                      counter == 6'd32);
        else 
            enable = (counter == 6'd10 ||
                      counter == 6'd12 ||
                      counter == 6'd14 ||
                      counter == 6'd24 ||
                      counter == 6'd26 ||
                      counter == 6'd28);
    end
end
endmodule
