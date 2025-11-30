`default_nettype none
module assign_outputs(
    input logic in1,
    input logic in2,
    input logic in3,
    output logic [2:0] out
);
assign out = {in3, in2, in1};
endmodule