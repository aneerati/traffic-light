module final_test (
	input  logic ICE_11,
	input  logic ICE_18,
	input  logic ICE_19,
	input  logic ICE_2,
	input  logic ICE_3,
	input  logic ICE_4,
	input  logic ICE_45,
	input  logic ICE_46,
	input  logic ICE_47,
	output logic LED_G,
	output logic LED_B,
	output logic LED_R,
	output logic ICE_31,
	output logic ICE_32,
	output logic ICE_34,
	output logic ICE_36,
	output logics b2v_inst1(
		.in1(ICE_2),
		.in2(ICE_3),
		.in3(ICE_4),
		.out(SYNTHESIZED_WIRE_1)
	),
	output logics b2v_inst2(
		.in1(ICE_45),
		.in2(ICE_46),
		.in3(ICE_47),
		.out(SYNTHESIZED_WIRE_0)
	)
	);
	logic [2:0] SYNTHESIZED_WIRE_0;
	logic [2:0] SYNTHESIZED_WIRE_1;
	trafficTop b2v_inst0(
		.clk(ICE_11),
		.reset(ICE_18),
		.pedButton(ICE_19),
		.mainTrafficIn(SYNTHESIZED_WIRE_0),
		.sideTrafficIn(SYNTHESIZED_WIRE_1),
		.MG(LED_G),
		.MY(LED_B),
		.MR(LED_R),
		.SG(ICE_31),
		.SY(ICE_32),
		.SR(ICE_34),
		.pedLight(ICE_36)
	);
		.in1(ICE_2),
		.in2(ICE_3),
		.in3(ICE_4),
		.out(SYNTHESIZED_WIRE_1)
	);
		.in1(ICE_45),
		.in2(ICE_46),
		.in3(ICE_47),
		.out(SYNTHESIZED_WIRE_0)
	);
endmodule