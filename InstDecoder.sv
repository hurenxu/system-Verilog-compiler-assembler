import definitions::*;

module InstDecoder (
  input [3:0] InstOp,
  input [4:0] jump_index,
  input Flagbit,
  output logic Halt,
  output logic rf_sel,
  output logic writeMem,
  output logic immediate_inst,
  output logic [8:0] Offset
  );

  logic [8:0] jump_lookup_table [32];

  initial 
  $readmemb("program2_jump_table.txt", jump_lookup_table);

  always_comb begin
  case(InstOp)

    kMOVE  :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b1;
    end

    kADDI  :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b1;
    end

    kADDR  :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
    end

    kSUBR  :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
    end

    kSL    :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b1;
    end

    kSLR   :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
    end

    kSNE   :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
    end

    kSEQ   :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
    end

    kSLT   :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
    end

    kBEO   :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
      Offset          = jump_lookup_table[jump_index];
    end

    kBEZ   :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
      Offset          = jump_lookup_table[jump_index];
    end

    kLOAD  :
    begin 
      Halt            = 1'b0;
      rf_sel          = Flagbit;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
    end

    kSTORE :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = Flagbit;
      immediate_inst  = 1'b0;
    end

    kJUMP  :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
      Offset          = jump_lookup_table[jump_index];
    end

    kHALT  :
    begin 
      Halt            = 1'b1;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
    end

    kOR   :
    begin 
      Halt            = 1'b0;
      rf_sel          = 1'b0;
      writeMem        = 1'b0;
      immediate_inst  = 1'b0;
    end

endcase
end
endmodule
