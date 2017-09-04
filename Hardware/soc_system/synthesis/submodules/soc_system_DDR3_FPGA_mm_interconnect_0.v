// soc_system_DDR3_FPGA_mm_interconnect_0.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 16.0 211

`timescale 1 ps / 1 ps
module soc_system_DDR3_FPGA_mm_interconnect_0 (
		input  wire        p0_avl_clk_clk,                                              //                                            p0_avl_clk.clk
		input  wire        dmaster_clk_reset_reset_bridge_in_reset_reset,               //               dmaster_clk_reset_reset_bridge_in_reset.reset
		input  wire        dmaster_master_translator_reset_reset_bridge_in_reset_reset, // dmaster_master_translator_reset_reset_bridge_in_reset.reset
		input  wire [31:0] dmaster_master_address,                                      //                                        dmaster_master.address
		output wire        dmaster_master_waitrequest,                                  //                                                      .waitrequest
		input  wire [3:0]  dmaster_master_byteenable,                                   //                                                      .byteenable
		input  wire        dmaster_master_read,                                         //                                                      .read
		output wire [31:0] dmaster_master_readdata,                                     //                                                      .readdata
		output wire        dmaster_master_readdatavalid,                                //                                                      .readdatavalid
		input  wire        dmaster_master_write,                                        //                                                      .write
		input  wire [31:0] dmaster_master_writedata,                                    //                                                      .writedata
		output wire [31:0] s0_seq_debug_address,                                        //                                          s0_seq_debug.address
		output wire        s0_seq_debug_write,                                          //                                                      .write
		output wire        s0_seq_debug_read,                                           //                                                      .read
		input  wire [31:0] s0_seq_debug_readdata,                                       //                                                      .readdata
		output wire [31:0] s0_seq_debug_writedata,                                      //                                                      .writedata
		output wire [0:0]  s0_seq_debug_burstcount,                                     //                                                      .burstcount
		output wire [3:0]  s0_seq_debug_byteenable,                                     //                                                      .byteenable
		input  wire        s0_seq_debug_readdatavalid,                                  //                                                      .readdatavalid
		input  wire        s0_seq_debug_waitrequest                                     //                                                      .waitrequest
	);

	wire         dmaster_master_translator_avalon_universal_master_0_waitrequest;   // s0_seq_debug_translator:uav_waitrequest -> dmaster_master_translator:uav_waitrequest
	wire  [31:0] dmaster_master_translator_avalon_universal_master_0_readdata;      // s0_seq_debug_translator:uav_readdata -> dmaster_master_translator:uav_readdata
	wire         dmaster_master_translator_avalon_universal_master_0_debugaccess;   // dmaster_master_translator:uav_debugaccess -> s0_seq_debug_translator:uav_debugaccess
	wire  [31:0] dmaster_master_translator_avalon_universal_master_0_address;       // dmaster_master_translator:uav_address -> s0_seq_debug_translator:uav_address
	wire         dmaster_master_translator_avalon_universal_master_0_read;          // dmaster_master_translator:uav_read -> s0_seq_debug_translator:uav_read
	wire   [3:0] dmaster_master_translator_avalon_universal_master_0_byteenable;    // dmaster_master_translator:uav_byteenable -> s0_seq_debug_translator:uav_byteenable
	wire         dmaster_master_translator_avalon_universal_master_0_readdatavalid; // s0_seq_debug_translator:uav_readdatavalid -> dmaster_master_translator:uav_readdatavalid
	wire         dmaster_master_translator_avalon_universal_master_0_lock;          // dmaster_master_translator:uav_lock -> s0_seq_debug_translator:uav_lock
	wire         dmaster_master_translator_avalon_universal_master_0_write;         // dmaster_master_translator:uav_write -> s0_seq_debug_translator:uav_write
	wire  [31:0] dmaster_master_translator_avalon_universal_master_0_writedata;     // dmaster_master_translator:uav_writedata -> s0_seq_debug_translator:uav_writedata
	wire   [2:0] dmaster_master_translator_avalon_universal_master_0_burstcount;    // dmaster_master_translator:uav_burstcount -> s0_seq_debug_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (32),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (32),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (0),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) dmaster_master_translator (
		.clk                    (p0_avl_clk_clk),                                                    //                       clk.clk
		.reset                  (dmaster_master_translator_reset_reset_bridge_in_reset_reset),       //                     reset.reset
		.uav_address            (dmaster_master_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (dmaster_master_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (dmaster_master_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (dmaster_master_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (dmaster_master_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (dmaster_master_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (dmaster_master_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (dmaster_master_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (dmaster_master_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (dmaster_master_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (dmaster_master_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (dmaster_master_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (dmaster_master_waitrequest),                                        //                          .waitrequest
		.av_byteenable          (dmaster_master_byteenable),                                         //                          .byteenable
		.av_read                (dmaster_master_read),                                               //                          .read
		.av_readdata            (dmaster_master_readdata),                                           //                          .readdata
		.av_readdatavalid       (dmaster_master_readdatavalid),                                      //                          .readdatavalid
		.av_write               (dmaster_master_write),                                              //                          .write
		.av_writedata           (dmaster_master_writedata),                                          //                          .writedata
		.av_burstcount          (1'b1),                                                              //               (terminated)
		.av_beginbursttransfer  (1'b0),                                                              //               (terminated)
		.av_begintransfer       (1'b0),                                                              //               (terminated)
		.av_chipselect          (1'b0),                                                              //               (terminated)
		.av_lock                (1'b0),                                                              //               (terminated)
		.av_debugaccess         (1'b0),                                                              //               (terminated)
		.uav_clken              (),                                                                  //               (terminated)
		.av_clken               (1'b1),                                                              //               (terminated)
		.uav_response           (2'b00),                                                             //               (terminated)
		.av_response            (),                                                                  //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                              //               (terminated)
		.av_writeresponsevalid  ()                                                                   //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (32),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (32),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (1),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) s0_seq_debug_translator (
		.clk                    (p0_avl_clk_clk),                                                    //                      clk.clk
		.reset                  (dmaster_master_translator_reset_reset_bridge_in_reset_reset),       //                    reset.reset
		.uav_address            (dmaster_master_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (dmaster_master_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (dmaster_master_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (dmaster_master_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (dmaster_master_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (dmaster_master_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (dmaster_master_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (dmaster_master_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (dmaster_master_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (dmaster_master_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (dmaster_master_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (s0_seq_debug_address),                                              //      avalon_anti_slave_0.address
		.av_write               (s0_seq_debug_write),                                                //                         .write
		.av_read                (s0_seq_debug_read),                                                 //                         .read
		.av_readdata            (s0_seq_debug_readdata),                                             //                         .readdata
		.av_writedata           (s0_seq_debug_writedata),                                            //                         .writedata
		.av_burstcount          (s0_seq_debug_burstcount),                                           //                         .burstcount
		.av_byteenable          (s0_seq_debug_byteenable),                                           //                         .byteenable
		.av_readdatavalid       (s0_seq_debug_readdatavalid),                                        //                         .readdatavalid
		.av_waitrequest         (s0_seq_debug_waitrequest),                                          //                         .waitrequest
		.av_begintransfer       (),                                                                  //              (terminated)
		.av_beginbursttransfer  (),                                                                  //              (terminated)
		.av_writebyteenable     (),                                                                  //              (terminated)
		.av_lock                (),                                                                  //              (terminated)
		.av_chipselect          (),                                                                  //              (terminated)
		.av_clken               (),                                                                  //              (terminated)
		.uav_clken              (1'b0),                                                              //              (terminated)
		.av_debugaccess         (),                                                                  //              (terminated)
		.av_outputenable        (),                                                                  //              (terminated)
		.uav_response           (),                                                                  //              (terminated)
		.av_response            (2'b00),                                                             //              (terminated)
		.uav_writeresponsevalid (),                                                                  //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                               //              (terminated)
	);

endmodule
