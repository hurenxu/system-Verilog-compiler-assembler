// A register file with asynchronous read and synchronous write
module reg_file #(parameter addr_width_p = 4)(
  input                     clk,
  input                     carry_en,
  input                     ov_o,
  input [addr_width_p-1:0]  rd_addr_i,
  input                     wen_i,
  input [7:0]               write_data_i,
  input                     store_to_reg,
  output logic [7:0]        acc_o,
  output logic [7:0]        rd_val_o
  );

logic [7:0] RF [2**addr_width_p:0];

//acc
assign acc_o    = RF[2**addr_width_p];
assign rd_val_o = RF[rd_addr_i];

always_ff @ (posedge clk)
  begin
    // to do: store acc to a $reg
    if (wen_i && !store_to_reg)
      RF [2**addr_width_p] <= write_data_i;
    if (wen_i && store_to_reg)
      RF [rd_addr_i] <= write_data_i;
    if(carry_en) begin
    RF[15] = ov_o;
    end
  end
endmodule