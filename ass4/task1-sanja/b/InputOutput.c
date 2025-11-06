// Assembler program using C language to turn on/off an LED light 
// using two buttons.

#include "pico/stdlib.h"
#include "hardware/regs/sio.h"

#define LED_PIN     0
#define BUTTON_ON   1
#define BUTTON_OFF  2

#define SIO_BASE_ADDR   0xD0000000 // base address of the SIO block
#define GPIO_IN_REG     *(volatile uint32_t *)(SIO_BASE_ADDR + 0x004) // reads the current state of all gpio pins
#define GPIO_OUT_SET    *(volatile uint32_t *)(SIO_BASE_ADDR + 0x014) // setting bits here turn on the corresponding parts
#define GPIO_OUT_CLR    *(volatile uint32_t *)(SIO_BASE_ADDR + 0x018) // turn off

int main() {
    stdio_init_all();

    gpio_init(LED_PIN); // prepare gpio pin 0
    gpio_set_dir(LED_PIN, GPIO_OUT); // set it as output
    
    // Configure button 1 as input and active its internal pull-up resistor
    gpio_init(BUTTON_ON);
    gpio_set_dir(BUTTON_ON, GPIO_IN);
    gpio_pull_up(BUTTON_ON);
    
    // Configure button 2 
    gpio_init(BUTTON_OFF);
    gpio_set_dir(BUTTON_OFF, GPIO_IN);
    gpio_pull_up(BUTTON_OFF);

    while (1) {
        uint32_t buttons = GPIO_IN_REG; // read the current input state of all gpio pins

        if (!(buttons & (1 << BUTTON_ON))) { // create a bitmask for GPIO 1 and check whether that bit is 1 or 0
            GPIO_OUT_SET = (1 << LED_PIN); // sets bit 0 in gpio output turning on the LED
        }
        if (!(buttons & (1 << BUTTON_OFF))) { // same logic as above for off button
            GPIO_OUT_CLR = (1 << LED_PIN);
        }
    }
}
