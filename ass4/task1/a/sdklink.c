
/* C wrapper functions for the RP2040 SDK
 * Incline functions gpio_set_dir and gpio_put.
 */
 
#include "hardware/gpio.h"

void link_gpio_set_dir(int pin, int dir)
{
	gpio_set_dir(pin, dir);
}

void link_gpio_put(int pin, int value)
{
	gpio_put(pin, value);
}

int link_gpio_get(int pin)
{
	return gpio_get(pin);
}

void link_gpio_pull_up(int pin)
{
	gpio_pull_up(pin);
}
