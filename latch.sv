`default_nettype none
module latch (
	input  logic S,
	input  logic R,
	output logic Q,
	output logic Qn
	);

	initial Q = 1'b0;
	always_latch begin 
		case ({S, R})
			2'b00: Q <= Q;
			2'b01: Q <= 1'b0;
			2'b10: Q <= 1'b1;
			2'b11: Q <= 1'bx;
		endcase
	assign Qn = ~Q;
endmodule
