// --------------------------------------------------------------------------------
//| Avalon Streaming Timing Adapter
// --------------------------------------------------------------------------------
// altera message_level level1

`timescale 1ns / 100ps
module soc_system_avalon_st_adapter_timing_adapter_0 (
    
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
      // Interface: out
      input              out_ready,
      output reg         out_valid,
      output reg [23: 0] out_data,
      output reg         out_startofpacket,
      output reg         out_endofpacket
);




   // ---------------------------------------------------------------------
   //| Signal Declarations
   // ---------------------------------------------------------------------

   reg  [25: 0] in_payload;
   wire [25: 0] out_payload;
   wire         in_ready_wire;
   wire         out_valid_wire;
   wire [ 3: 0] fifo_fill;
   reg  [ 0: 0] ready;


   // ---------------------------------------------------------------------
   //| Payload Mapping
   // ---------------------------------------------------------------------
   always @* begin
     in_payload = {in_data,in_startofpacket,in_endofpacket};
     {out_data,out_startofpacket,out_endofpacket} = out_payload;
   end

   // ---------------------------------------------------------------------
   //| FIFO
   // ---------------------------------------------------------------------
   soc_system_avalon_st_adapter_timing_adapter_0_fifo soc_system_avalon_st_adapter_timing_adapter_0_fifo 
     ( 
       .clk        (clk),
       .reset_n    (reset_n),
       .in_ready   (),
       .in_valid   (in_valid),      
       .in_data    (in_payload),
       .out_ready  (ready[0]),
       .out_valid  (out_valid_wire),      
       .out_data   (out_payload),
       .fill_level (fifo_fill)
       );

   // ---------------------------------------------------------------------
   //| Ready & valid signals.
   // ---------------------------------------------------------------------
   always @* begin
      in_ready = (fifo_fill < 4 );
      out_valid = out_valid_wire;
      ready[0] = out_ready;
   end



endmodule

