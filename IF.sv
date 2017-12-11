module IF(
  input               Abs_Jump,      // branch to "Offset"
  input [8:0]         Offset,
  input               Reset,
  input               Halt,
  input               CLK,
  output logic[8:0]   PC             // pointer to insr. mem
  );
	 
  always @(posedge CLK)
	if(Reset)              // reset to 0 and hold there
	  PC <= 0;
	else if(Halt)          // freeze
	  PC <= PC;						
    else if(Abs_Jump)    // jump to definite address
	  PC <= Offset;
	else                   // normal advance thru program
	  PC <= PC+1;

endmodule
