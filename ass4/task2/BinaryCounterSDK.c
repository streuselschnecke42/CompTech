
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

#define LED1 1
#define LED2 2
#define LED3 3
#define LED4 4
#define BTN1 5
#define BTN2 6

volatile int counter = 0;

// CHECKER TO SEE IF COUNTER AT LIMIT
bool counter_at_limit(int current_value) {
  // IF COUNTER 0, DECREMENTING IMPOSSIBLE -> BUTTON 1 UR FUNKTION
  // IF COUNTER 15, INCREMENTING IMPOSSIBLE -> BUTTON 2 UR FUNKTION
  if (current_value >= 15 || current_value <= 0) {
    return true;
  }

  // OTHERWISE EVERYTHING FINE
  return false;
}

// INTERRUPT FUNCTION FOR GPIO BUTTONS
void button_isr(uint gpio, uint32_t events) {

  // CHECKING NOT ONLY BUTTON BUT ALSO COUNTER

  // BUTTON FOR INCREMENTING COUNTER
  if (gpio == BTN1 && !counter_at_limit(counter)) {
    counter += 1;
    // LIKE GPIO_PUT_ALL BUT BETTER
    // ONLY WRITES ON AFFECTED BITS, SO GPIO 1 TO 4
    // PREVENTS BUTTONS TO BE ACCIDENTALLY TURNED INTO OUTPUTS
    gpio_put_masked(15 << LED1, counter << LED1);

  // BUTTON FOR DECREMENTING COUNTER
  } else if (gpio == BTN2 && !counter_at_limit(counter)) {
    counter -= 1;
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
	
	// INITIALIZE BUTTON 2
	gpio_init(BTN2);
	gpio_set_dir(BTN2, GPIO_IN);
	gpio_pull_up(BTN2);
	
  // CONFIGURE TIMER INTERRUPT FOR BUTTONS
  gpio_set_irq_enabled_with_callback(BTN1, GPIO_IRQ_EDGE_FALL, true, &button_isr);
  gpio_set_irq_enabled(BTN2, GPIO_IRQ_EDGE_FALL, true);

  // MAKE SURE TO RESET ALL LEDS BEFORE IT STARTS
  // MOST LIKELY UNNECESSARY BUT JUST TO BE SURE
  gpio_put_masked(15 << LED1, counter << LED1);

	while (true) {
    // MAIN LOOP; THIS WILL REPEAT AND INTERRUPTS CAN HAPPEN AT ANY TIME
		tight_loop_contents();
	}

  return 0;
}
