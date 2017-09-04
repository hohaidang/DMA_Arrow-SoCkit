// soc_system_avalon_st_adapter.v

// This file was auto-generated from altera_avalon_st_adapter_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 13.1 162 at 2014.06.05.16:03:37

`timescale 1 ps / 1 ps
module soc_system_avalon_st_adapter #(
		parameter inBitsPerSymbol = 8,
		parameter inUsePackets    = 1,
		parameter inDataWidth     = 24,
		parameter inChannelWidth  = 0,
		parameter inErrorWidth    = 0,
		parameter inUseEmptyPort  = 1,
		parameter inUseValid      = 1,
		parameter inUseReady      = 1,
		parameter inReadyLatency  = 1,
		parameter outDataWidth    = 24,
		parameter outChannelWidth = 0,
		parameter outErrorWidth   = 0,
		parameter outUseEmptyPort = 0,
		parameter outUseValid     = 1,
		parameter outUseReady     = 1,
		parameter outReadyLatency = 0
	) (
		input  wire        in_clk_0_clk,        // in_clk_0.clk
		input  wire        in_rst_0_reset,      // in_rst_0.reset
		output wire        in_0_ready,          //     in_0.ready
		input  wire        in_0_valid,          //         .valid
		input  wire [23:0] in_0_data,           //         .data
		input  wire        in_0_startofpacket,  //         .startofpacket
		input  wire        in_0_endofpacket,    //         .endofpacket
		input  wire [1:0]  in_0_empty,          //         .empty
		input  wire        out_0_ready,         //    out_0.ready
		output wire        out_0_valid,         //         .valid
		output wire [23:0] out_0_data,          //         .data
		output wire        out_0_startofpacket, //         .startofpacket
		output wire        out_0_endofpacket    //         .endofpacket
	);

	wire         data_format_adapter_0_out_endofpacket;   // data_format_adapter_0:out_endofpacket -> timing_adapter_0:in_endofpacket
	wire         data_format_adapter_0_out_valid;         // data_format_adapter_0:out_valid -> timing_adapter_0:in_valid
	wire         data_format_adapter_0_out_startofpacket; // data_format_adapter_0:out_startofpacket -> timing_adapter_0:in_startofpacket
	wire  [23:0] data_format_adapter_0_out_data;          // data_format_adapter_0:out_data -> timing_adapter_0:in_data
	wire         data_format_adapter_0_out_ready;         // timing_adapter_0:in_ready -> data_format_adapter_0:out_ready

	generate
		// If any of the display statements (or deliberately broken
		// instantiations) within this generate block triggers then this module
		// has been instantiated this module with a set of parameters different
		// from those it was generated for.  This will usually result in a
		// non-functioning system.
		if (inBitsPerSymbol != 8)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					inbitspersymbol_check ( .error(1'b1) );
		end
		if (inUsePackets != 1)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					inusepackets_check ( .error(1'b1) );
		end
		if (inDataWidth != 24)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					indatawidth_check ( .error(1'b1) );
		end
		if (inChannelWidth != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					inchannelwidth_check ( .error(1'b1) );
		end
		if (inErrorWidth != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					inerrorwidth_check ( .error(1'b1) );
		end
		if (inUseEmptyPort != 1)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					inuseemptyport_check ( .error(1'b1) );
		end
		if (inUseValid != 1)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					inusevalid_check ( .error(1'b1) );
		end
		if (inUseReady != 1)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					inuseready_check ( .error(1'b1) );
		end
		if (inReadyLatency != 1)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					inreadylatency_check ( .error(1'b1) );
		end
		if (outDataWidth != 24)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					outdatawidth_check ( .error(1'b1) );
		end
		if (outChannelWidth != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					outchannelwidth_check ( .error(1'b1) );
		end
		if (outErrorWidth != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					outerrorwidth_check ( .error(1'b1) );
		end
		if (outUseEmptyPort != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					outuseemptyport_check ( .error(1'b1) );
		end
		if (outUseValid != 1)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					outusevalid_check ( .error(1'b1) );
		end
		if (outUseReady != 1)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					outuseready_check ( .error(1'b1) );
		end
		if (outReadyLatency != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					outreadylatency_check ( .error(1'b1) );
		end
	endgenerate

	soc_system_avalon_st_adapter_data_format_adapter_0 data_format_adapter_0 (
		.clk               (in_clk_0_clk),                            //   clk.clk
		.reset_n           (~in_rst_0_reset),                         // reset.reset_n
		.in_ready          (in_0_ready),                              //    in.ready
		.in_valid          (in_0_valid),                              //      .valid
		.in_data           (in_0_data),                               //      .data
		.in_startofpacket  (in_0_startofpacket),                      //      .startofpacket
		.in_endofpacket    (in_0_endofpacket),                        //      .endofpacket
		.in_empty          (in_0_empty),                              //      .empty
		.out_ready         (data_format_adapter_0_out_ready),         //   out.ready
		.out_valid         (data_format_adapter_0_out_valid),         //      .valid
		.out_data          (data_format_adapter_0_out_data),          //      .data
		.out_startofpacket (data_format_adapter_0_out_startofpacket), //      .startofpacket
		.out_endofpacket   (data_format_adapter_0_out_endofpacket)    //      .endofpacket
	);

	soc_system_avalon_st_adapter_timing_adapter_0 timing_adapter_0 (
		.clk               (in_clk_0_clk),                            //   clk.clk
		.reset_n           (~in_rst_0_reset),                         // reset.reset_n
		.in_ready          (data_format_adapter_0_out_ready),         //    in.ready
		.in_valid          (data_format_adapter_0_out_valid),         //      .valid
		.in_data           (data_format_adapter_0_out_data),          //      .data
		.in_startofpacket  (data_format_adapter_0_out_startofpacket), //      .startofpacket
		.in_endofpacket    (data_format_adapter_0_out_endofpacket),   //      .endofpacket
		.out_ready         (out_0_ready),                             //   out.ready
		.out_valid         (out_0_valid),                             //      .valid
		.out_data          (out_0_data),                              //      .data
		.out_startofpacket (out_0_startofpacket),                     //      .startofpacket
		.out_endofpacket   (out_0_endofpacket)                        //      .endofpacket
	);

endmodule
