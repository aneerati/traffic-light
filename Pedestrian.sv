`default_nettype none
module Pedestrian (
	input  logic S,
	input  logic R,
	output logic ped
	);
	always_comb 
		case ({S, R})
			2'b00: ped = ped;
			2'b01: ped = 0;
			2'b10: ped = 1;
			2'b11: ped = 1'bx;
		endcase
endmodule
