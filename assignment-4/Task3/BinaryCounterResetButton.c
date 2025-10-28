// This is a program for a binary counter in C for Raspberry Pi Pico
// with a reset button

#include "pico/stdlib.h"
#include "hardware/irq.h"
#include "hardware/timer.h"

// Pin definitions
#define LED0 1
#define LED1 2
#define LED2 3
#define LED3 4
#define RESET_BTN 0

volatile uint8_t counter = 0; // shared between main, timer, and ISR

// Update LEDs according to counter value 
void update_leds(void) {
    gpio_put(LED0, (counter >> 0) & 1);
    gpio_put(LED1, (counter >> 1) & 1);
    gpio_put(LED2, (counter >> 2) & 1);
    gpio_put(LED3, (counter >> 3) & 1);
}

// Reset button ISR 
void reset_button_handler(uint gpio, uint32_t events) {
    counter = 0;
    update_leds();
}

// Timer interrupt callback 
bool repeating_timer_callback(struct repeating_timer *t) {
    if (counter < 15) {      // stop at max value 1111
        counter++;
        update_leds();
    }
    return true; // keep repeating
}

int main() {
    stdio_init_all();

    // Initialize LEDs 
    for (int pin = LED0; pin <= LED3; pin++) {
        gpio_init(pin);
        gpio_set_dir(pin, GPIO_OUT);
    }

    // Initialize reset button 
    gpio_init(RESET_BTN);
    gpio_set_dir(RESET_BTN, GPIO_IN);
    gpio_pull_up(RESET_BTN);

    // Attach GPIO interrupt for reset button (falling edge = pressed)
    gpio_set_irq_enabled_with_callback(RESET_BTN, GPIO_IRQ_EDGE_FALL, true, &reset_button_handler);

    // Initialize and start timer 
    struct repeating_timer timer;
    // 1 second interval (1000 ms)
    add_repeating_timer_ms(1000, repeating_timer_callback, NULL, &timer);

    // Start counter at 0
    update_leds();

    while (1) {
        tight_loop_contents(); // idle, work handled by interrupts
    }
}
