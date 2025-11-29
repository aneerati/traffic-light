`default_nettype none
module latch (
	input  logic S,
	input  logic R,
	output logic Q,
	output logic Qn
	);
	always_comb 
		case ({S, R})
			2'b00: Q = Q;
			2'b01: Q = 0;
			2'b10: Q = 1;
			2'b11: Q = 1'bx;
		endcase
	assign Qn = ~Q;
endmodule
