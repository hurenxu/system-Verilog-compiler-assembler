module fltflt(
  input         clk,  
  input         reset,
  output logic  done
);

parameter IW = 9;				// program counter / instruction pointer

// all the signals
logic Abs_Jump;         // = 1'b0, // branch to "offset"
logic wen_i;            // reg file write enable
logic Halt;             // inst is halt
logic rf_sel;           // select writing data to reg

logic writeMem;         // inst is write
logic immediate_inst;   // 1: immediate    0: register
logic store_to_reg;     // inst is store and flag is 0

wire [IW-1:0]         PC;       // pointer to insr. mem

logic        [8:0]    Offset;
wire         [8:0]    InstOut;		// 9-bit machine code from instr ROM
wire         [7:0]    rd_val_o,	  // reg_file data outputs to ALU
                      acc_o,			// 
                      result_o;		// ALU data output
wire                  ov_o;
wire                  alu_z_o;
wire         [7:0]    DataOut;
logic        [7:0]    rf_select;  // data bus
logic carry_en = 1'b1;
//logic carry_clr;
//assign carry_clr = reset;
//logic ov_i;
//logic[7:0] alu_mux;

IF IF1(
  // input
  .Abs_Jump (Abs_Jump)   ,  // branch to "offset"
  .Offset   (Offset  )	 ,
  .Reset    (reset   )	 ,
  .Halt     (done    )	 ,
  .CLK      (clk     )	 ,
  // output
  .PC       (PC      )      // pointer to insr. mem
  );

InstROM #(.IW(9)) InstROM1(
  // input
  .InstAddress  (PC     ),  // address pointer
  // output
  .InstOut      (InstOut)
  );

InstDecoder ID(
  // inputs
  .InstOp         (InstOut[8:5]   ),
  .jump_index     (InstOut[4:0]   ),
  .Flagbit        (InstOut[4]     ),
  // output signals
  .Halt           (Halt           ),
  .rf_sel         (rf_sel         ),
  .writeMem       (writeMem       ),
  .immediate_inst (immediate_inst ),
  .Offset         (Offset         )
  );

reg_file #(.addr_width_p(4)) rf1(
  // input
  .clk          (clk		     ),   // clock (for writes only)
  .carry_en     (carry_en),
  .ov_o         (ov_o),
  .rd_addr_i    (InstOut[3:0]),   // read pointer rt
  .wen_i        (wen_i		   ),   // write enable
  .write_data_i (rf_select   ),   // data to be written/loaded
  .store_to_reg (store_to_reg),
  // output
  .acc_o        (acc_o	     ),   // data read out of reg file
  .rd_val_o     (rd_val_o	   )
  );

assign rf_select = rf_sel? DataOut : result_o;	// supports load commands

ALU alu1(
  // input
  .OP        (InstOut[8:5]),	
  .FLAG      (InstOut[4]  ),	
  .INA       (acc_o       ),	
  .INB       (rd_val_o    ),
  .Imme	     (InstOut[4:0]),
  // outputs
  .OUT       (result_o    ),
	.CARRY_OUT (ov_o        ),
	.ISZERO    (alu_z_o     )
  );

data_mem dm1(
  // input
   .CLK           (clk        ),
   .DataAddress   (rd_val_o),
   .ReadMem       (1'b1       ), // mem read always on		
   .WriteMem      (writeMem   ), // 1: mem_store		
   .DataIn        (acc_o   ), // store (from RF)	
   // output	
   .DataOut       (DataOut    )  // load  (to RF)
);



assign Abs_Jump = (InstOut[8:5] == 4'b1001 || InstOut[8:5] == 4'b1010)&&alu_z_o || InstOut[8:5] == 4'b1101;
assign done = InstOut[8:5]==4'b1110;
assign store_to_reg = (InstOut[8:5] == 4'b1100 && InstOut[4] == 0);
assign wen_i = !(InstOut[8:5] == 4'b1001 || InstOut[8:5] == 4'b1010 || InstOut[8:5] == 4'b1101 || InstOut[8:5] == 4'b1110);

endmodule
