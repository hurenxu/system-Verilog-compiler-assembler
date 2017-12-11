import definitions::*;

module ALU (
  input         [3:0] OP,
  input               FLAG,
  // INA always hold the accumulator's value
  input         [7:0] INA,
  input         [7:0] INB,
  input         [4:0] Imme,
  output logic  [7:0] OUT,
  output logic        CARRY_OUT,
  output logic        ISZERO) ;
	 
  op_mne op_mnemonic;
	
  always_comb begin
    ISZERO = 0;
	case(OP)
    kMOVE  : OUT = Imme;
    kADDI  : {CARRY_OUT,OUT} = INA+Imme;
	  kADDR  : {CARRY_OUT,OUT} = INA+INB;
    kSUBR  : {CARRY_OUT,OUT} = INA-INB;
    kSL    : {CARRY_OUT,OUT} = FLAG ? INA>>Imme[3:0] : INA<<Imme[3:0];
    kSLR   : {CARRY_OUT,OUT} = FLAG ? INA>>INB : INA<<INB;
    kSNE   : OUT = (INA-INB == 0) ? 0 : 1;
    kSEQ   : OUT = (INA-INB == 0) ? 1 : 0;
    kSLT   : OUT = (INA < INB) ? 1 : 0;
    kBEO   : ISZERO = INA == 1 ? 1:0;
    kBEZ   : ISZERO = INA == 0 ? 1:0;
    kLOAD  : OUT = INB;
    kSTORE : OUT = INA;
    kOR    : OUT = INA | INB;
  endcase
    //op_mnemonic = op_mne'(OP);
    //$display("Current Instruction is %s", op_mnemonic);
  end
endmodule
