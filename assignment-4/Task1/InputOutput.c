// Assembler program using C language to turn on/off an LED light 
// using two buttons.

#include "pico/stdlib.h"

#define LED_PIN     0
#define BUTTON_ON   1
#define BUTTON_OFF  2

int main() {
    stdio_init_all();

    // Initialize GPIO pins
    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);

    gpio_init(BUTTON_ON);
    gpio_set_dir(BUTTON_ON, GPIO_IN);
    gpio_pull_up(BUTTON_ON); // enable internal pull-up

    gpio_init(BUTTON_OFF);
    gpio_set_dir(BUTTON_OFF, GPIO_IN);
    gpio_pull_up(BUTTON_OFF);

    while (1) {
        if (!gpio_get(BUTTON_ON)) {   // button pressed
            gpio_put(LED_PIN, 1);
        }
        if (!gpio_get(BUTTON_OFF)) {  // button pressed
            gpio_put(LED_PIN, 0);
        }
    }

}
