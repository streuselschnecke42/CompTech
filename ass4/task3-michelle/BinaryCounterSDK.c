
/* PROGRAM THAT COUNTS IN BINARY FROM 0 TO 15 AND
 * DISPLAYS IT USING 4 LEDs AND 2 BUTTONS TO 
 * INCREMENT OR DECREMENT THE COUNTER.
 * 
 * DOCUMENTATION AND GITHUB LINK TO TIMER INTERRUPT IN LINE 77-78
 * https://www.raspberrypi.com/documentation/pico-sdk/high_level.html
 * https://github.com/raspberrypi/pico-examples/blob/master/timer/hello_timer/hello_timer.c#L42
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


// RESET BUTTON HELPER FUNCTION
void button_isr(uint gpio, uint32_t events) {
  // RESET COUNTER AND UPDATE LEDS ACCORDINGLY
  counter = 0;
  gpio_put_masked(15 << LED1, counter << LED1);
}

int64_t timer_callback() {
  // MAX COUNTER VALUE IS 15 => COUNTER HAS TO BE BELOW THAT
  if (counter < 15) {
    // INCREASE COUNTER BY 1
    counter ++;
    // UPDATE LEDS ACCORDINGLY
    gpio_put_masked(15 << LED1, counter << LED1);
  }
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

  // FROM RASPBERRYPI DOCUMENTATION AND GITHUB (SEE LINKS IN HEAD)

  // MAKE A VARIABLE NAMED TIMER AND LET IT BE OF TYPE repeating_timer
  // repeating_timer = A STRUCTURE DEFINED INSIDE PICO SDK THAT STORES
  //                   INFORMATION ABOUT A REPEATING TIMER
  struct repeating_timer timer;
  add_repeating_timer_ms (1000, timer_callback, NULL, &timer);
  
  // MAKE SURE TO RESET ALL LEDS BEFORE IT STARTS
  // MOST LIKELY UNNECESSARY BUT JUST TO BE SURE
  gpio_put_masked(15 << LED1, counter << LED1);

	while (true) {
    // MAIN LOOP; THIS WILL REPEAT AND INTERRUPTS CAN HAPPEN AT ANY TIME
		tight_loop_contents();
	}

  return 0;
}
