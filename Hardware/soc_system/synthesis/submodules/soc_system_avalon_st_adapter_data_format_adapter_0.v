// --------------------------------------------------------------------------------
//| Avalon Streaming Data Format Adapter
// --------------------------------------------------------------------------------

`timescale 1ns / 100ps
module soc_system_avalon_st_adapter_data_format_adapter_0 (
    
      // Interface: clk
      input              clk,
      // Interface: reset
      input              reset_n,
      // Interface: in
      output reg         in_ready,
      input              in_valid,
      input      [23: 0] in_data,
      input              in_startofpacket,
      input              in_endofpacket,
      input      [ 1: 0] in_empty,
      // Interface: out
      input              out_ready,
      output reg         out_valid,
      output reg [23: 0] out_data,
      output reg         out_startofpacket,
      output reg         out_endofpacket
);



   always @* begin
      in_ready = out_ready;
      out_valid = in_valid;
      out_data = in_data;
      out_startofpacket = in_startofpacket;
      out_endofpacket = in_endofpacket;


   end

endmodule

