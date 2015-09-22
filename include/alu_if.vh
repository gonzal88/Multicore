`ifndef ALU_IF_VH
`define ALU_IF_VH

`include "cpu_types_pkg.vh"

interface alu_if;

	import cpu_types_pkg::*;

	logic neg_flag, over_flag, zero_flag;
	word_t portA, portB, outport;
	aluop_t aluop;

	modport au (
		input portA, portB, aluop,
		output outport, neg_flag, over_flag, zero_flag
		);

	modport tb (
		input outport, neg_flag, over_flag, zero_flag,
		output portA, portB, aluop		
		);

endinterface

`endif
