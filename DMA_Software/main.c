// Led[0] va Led[1] sang cua FPGA bao hieu DRAM cua FPGA da duoc init

#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <time.h> // richard
#include <sys/time.h> // richard
#include "hwlib.h"
#include "soc_cv_av/socal/socal.h"
#include "soc_cv_av/socal/hps.h"
#include "soc_cv_av/socal/alt_gpio.h"
#include "hps_0.h"

#include "dma.h"

// HPS peripherial
#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 ) //64 MB with 32 bit adress space this is 256 MB
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

//setting for the HPS2FPGA AXI Bridge
#define ALT_AXI_FPGASLVS_OFST (0xC0000000) // axi_master
#define HW_FPGA_AXI_SPAN (0x40000000) // Bridge span 1GB
#define HW_FPGA_AXI_MASK ( HW_FPGA_AXI_SPAN - 1 )

//SDRAM 32000000-35ffffff //64 MB
#define SDRAM_64_BASE 0x32000000
#define SDRAM_64_SPAN 0x3FFFFFF


// Function get time
static long get_tick_count(void) {
	struct timespec now;
	clock_gettime(CLOCK_MONOTONIC, &now);
	return now.tv_sec * 1000000000 + now.tv_nsec;

}

int main() {
	uint32_t time_start, time_decode;
	void *virtual_base;
	void *axi_virtual_base;
	int fd, i;

	void *sdram_64MB_FPGA; //scratch space via ax master 64kb
	void *sdram_64MB_HPS;

	// map the address space for the LED registers into user space so we can interact with them.
	// we'll actually map in the entire CSR span of the HPS since we want to access various registers within that span

	if ((fd = open("/dev/mem", ( O_RDWR | O_SYNC))) == -1) {
		printf("ERROR: could not open \"/dev/mem\"...\n");
		return (1);
	}

	//lightweight HPS-to-FPGA bridge
	virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE),
	MAP_SHARED, fd, HW_REGS_BASE);

	if (virtual_base == MAP_FAILED) {
		printf("ERROR: mmap() failed...\n");
		close(fd);
		return (1);
	}

	//HPS-to-FPGA bridge
	axi_virtual_base = mmap( NULL, HW_FPGA_AXI_SPAN, ( PROT_READ | PROT_WRITE),
	MAP_SHARED, fd, ALT_AXI_FPGASLVS_OFST);

	if (axi_virtual_base == MAP_FAILED) {
		printf("ERROR: axi mmap() failed...\n");
		close(fd);
		return (1);
	}


	printf("\n\n\n-----------write on chip RAM-------------\n\n");

	// RAM HPS
	sdram_64MB_HPS = mmap( NULL, SDRAM_64_SPAN, ( PROT_READ | PROT_WRITE),
	MAP_SHARED, fd, SDRAM_64_BASE);

	// FPGA RAM. Controlled by h2f_axi bridge
	sdram_64MB_FPGA = axi_virtual_base
			+ ((unsigned long) ( DDR3_FPGA_BASE)
					& (unsigned long) ( HW_FPGA_AXI_MASK));

	//Write 50MB Data to RAM
	for (i = 0; i < 13107200; i++) {
		*((uint32_t *) sdram_64MB_HPS + i) = i * 1024;
		*((uint32_t *) sdram_64MB_FPGA + i) = i + 3;
	}

	// Show 10th valuables.
	printf("Print scratch disks:\n");
	printf("ROM \n");
	for (i = 0; i < 10; i++) {
		printf("%d\t%d\n", *((uint32_t *) sdram_64MB_HPS + i),
				*((uint32_t *) sdram_64MB_FPGA + i));
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////---------- DMA 50 MBYTE -------------///////////////////////////////////////////
	printf("\n\n\n------ DMA  64KB -------- \n");
	printf("\n\n\n-----------DMA RAM 1 to RAM 2-------------\n\n");

	//create a pointer to the DMA controller base
	h2p_lw_dma_addr = virtual_base
			+ ((unsigned long) ( ALT_LWFPGASLVS_OFST + DMA_0_BASE)
					& (unsigned long) ( HW_REGS_MASK));

	//configure the DMA controller for transfer
	_DMA_REG_STATUS(h2p_lw_dma_addr) = 0;
	_DMA_REG_READ_ADDR(h2p_lw_dma_addr) = SDRAM_64_BASE; //read from ROM1
	_DMA_REG_WRITE_ADDR(h2p_lw_dma_addr) = DDR3_FPGA_BASE; //write to ROM2
	_DMA_REG_LENGTH(h2p_lw_dma_addr) = 4 * 13107200; //1310720 write 100x 4bytes since we have a 32 bit system

	time_start = get_tick_count();

	//start the transfer
	_DMA_REG_CONTROL(h2p_lw_dma_addr) = _DMA_CTR_DOUBLEWORD | _DMA_CTR_GO
			| _DMA_CTR_LEEN;

	//wait for DMA to be finished
	waitDMAFinish();
	stopDMA(); //stop the DMA controller

	time_decode = get_tick_count() - time_start;
	printf("Time for DMA process = %d nanoseconds\r\n", time_decode);

	//Check result
	for (i = 0; i < 13107200; i++) {
		if (*((uint32_t *) sdram_64MB_FPGA + i) == i * 1024) {
			continue;
		} else {
			printf("Error %d", *((uint32_t *) sdram_64MB_FPGA + i));
			exit(0);
		}
	}
	printf("Whole Data is checked and valid\n");

	//check if data was copied
	printf("Print scratch disk 1 and 2:\n");
	for (i = 0; i < 10; i++) {
		printf("%d\t %d\n", *((uint32_t *) sdram_64MB_FPGA + i),
				*((uint32_t *) sdram_64MB_HPS + i));
	}

	// clean up our memory mapping and exit
	if (munmap(sdram_64MB_HPS, SDRAM_64_SPAN) != 0) {
		printf("ERROR: munmap() failed...\n");
		close(fd);
		return (1);
	}

	if (munmap(virtual_base, HW_REGS_SPAN) != 0) {
		printf("ERROR: munmap() failed...\n");
		close(fd);
		return (1);
	}

	if (munmap(axi_virtual_base, HW_FPGA_AXI_SPAN) != 0) {
		printf("ERROR: axi munmap() failed...\n");
		close(fd);
		return (1);
	}

	close(fd);

	return (0);
}
