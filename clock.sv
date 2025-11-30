module clock
(
    input logic [5:0] counter,
    input logic PED, 
    input logic [2:0] mainTrafficIn,
    input logic [2:0] sideTrafficIn,
    output logic enable
);

    
    logic [2:0] mainTraffic;
    logic [2:0] sideTraffic;
    logic mGTs;
    logic mLTs;
    
    trafficComp comp (.m(mainTraffic),
                      .s(sideTraffic),
                      .mGTs(mGTs),
                      .mLTs(mLTs));
    
    
always_comb begin
    enable = 1'b0;
    mainTraffic = 3'b0;
    sideTraffic = 3'b0;
    if (counter == 6'd0) begin
        mainTraffic = mainTrafficin;
        sideTraffic = sideTrafficin;
    end
    if (PED) begin
        if (mGTs)
            enable = (counter == 6'd15 ||
                      counter == 6'd17 ||
                      counter == 6'd19 ||
                      counter == 6'd25 ||
                      counter == 6'd27 ||
                      counter == 6'd29 ||
                      counter == 6'd39);
        else if (mLTs)
            enable = (counter == 6'd11 ||
                      counter == 6'd13 ||
                      counter == 6'd15 ||
                      counter == 6'd29 ||
                      counter == 6'd31 ||
                      counter == 6'd33 ||
                      counter == 6'd43);
        else 
            enable = (counter == 6'd11 ||
                      counter == 6'd13 ||
                      counter == 6'd15 ||
                      counter == 6'd25 ||
                      counter == 6'd27 ||
                      counter == 6'd29 ||
                      counter == 6'd39);
    end
    else begin
        if (mGTs)
            enable = (counter == 6'd15 ||
                      counter == 6'd17 ||
                      counter == 6'd19 ||
                      counter == 6'd25 ||
                      counter == 6'd27 ||
                      counter == 6'd29);
        else if (mLTs)
            enable = (counter == 6'd11 ||
                      counter == 6'd13 ||
                      counter == 6'd15 ||
                      counter == 6'd29 ||
                      counter == 6'd31 ||
                      counter == 6'd33);
        else 
            enable = (counter == 6'd11 ||
                      counter == 6'd13 ||
                      counter == 6'd15 ||
                      counter == 6'd25 ||
                      counter == 6'd27 ||
                      counter == 6'd29);
    end
end

endmodule
