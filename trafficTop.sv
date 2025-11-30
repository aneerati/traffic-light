module trafficTop(
  input logic clk,
  input logic reset,
  input logic pedButton,
  input logic [2:0] mainTrafficIn,
  input logic [2:0] sideTrafficIn,

  output logic MG,
  output logic MY,
  output logic MR,
  output logic SG,
  output logic SY,
  output logic SR,
  output logic pedLight
);

  logic [5:0] counter;
  
  sixbitcounter trafficCounter (.clk(clk),
                                .reset(reset),
                                .Q(counter));

  
  
