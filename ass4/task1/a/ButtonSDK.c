
/* TASK 1A: PROGRAMMING 2 BUTTONS TO TURN 1 LED
 * ON AND OFF USING ONLY C CODE AND C FUNCTIONS
 */
 
#include "hardware/gpio.h"
#include <stdio.h>
#include "pico/stdlib.h"

const uint LED1 = 0;
const uint BTN1 = 1;
const uint BTN2 = 2;

int main() {
	stdio_init_all();
	
	gpio_init(LED1);
	gpio_set_dir(LED1, GPIO_OUT);
	
	gpio_init(BTN1);
	gpio_set_dir(BTN1, GPIO_IN);
	gpio_pull_up(BTN1);
	
	gpio_init(BTN2);
	gpio_set_dir(BTN2, GPIO_IN);
	gpio_pull_up(BTN2);
	
	while (true) {
		
		if (gpio_get(BTN1) == 0) {
			gpio_put(LED1, 1);
		}
		
		if (gpio_get(BTN2) == 0) {
			gpio_put(LED1, 0);
		}
	}
		
	return 0;
}
