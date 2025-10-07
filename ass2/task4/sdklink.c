
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

void link_gpio_put_all(int value)
{
  switch (value) {
    case 0:
      gpio_put_all(0b0111111);
      break;
    case 1:
      gpio_put_all(0b0000110);
      break;
    case 2:
      gpio_put_all(0b1011011);
      break;
    case 3:
      gpio_put_all(0b1001111);
      break;
    case 4:
      gpio_put_all(0b1100110);
      break;
    case 5:
      gpio_put_all(0b1101101);
      break;
    case 6:
      gpio_put_all(0b1111101);
      break;
    case 7:
      gpio_put_all(0b0000111);
      break;
    case 8:
      gpio_put_all(0b1111111);
      break;
    case 9:
      gpio_put_all(0b1101111);
      break;
    case 10:
      gpio_put_all(0b0000000);
      break;
  }
}

int get_binary(int value, int position)
{
  return ((value >> position) & 0x1);
}
