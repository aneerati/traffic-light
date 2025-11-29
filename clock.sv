module clock
(
    input logic counter[5:0],
    input logic PED, 
    input logic mainTraffic[2:0];
    input logic sideTraffic[2:0];
    output logic enable
);

    trafficComp comp (.m(mainTraffic),
                      .s(sideTraffic));
    
always_comb begin
    enable = 1'b0;
    if (PED)
        enable = (counter == 6'd11 ||
                  counter == 6'd13 ||
                  counter == 6'd15 ||
                  counter == 6'd26 ||
                  counter == 6'd28 ||
                  counter == 6'd30 ||
                  counter == 6'd40);
    else
        enable = (counter == 6'd11 ||
                  counter == 6'd13 ||
                  counter == 6'd15 ||
                  counter == 6'd26 ||
                  counter == 6'd28 ||
                  counter == 6'd30);
    end 
end

endmodule
