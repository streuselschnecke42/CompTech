// This program implements a 4-bit binary counter on the Raspberry Pi Pico
// using interrupts for two buttons to increment/decrement the count.

#include "pico/stdlib.h" 

// Pin assignments
#define LED0     1   // LED connected to GP1 (least significant bit)
#define LED1     2   // LED connected to GP2
#define LED2     3   // LED connected to GP3
#define LED3     4   // LED connected to GP4 (most significant bit)
#define BTN_INC  5   // Button connected to GP5 (increment counter)
#define BTN_DEC  6   // Button connected to GP6 (decrement counter)

// The counter value (0–15) displayed on LEDs
// 'volatile' because it's changed inside an interrupt handler
volatile uint8_t counter = 0;

// Function: update_leds
// Purpose : Output the current counter value to the 4 LEDs

void update_leds(void) {
    gpio_put(LED0, (counter >> 0) & 1);  // Write bit 0 to LED0
    gpio_put(LED1, (counter >> 1) & 1);  // Write bit 1 to LED1
    gpio_put(LED2, (counter >> 2) & 1);  // Write bit 2 to LED2
    gpio_put(LED3, (counter >> 3) & 1);  // Write bit 3 to LED3
}

// Function: button_irq_handler
// Purpose : Handle button presses using interrupts
//           Increment or decrement the counter
void button_irq_handler(uint gpio, uint32_t events) {
    if (gpio == BTN_INC) {        // If increment button triggered
        if (counter < 15) counter++;  // Increase only if below max (15)
    } 
    else if (gpio == BTN_DEC) {   // If decrement button triggered
        if (counter > 0) counter--;   // Decrease only if above 0
    }
    update_leds();  // Update LEDs after change
}

int main(void) {
    stdio_init_all();  // Initialize standard I/O

    // Configure LEDs as outputs
    for (int pin = LED0; pin <= LED3; pin++) {
        gpio_init(pin);           // Initialize each LED pin
        gpio_set_dir(pin, GPIO_OUT);  // Set as output
    }

    // Configure buttons as inputs with pull-ups
    gpio_init(BTN_INC);
    gpio_set_dir(BTN_INC, GPIO_IN);
    gpio_pull_up(BTN_INC);        // Enable internal pull-up resistor

    gpio_init(BTN_DEC);
    gpio_set_dir(BTN_DEC, GPIO_IN);
    gpio_pull_up(BTN_DEC);        // Enable internal pull-up resistor

    // Start with counter value 0 and update LEDs
    update_leds();

    // Enable interrupts for buttons
    // Trigger on falling edge (button pressed - goes from high to low)
    gpio_set_irq_enabled_with_callback(
        BTN_INC, GPIO_IRQ_EDGE_FALL, true, &button_irq_handler);
    gpio_set_irq_enabled(BTN_DEC, GPIO_IRQ_EDGE_FALL, true);

    // Main loop
    while (1) {
        tight_loop_contents();  // Low-power idle loop
    }
}
