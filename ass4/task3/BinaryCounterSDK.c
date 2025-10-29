
/* PROGRAM THAT COUNTS IN BINARY FROM 0 TO 15 AND
 * DISPLAYS IT USING 4 LEDs AND 2 BUTTONS TO 
 * INCREMENT OR DECREMENT THE COUNTER.
 */
 
#include "pico/stdlib.h"
#include "hardware/gpio.h"
#include "hardware/timer.h"
#include "pico/time.h"
#include "hardware/irq.h"
#include <stdbool.h>
#include <stdio.h>

#define BTN1 0
#define LED1 1
#define LED2 2
#define LED3 3
#define LED4 4

volatile int counter = 0;


// RESET COUNTER
void button_isr(uint gpio, uint32_t events) {

  // RESET COUNTER
  counter = 0;
  // UPDATE LEDS
  gpio_put_masked(15 << LED1, counter << LED1);
}

int64_t timer_isr() {
  static bool led_state = false;
  led_state = !led_state;
  // gpio_put(15 << LED1, led_state);
  gpio_put_masked(15 << LED1, counter << LED1);
  return 100 * 1000;
}

int main() {
  stdio_init_all();
	
	// INITIALIZE LED1
	gpio_init(LED1);
	gpio_set_dir(LED1, GPIO_OUT);

	// INITIALIZE LED2
	gpio_init(LED2);
	gpio_set_dir(LED2, GPIO_OUT);

  // INITIALIZE LED3
	gpio_init(LED3);
	gpio_set_dir(LED3, GPIO_OUT);

  // INITIALIZE LED4
	gpio_init(LED4);
	gpio_set_dir(LED4, GPIO_OUT);
	
	// INITIALIZE BUTTON 1
	gpio_init(BTN1);
	gpio_set_dir(BTN1, GPIO_IN);
	gpio_pull_up(BTN1);
	
  // CONFIGURE TIMER INTERRUPT FOR BUTTONS
  gpio_set_irq_enabled_with_callback(BTN1, GPIO_IRQ_EDGE_FALL, true, &button_isr);

  // TODO: INIITALIZE TIMER INTERRUPTS??

  // MAKE SURE TO RESET ALL LEDS BEFORE IT STARTS
  // MOST LIKELY UNNECESSARY BUT JUST TO BE SURE
  gpio_put_masked(15 << LED1, counter << LED1);

	while (true) {
    // MAIN LOOP; THIS WILL REPEAT AND INTERRUPTS CAN HAPPEN AT ANY TIME
		tight_loop_contents();
	}

  return 0;
}
