
/* C wrapper functions for the RP2040 SDK
 * Incline functions gpio_set_dir and gpio_put.
 */
 
#include "hardware/gpio.h"
#include <stdio.h>
#include "pico/stdlib.h"

const uint LED1 = 0;
const uint BTN1 = 1;
const uint BTN2 = 2;

int main() {
	stdio_init_all();
	
	// INITIALIZE LED
	gpio_init(LED1);
	gpio_set_dir(LED1, GPIO_OUT);
	
	// INITIALIZE BUTTON 1
	gpio_init(BTN1);
	gpio_set_dir(BTN1, GPIO_IN);
	gpio_pull_up(BTN1);
	
	// INITIALIZE BUTTON 2
	gpio_init(BTN2);
	gpio_set_dir(BTN2, GPIO_IN);
	gpio_pull_up(BTN2);
	
	// POINTER TO SIO BASE
	uint32_t *SIO = (uint32_t *)0xd0000000;

	while (true) {
		
		if (gpioget(BTN1) == 0) {
			turnOn(LED1);
		}
		
		if (gpio_get(BTN2) == 0) {
			turnOff(LED1);
		}
	}
		
	return 0;
}

int gpioget(uint inputPin) {
	// if uint doesnt work: try __u_int
	// SHIFT TO PIN POSITION TO GET BITMASK
	int bitmask = (1 << inputPin);

	*(SIO + 0x004 / 4) = bitmask;
}

void turnOn(uint outputPin) {
	// SHIFT TO PIN POSITION TO GET BITMASK
	// IF ERROR: maybe try 1ul instead of 1
	int bitmask = (1 << outputPin);

	// 0x014 is SIO_OUT_SET
	*(SIO + 0x014 / 4) = bitmask;
}

void turnOff(uint outputPin) {
	// SHIFT TO PIN POSITION TO GET BITMASK
	int bitmask = (1 << outputPin);

	// 0x018 is SIO_OUT_CLR
	*(SIO + 0x018 / 4) = bitmask;
}