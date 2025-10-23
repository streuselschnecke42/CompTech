
/* C wrapper functions for the RP2040 SDK
 * Incline functions gpio_set_dir and gpio_put.
 */
 
#include "hardware/gpio.h"
#include <stdio.h>
#include "pico/stdlib.h"

const uint LED1 = 0;
const uint BTN1 = 1;
const uint BTN2 = 2;

// POINTER TO SIO BASE
// TRANSLATION TO: LDR R2, gpiobase
//				   gpiobase being #SIO_BASE
// VOLATILE MEANS ITS CHANING
volatile uint32_t *SIO = (uint32_t *)0xd0000000;

int gpioget(uint inputPin) {

	// TRANSLATION TO: LDR R3 ,[R2, #SIO_GPIO_IN_OFFSET]
	// "GET GPIO IN VALUES (THE WHOLE 32 BIT THING)"
	uint32_t gpioin = *(SIO + 0x004 / 4);

	// SHIFT POINTER TO INPUT PIN POSITION AND 
	// RIGHT-SHIFT IT ALL THE WAY TO THE RIGHT
	// "POS OF LEAST SIGNIFICANT BIT"
	int shifted_to_pin = gpioin >> inputPin;
	
	// ZERO OUT ALL NON-RELEVANT PINS TO GET BIT WE WANT
	int bit_inputPin = shifted_to_pin & 1;

	return bit_inputPin;
}

void turnOn(uint outputPin) {
	// SHIFT TO PIN POSITION TO GET BITMASK
	int bitmask = (1 << outputPin);

	// 0x014 is SIO_OUT_SET
	// TRANSLATION TO: STR R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]
	*(SIO + 0x014 / 4) = bitmask;
}

void turnOff(uint outputPin) {
	// SHIFT TO PIN POSITION TO GET BITMASK
	int bitmask = (1 << outputPin);

	// 0x018 is SIO_OUT_CLR
	// TRANSLATION TO: STR R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]
	*(SIO + 0x018 / 4) = bitmask;
}

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


