
`define ENABLE_DDR3
`define ENABLE_HPS
//`define ENABLE_HSMC


module ghrd_top(


`ifdef ENABLE_DDR3
      ///////// DDR3 /////////
      output      [14:0] DDR3_A,
      output      [2:0]  DDR3_BA,
      output             DDR3_CAS_n,
      output             DDR3_CKE,
      output             DDR3_CK_n,
      output             DDR3_CK_p,
      output             DDR3_CS_n,
      output      [3:0]  DDR3_DM,
      inout       [31:0] DDR3_DQ,
      inout       [3:0]  DDR3_DQS_n,
      inout       [3:0]  DDR3_DQS_p,
      output             DDR3_ODT,
      output             DDR3_RAS_n,
      output             DDR3_RESET_n,
      input              DDR3_RZQ,
      output             DDR3_WE_n,
`endif /*ENABLE_DDR3*/

`ifdef ENABLE_HPS
      ///////// HPS /////////
      inout              HPS_CONV_USB_n,
		//DDR3 
      output      [14:0] HPS_DDR3_ADDR,
      output      [2:0]  HPS_DDR3_BA,
      output             HPS_DDR3_CAS_N,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_N,
      output             HPS_DDR3_CK_P,
      output             HPS_DDR3_CS_N,
      output      [3:0]  HPS_DDR3_DM,
      inout       [31:0] HPS_DDR3_DQ,
      inout       [3:0]  HPS_DDR3_DQS_N,
      inout       [3:0]  HPS_DDR3_DQS_P,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_N,
      output             HPS_DDR3_RESET_N,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_N,
		
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_n,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input       [3:0]  HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output      [3:0]  HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
		
      inout       [3:0]  HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,	
		
      inout              HPS_GSENSOR_INT,	
		
	   inout              HPS_I2C_CLK,
      inout              HPS_I2C_SDA,
		
      inout       [3:0]  HPS_KEY,
		
      inout              HPS_LCM_BK,
      inout              HPS_LCM_D_C,
      inout              HPS_LCM_RST_N,
      input              HPS_LCM_SPIM_CLK,
      output             HPS_LCM_SPIM_MOSI,
		input              HPS_LCM_SPIM_MISO,
      output             HPS_LCM_SPIM_SS,
		
      inout      [3:0]   HPS_LED,
		
		inout              HPS_LTC_GPIO,		
		
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout       [3:0]  HPS_SD_DATA,
		
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      inout              HPS_SPIM_SS,
		
	   inout       [3:0]  HPS_SW,
		
      input              HPS_UART_RX,
      output             HPS_UART_TX,
		
      input              HPS_USB_CLKOUT,
      inout       [7:0]  HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/



      ///////// LED /////////
      output      [3:0]  LED,

      ///////// OSC /////////
      input              OSC_50_B3B
);



// internal wires and registers declaration
  wire        hps_fpga_reset_n;
  wire [2:0]  hps_reset_req;
  wire        hps_cold_reset;
  wire        hps_warm_reset;
  wire        hps_debug_reset;
  wire [27:0] stm_hw_events;


    soc_system u0 (
	     //HPS ddr3
        .memory_mem_a                          ( HPS_DDR3_ADDR),                          //          memory.mem_a
        .memory_mem_ba                         ( HPS_DDR3_BA),                         //                .mem_ba
        .memory_mem_ck                         ( HPS_DDR3_CK_P),                         //                .mem_ck
        .memory_mem_ck_n                       ( HPS_DDR3_CK_N),                       //                .mem_ck_n
        .memory_mem_cke                        ( HPS_DDR3_CKE),                        //                .mem_cke
        .memory_mem_cs_n                       ( HPS_DDR3_CS_N),                       //                .mem_cs_n
        .memory_mem_ras_n                      ( HPS_DDR3_RAS_N),                      //                .mem_ras_n
        .memory_mem_cas_n                      ( HPS_DDR3_CAS_N),                      //                .mem_cas_n
        .memory_mem_we_n                       ( HPS_DDR3_WE_N),                       //                .mem_we_n
        .memory_mem_reset_n                    ( HPS_DDR3_RESET_N),                    //                .mem_reset_n
        .memory_mem_dq                         ( HPS_DDR3_DQ),                         //                .mem_dq
        .memory_mem_dqs                        ( HPS_DDR3_DQS_P),                        //                .mem_dqs
        .memory_mem_dqs_n                      ( HPS_DDR3_DQS_N),                      //                .mem_dqs_n
        .memory_mem_odt                        ( HPS_DDR3_ODT),                        //                .mem_odt
        .memory_mem_dm                         ( HPS_DDR3_DM),                         //                .mem_dm
        .memory_oct_rzqin                      ( HPS_DDR3_RZQ),                      //                .oct_rzqin
        //hps ethernet		
	     .hps_0_hps_io_hps_io_emac1_inst_TX_CLK ( HPS_ENET_GTX_CLK), //                   hps_0_hps_io.hps_io_emac1_inst_TX_CLK
        .hps_0_hps_io_hps_io_emac1_inst_TXD0   ( HPS_ENET_TX_DATA[0] ),   //                               .hps_io_emac1_inst_TXD0
        .hps_0_hps_io_hps_io_emac1_inst_TXD1   ( HPS_ENET_TX_DATA[1] ),   //                               .hps_io_emac1_inst_TXD1
        .hps_0_hps_io_hps_io_emac1_inst_TXD2   ( HPS_ENET_TX_DATA[2] ),   //                               .hps_io_emac1_inst_TXD2
        .hps_0_hps_io_hps_io_emac1_inst_TXD3   ( HPS_ENET_TX_DATA[3] ),   //                               .hps_io_emac1_inst_TXD3
        .hps_0_hps_io_hps_io_emac1_inst_RXD0   ( HPS_ENET_RX_DATA[0] ),   //                               .hps_io_emac1_inst_RXD0
        .hps_0_hps_io_hps_io_emac1_inst_MDIO   ( HPS_ENET_MDIO ),   //                               .hps_io_emac1_inst_MDIO
        .hps_0_hps_io_hps_io_emac1_inst_MDC    ( HPS_ENET_MDC  ),    //                               .hps_io_emac1_inst_MDC
        .hps_0_hps_io_hps_io_emac1_inst_RX_CTL ( HPS_ENET_RX_DV), //                               .hps_io_emac1_inst_RX_CTL
        .hps_0_hps_io_hps_io_emac1_inst_TX_CTL ( HPS_ENET_TX_EN), //                               .hps_io_emac1_inst_TX_CTL
        .hps_0_hps_io_hps_io_emac1_inst_RX_CLK ( HPS_ENET_RX_CLK), //                               .hps_io_emac1_inst_RX_CLK
        .hps_0_hps_io_hps_io_emac1_inst_RXD1   ( HPS_ENET_RX_DATA[1] ),   //                               .hps_io_emac1_inst_RXD1
        .hps_0_hps_io_hps_io_emac1_inst_RXD2   ( HPS_ENET_RX_DATA[2] ),   //                               .hps_io_emac1_inst_RXD2
        .hps_0_hps_io_hps_io_emac1_inst_RXD3   ( HPS_ENET_RX_DATA[3] ),   //                               .hps_io_emac1_inst_RXD3
        
		  //hps flash
		  .hps_0_hps_io_hps_io_qspi_inst_IO0     ( HPS_FLASH_DATA[0]    ),     //                               .hps_io_qspi_inst_IO0
        .hps_0_hps_io_hps_io_qspi_inst_IO1     ( HPS_FLASH_DATA[1]    ),     //                               .hps_io_qspi_inst_IO1
        .hps_0_hps_io_hps_io_qspi_inst_IO2     ( HPS_FLASH_DATA[2]    ),     //                               .hps_io_qspi_inst_IO2
        .hps_0_hps_io_hps_io_qspi_inst_IO3     ( HPS_FLASH_DATA[3]    ),     //                               .hps_io_qspi_inst_IO3
        .hps_0_hps_io_hps_io_qspi_inst_SS0     ( HPS_FLASH_NCSO    ),     //                               .hps_io_qspi_inst_SS0
        .hps_0_hps_io_hps_io_qspi_inst_CLK     ( HPS_FLASH_DCLK    ),     //                               .hps_io_qspi_inst_CLK
        
		  //hps sd card
		  .hps_0_hps_io_hps_io_sdio_inst_CMD     ( HPS_SD_CMD    ),     //                               .hps_io_sdio_inst_CMD
        .hps_0_hps_io_hps_io_sdio_inst_D0      ( HPS_SD_DATA[0]     ),      //                               .hps_io_sdio_inst_D0
        .hps_0_hps_io_hps_io_sdio_inst_D1      ( HPS_SD_DATA[1]     ),      //                               .hps_io_sdio_inst_D1
        .hps_0_hps_io_hps_io_sdio_inst_CLK     ( HPS_SD_CLK   ),     //                               .hps_io_sdio_inst_CLK
        .hps_0_hps_io_hps_io_sdio_inst_D2      ( HPS_SD_DATA[2]     ),      //                               .hps_io_sdio_inst_D2
        .hps_0_hps_io_hps_io_sdio_inst_D3      ( HPS_SD_DATA[3]     ),      //                               .hps_io_sdio_inst_D3
        	
        //hps usb			
		  .hps_0_hps_io_hps_io_usb1_inst_D0      ( HPS_USB_DATA[0]    ),      //                               .hps_io_usb1_inst_D0
        .hps_0_hps_io_hps_io_usb1_inst_D1      ( HPS_USB_DATA[1]    ),      //                               .hps_io_usb1_inst_D1
        .hps_0_hps_io_hps_io_usb1_inst_D2      ( HPS_USB_DATA[2]    ),      //                               .hps_io_usb1_inst_D2
        .hps_0_hps_io_hps_io_usb1_inst_D3      ( HPS_USB_DATA[3]    ),      //                               .hps_io_usb1_inst_D3
        .hps_0_hps_io_hps_io_usb1_inst_D4      ( HPS_USB_DATA[4]    ),      //                               .hps_io_usb1_inst_D4
        .hps_0_hps_io_hps_io_usb1_inst_D5      ( HPS_USB_DATA[5]    ),      //                               .hps_io_usb1_inst_D5
        .hps_0_hps_io_hps_io_usb1_inst_D6      ( HPS_USB_DATA[6]    ),      //                               .hps_io_usb1_inst_D6
        .hps_0_hps_io_hps_io_usb1_inst_D7      ( HPS_USB_DATA[7]    ),      //                               .hps_io_usb1_inst_D7
        .hps_0_hps_io_hps_io_usb1_inst_CLK     ( HPS_USB_CLKOUT    ),     //                               .hps_io_usb1_inst_CLK
        .hps_0_hps_io_hps_io_usb1_inst_STP     ( HPS_USB_STP    ),     //                               .hps_io_usb1_inst_STP
        .hps_0_hps_io_hps_io_usb1_inst_DIR     ( HPS_USB_DIR    ),     //                               .hps_io_usb1_inst_DIR
        .hps_0_hps_io_hps_io_usb1_inst_NXT     ( HPS_USB_NXT    ),     //                               .hps_io_usb1_inst_NXT
        	
        //spim0			
		  .hps_0_hps_io_hps_io_spim0_inst_CLK    ( HPS_SPIM_CLK  ),    //                               .hps_io_spim1_inst_CLK
        .hps_0_hps_io_hps_io_spim0_inst_MOSI   ( HPS_SPIM_MOSI ),   //                               .hps_io_spim1_inst_MOSI
        .hps_0_hps_io_hps_io_spim0_inst_MISO   ( HPS_SPIM_MISO ),   //                               .hps_io_spim1_inst_MISO
        .hps_0_hps_io_hps_io_spim0_inst_SS0    ( HPS_SPIM_SS ),    //                               .hps_io_spim1_inst_SS0
        
		  //spim1
        .hps_0_hps_io_hps_io_spim1_inst_CLK    (HPS_LCM_SPIM_CLK  ),    //                               .hps_io_spim1_inst_CLK
        .hps_0_hps_io_hps_io_spim1_inst_MOSI   (HPS_LCM_SPIM_MOSI ),   //                               .hps_io_spim1_inst_MOSI
        .hps_0_hps_io_hps_io_spim1_inst_MISO   (HPS_LCM_SPIM_MISO ),   //                               .hps_io_spim1_inst_MISO
        .hps_0_hps_io_hps_io_spim1_inst_SS0    (HPS_LCM_SPIM_SS),    //                               .hps_io_spim1_inst_SS0
       
		  //hps uart
		  .hps_0_hps_io_hps_io_uart0_inst_RX     ( HPS_UART_RX    ),     //                               .hps_io_uart0_inst_RX
        .hps_0_hps_io_hps_io_uart0_inst_TX     ( HPS_UART_TX    ),     //                               .hps_io_uart0_inst_TX
        
		  //hps i2c1
		  .hps_0_hps_io_hps_io_i2c1_inst_SDA     ( HPS_I2C_SDA),     //                               .hps_io_i2c1_inst_SDA
        .hps_0_hps_io_hps_io_i2c1_inst_SCL     ( HPS_I2C_CLK),     //                               .hps_io_i2c1_inst_SCL 
        
		  //hps gpio
		  .hps_0_hps_io_hps_io_gpio_inst_GPIO00  (HPS_LTC_GPIO),  //                               .hps_io_gpio_inst_GPIO00
        .hps_0_hps_io_hps_io_gpio_inst_GPIO09  (HPS_CONV_USB_n),  //                               .hps_io_gpio_inst_GPIO09
        .hps_0_hps_io_hps_io_gpio_inst_GPIO35  (HPS_ENET_INT_n),  //                               .hps_io_gpio_inst_GPIO35
        .hps_0_hps_io_hps_io_gpio_inst_GPIO40  (HPS_LCM_BK ),  //                               .hps_io_gpio_inst_GPIO40
        .hps_0_hps_io_hps_io_gpio_inst_GPIO48  (HPS_LCM_RST_N ),  //                               .hps_io_gpio_inst_GPIO48
        .hps_0_hps_io_hps_io_gpio_inst_GPIO53  (HPS_LED[0] ),  //                               .hps_io_gpio_inst_GPIO53
        .hps_0_hps_io_hps_io_gpio_inst_GPIO54  (HPS_LED[1] ),  //                               .hps_io_gpio_inst_GPIO54
        .hps_0_hps_io_hps_io_gpio_inst_GPIO55  (HPS_LED[2] ),  //                               .hps_io_gpio_inst_GPIO55
        .hps_0_hps_io_hps_io_gpio_inst_GPIO56  (HPS_LED[3] ),  //                               .hps_io_gpio_inst_GPIO56
        .hps_0_hps_io_hps_io_gpio_inst_GPIO61  (HPS_GSENSOR_INT),  //                               .hps_io_gpio_inst_GPIO61
        .hps_0_hps_io_hps_io_gpio_inst_GPIO62  (HPS_LCM_D_C),  //                               .hps_io_gpio_inst_GPIO62
		  

		  .hps_0_f2h_stm_hw_events_stm_hwevents  (stm_hw_events),   //        hps_0_f2h_stm_hw_events.stm_hwevents
        //clock & reset
		  .clk_clk                               (OSC_50_B3B),                               //                            clk.clk
        .reset_reset_n                         (hps_fpga_reset_n),                         //                          reset.reset_n
		  
		  //reset 
		  .hps_0_h2f_reset_reset_n               (hps_fpga_reset_n),               //                hps_0_h2f_reset.reset_n
        .hps_0_f2h_warm_reset_req_reset_n      (~hps_warm_reset),      //       hps_0_f2h_warm_reset_req.reset_n
        .hps_0_f2h_debug_reset_req_reset_n     (~hps_debug_reset),     //      hps_0_f2h_debug_reset_req.reset_n
        .hps_0_f2h_cold_reset_req_reset_n      (~hps_cold_reset),       //       hps_0_f2h_cold_reset_req.reset_n
		  
		  //fpga ddr3
		  .memory_0_mem_a                        (DDR3_A),                                           //                       memory_0.mem_a
        .memory_0_mem_ba                       (DDR3_BA),                                          //                               .mem_ba
        .memory_0_mem_ck                       (DDR3_CK_p),                                          //                               .mem_ck
        .memory_0_mem_ck_n                     (DDR3_CK_n),                                        //                               .mem_ck_n
        .memory_0_mem_cke                      (DDR3_CKE),                                         //                               .mem_cke
        .memory_0_mem_cs_n                     (DDR3_CS_n),                                        //                               .mem_cs_n
        .memory_0_mem_dm                       (DDR3_DM),                                          //                               .mem_dm
        .memory_0_mem_ras_n                    (DDR3_RAS_n),                                       //                               .mem_ras_n
        .memory_0_mem_cas_n                    (DDR3_CAS_n),                                       //                               .mem_cas_n
        .memory_0_mem_we_n                     (DDR3_WE_n),                                        //                               .mem_we_n
        .memory_0_mem_reset_n                  (DDR3_RESET_n),                                     //                               .mem_reset_n
        .memory_0_mem_dq                       (DDR3_DQ),                                          //                               .mem_dq
        .memory_0_mem_dqs                      (DDR3_DQS_p),                                         //                               .mem_dqs
        .memory_0_mem_dqs_n                    (DDR3_DQS_n),                                       //                               .mem_dqs_n
        .memory_0_mem_odt                      (DDR3_ODT),                                         //                               .mem_odt
        .oct_rzqin                             (DDR3_RZQ),                                                //                            oct.rzqin
        //fpga ddr3 status
        .ddr3_fpga_status_local_init_done                (LED[0]),                //      mem_if_ddr3_emif_0_status.local_init_done
        .ddr3_fpga_status_local_cal_success              (LED[1]),              //                               .local_cal_success
        .ddr3_fpga_status_local_cal_fail                 ()
		  
    );




endmodule
