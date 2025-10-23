
/* C wrapper functions for the RP2040 SDK
 * Incline functions gpio_set_dir and gpio_put and gpio_put_all.
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

int link_gpio_get(uint gpio)
{
	return gpio_get(gpio);
}
