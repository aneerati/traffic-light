`default_nettype none
module trafficLightSM (
    input logic pedButton,
    input logic en,
    input logic reset,
    output logic MG,
    output logic MY,
    output logic MR,
    output logic SG,
    output logic SY,
    output logic SR,
    output logic pedOn,
    output logic pedLight,
    output logic newCycle
);
    typedef enum bit[2:0] {
        GR = 3'b000,
        YR = 3'b001,
        RR1 = 3'b010,
        RG = 3'b011,
        RY = 3'b100,
        RR2 = 3'b101,
        PED = 3'b110
    } state;
    state Q = GR, nextQ;
    logic pedReset;
    logic pedOnInt;
    
    always_ff @(posedge en or posedge reset) begin
        if (reset)
            pedOnInt <= 1'b0;
        else if (pedReset)
            pedOnInt <= 1'b0;
        else if (pedButton)
            pedOnInt <= 1'b1;
        else
            pedOnInt <= pedOnInt;
    end
      
    assign pedOn = pedOnInt;    
        
    always_ff @(posedge en or posedge reset) begin
        if (reset)
            Q <= GR;
        else 
            Q <= nextQ;
    end
    always_comb begin
        case (Q)
            GR: nextQ = YR;
            YR: nextQ = RR1;
            RR1: nextQ = RG;
            RG: nextQ = RY;
            RY: nextQ = RR2;
            RR2: nextQ = state'((pedOnInt == 1'b1) ? PED : GR);
            PED: nextQ = GR; 
            default: nextQ = GR;
        endcase
    end
    always_comb begin
        MG = 1'b0;
        MY = 1'b0;
        MR = 1'b0;
        SG = 1'b0;
        SY = 1'b0;
        SR = 1'b0;
        pedLight = 1'b0;
        pedReset = 1'b0;
        newCycle = 1'b0;
        case (Q)
            GR: begin
                MG = 1'b1;
                SR = 1'b1;
                newCycle = 1'b1;
            end
            YR: begin
                MY = 1'b1;
                SR = 1'b1;
            end
            RR1, RR2: begin
                MR = 1'b1;
                SR = 1'b1;
            end
            RG: begin
                MR = 1'b1;
                SG = 1'b1;
            end
            RY: begin
                MR = 1'b1;
                SY = 1'b1;
            end
            PED: begin
                MR = 1'b1;
                SR = 1'b1;
                pedLight = 1'b1;
                pedReset = 1'b1;
            end
        endcase
    end
endmodule
