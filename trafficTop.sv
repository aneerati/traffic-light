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
  logic enable;
  logic pedToggle;
  logic newCycle;

  trafficLightSM trafficStates(
      .pedButton (pedButton),
      .en        (enable),
      .reset     (reset),
      .MG        (MG),
      .MY        (MY),
      .MR        (MR),
      .SG        (SG),
      .SY        (SY),
      .SR        (SR),
      .pedLight  (pedLight),
      .pedOn     (pedToggle),
      .newCycle     (newCycle));

  logic newCycleCopy;
  logic newCycleDelay;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      newCycleCopy <= 1'b0;
      newCycleDelay <= 1'b0;
    end
    else begin
      newCycleCopy <= newCycle;
      newCycleDelay <= newCycleCopy;
    end
  end

  wire counterReset = newCycleSync & ~newCycleDelay;

  sixbitcounter trafficCounter(
    .clk(clk),
    .reset(counterReset),
    .Q(counter));

  clock trafficClock(
    .clk(clk),
    .reset(reset),
    .counter(counter),
    .PED(pedToggle),
    .mainTrafficIn(mainTrafficIn),
    .sideTrafficIn(sideTrafficIn),
    .enable(enable));
  
endmodule
    
  
  
