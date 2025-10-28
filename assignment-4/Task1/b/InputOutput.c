// Assembler program using C language to turn on/off an LED light 
// using two buttons.

#include "pico/stdlib.h"
#include "hardware/regs/sio.h"

#define LED_PIN     0
#define BUTTON_ON   1
#define BUTTON_OFF  2

#define SIO_BASE_ADDR   0xD0000000
#define GPIO_IN_REG     *(volatile uint32_t *)(SIO_BASE_ADDR + 0x004)
#define GPIO_OUT_SET    *(volatile uint32_t *)(SIO_BASE_ADDR + 0x014)
#define GPIO_OUT_CLR    *(volatile uint32_t *)(SIO_BASE_ADDR + 0x018)

int main() {
    stdio_init_all();

    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);

    gpio_init(BUTTON_ON);
    gpio_set_dir(BUTTON_ON, GPIO_IN);
    gpio_pull_up(BUTTON_ON);

    gpio_init(BUTTON_OFF);
    gpio_set_dir(BUTTON_OFF, GPIO_IN);
    gpio_pull_up(BUTTON_OFF);

    while (1) {
        uint32_t buttons = GPIO_IN_REG;

        if (!(buttons & (1 << BUTTON_ON))) {
            GPIO_OUT_SET = (1 << LED_PIN);
        }
        if (!(buttons & (1 << BUTTON_OFF))) {
            GPIO_OUT_CLR = (1 << LED_PIN);
        }
    }
}
