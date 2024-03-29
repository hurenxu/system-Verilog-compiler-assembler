module data_mem #(parameter AW=8)(
  input                   CLK,          // clock
  input         [AW-1:0]  DataAddress,	// pointer
  input                   ReadMem,			// read enable	(may be tied high)
  input                   WriteMem,			// write enable
  input         [7:0]     DataIn,			  // data to store (write into memory)
  output logic  [7:0]     DataOut);			// data to load (read from memory)

  logic [7:0] my_memory [2**AW];        // create array of 2**AW elements (default = 256)
  
// read from memory, e.g. on load instruction
  always_comb							     // reads are immediate/combinational
    if(ReadMem) begin
      DataOut = my_memory[DataAddress];
    end else 
      DataOut = 8'bZ;			     // z denotes high-impedance/undriven

// write to memory, e.g. on store instruction
  always_ff @ (posedge CLK)	   // writes are clocked / sequential
    if(WriteMem) begin
      my_memory[DataAddress] = DataIn;
      $display("Memory write M[%d] = %d",DataAddress,DataIn);
    end

endmodule
