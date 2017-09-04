/*
 * dma.h
 *
 *  Created on: Jul 10, 2016
 *      Author: Daniel Pelikan
 *      Copyright 2016. All rights reserved
 */

#ifndef DMA_H_
#define DMA_H_

#include <stdint.h>

#include <time.h>

//Base address pointer
void *h2p_lw_dma_addr=NULL;

//Register Map

#define _DMA_REG_STATUS(BASE_ADDR) *((uint32_t *)BASE_ADDR+0)
#define _DMA_REG_READ_ADDR(BASE_ADDR) *((uint32_t *)BASE_ADDR+1)
#define _DMA_REG_WRITE_ADDR(BASE_ADDR) *((uint32_t *)BASE_ADDR+2)
#define _DMA_REG_LENGTH(BASE_ADDR) *((uint32_t *)BASE_ADDR+3)
#define _DMA_REG_CONTROL(BASE_ADDR) *((uint32_t *)BASE_ADDR+6)

//status register map

#define _DMA_STAT_DONE				0x1		//A DMA transaction is complete. The DONE bit is set to 1 when an end of packet condition is detected or the specified transaction length is completed. Write 0 to the status register to clear the DONE bit.
#define _DMA_STAT_BUSY				0x2		//The BUSY bit is 1 when a DMA transaction is in progress.
#define _DMA_STAT_REOP				0x4		//The REOP bit is 1 when a transaction is completed due to an end-of-packet event on the read side.
#define _DMA_STAT_WEOP				0x8		//The WEOP bit is 1 when a transaction is completed due to an end of packet event on the write side.
#define _DMA_STAT_LEN				0x10		//The LEN bit is set to 1 when the length register decrements to zero.

//control register
#define _DMA_CTR_BYTE				0x1
#define _DMA_CTR_HW					0x2
#define _DMA_CTR_WORD				0x4
#define _DMA_CTR_GO					0x8							// Kich hoat qua tirnh DMA transaction. GO bit is 0 => hok transfer. GO bit is 1 & length register  khac 0 => transfer occur
#define _DMA_CTR_I_EN				0x10						// Bật yêu cầu ngắt (IRQ). Khi bit I_EN là 1, DMAbộ điều khiển tạo ra một IRQ khi bit DONE đăng ký hộ được thiết lập để 1.IRQ bị vô hiệu hóa khi bit I_EN là 0.
#define _DMA_CTR_REEN				0x20						// Kết thúc read transaction.  REEN =1 thì slave flow control to end DMA transaction by asserting  its end-of-packet signal.
#define _DMA_CTR_WEEN				0x40					// Ends transaction on write-side end-of-packet
#define _DMA_CTR_LEEN				0x80						// Ends transaction when the length register reachs zero.
#define _DMA_CTR_RCON				0x100						// Đọc từ một địa chỉ cố định. Khi RCON là 0, địa chỉ đọcgia tăng sau mỗi lần chuyển dữ liệu. Đây là cơ chế cho DMAbộ điều khiển để đọc một loạt các địa chỉ bộ nhớ. Khi RCON là 1, đọcđịa chỉ không tăng. Đây là cơ chế cho bộ điều khiển DMAđể đọc từ một thiết bị ngoại vi tại một địa chỉ bộ nhớ liên tục.
#define _DMA_CTR_WCON				0x200					// Viết cho một địa chỉ cố định. Tương tự như các bit RCON, khi WCON là 0 cácviết increments địa chỉ sau mỗi lần chuyển dữ liệu; khi WCON là 1 sựđịa chỉ ghi không tăng.
#define _DMA_CTR_DOUBLEWORD			0x400
#define _DMA_CTR_QUADWORD			0x800
#define _DMA_CTR_SOFTWARERESET		0x1000		// Thiết lập lại qtrinh







void debugPrintDMARegister(){
#ifdef DEBUG
	printf("DMA Registers:\n");
	printf( "status: %x\n", _DMA_REG_STATUS(h2p_lw_dma_addr) );
	printf( "read: %x\n", _DMA_REG_READ_ADDR(h2p_lw_dma_addr) );
	printf( "write: %x\n", _DMA_REG_WRITE_ADDR(h2p_lw_dma_addr) );
	printf( "length: %x\n", _DMA_REG_LENGTH(h2p_lw_dma_addr) );
	printf( "control: %x\n", _DMA_REG_CONTROL(h2p_lw_dma_addr) );

#endif
}

void debugPrintDMAStatus(){
#ifdef DEBUG
	printf("DMA Status Registers:\n");
	if(*((uint32_t *)h2p_lw_dma_addr) & _DMA_STAT_DONE) printf( "Status: DONE\n");
	if(*((uint32_t *)h2p_lw_dma_addr) & _DMA_STAT_BUSY) printf( "Status: BUSY\n");
	if(*((uint32_t *)h2p_lw_dma_addr) & _DMA_STAT_REOP) printf( "Status: REOP\n");
	if(*((uint32_t *)h2p_lw_dma_addr) & _DMA_STAT_WEOP) printf( "Status: WEOP\n");
	if(*((uint32_t *)h2p_lw_dma_addr) & _DMA_STAT_LEN) printf( "Status: LEN\n");

#endif
}

void waitDMAFinish(){
	//if((_DMA_REG_STATUS(h2p_lw_dma_addr)&_DMA_STAT_BUSY))
		//printf("wait...");
	while( (_DMA_REG_STATUS(h2p_lw_dma_addr)&_DMA_STAT_BUSY)){
		struct timespec s;
		s.tv_sec = 0;
		s.tv_nsec = 0 ;
		nanosleep(&s, NULL);
	}
	//printf("\n");
}

void stopDMA(){
	*((uint32_t *)h2p_lw_dma_addr+6)=0;
}

#endif /* DMA_H_ */
