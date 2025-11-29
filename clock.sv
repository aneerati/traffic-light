module clock
(
    input logic counter[5:0],
    input logic PED, 
    output logic enable
);

always_comb begin
    enable = 1'b0;
    if(PED) begin
        enable =  (counter == 6'd0 ||
                  counter == 6'd11 ||
                  counter == 6'd13 ||
                  counter == 6'd15 ||
                  counter == 6'd21 ||
                  counter == 6'd23 ||
                  counter == 6'd33);
    end 

    else begin
        enable = (counter == 6'd0  ||
                  counter == 6'd15 ||
                  counter == 6'd17 ||
                  counter == 6'd19 ||
                  counter == 6'd27 ||
                  counter == 6'd29);
    end 
end

endmodule
