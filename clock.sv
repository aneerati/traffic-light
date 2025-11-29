module clock
(
    input logic [5:0] counter,
    input logic PED, 
    input logic [2:0] mainTraffic,
    input logic [2:0] sideTraffic,
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
