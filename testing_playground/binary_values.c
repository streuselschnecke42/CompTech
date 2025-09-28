#include <stdio.h>
#include <stdint.h>

/**
 * Only takes decimals!
 * value = input decimal value
 * position = position of binary value that we need
 */
int get_binary(int value, int position)
{
  // x >> y means we shift to the one we need.
  // (like LSL in reverse: x // 2^y)
  // This will right shift off all values we dont need.
  // 0x1 means we zero out all other non-needed values.
  return ((value >> position) & 0x1);
}


int main(void) {
    uint32_t value = 13; // 1101 in Binär
    printf("Bit 0 von %d ist: %d\n", value, get_binary(value, 0)); // Erwartet: 1
    printf("Bit 1 von %d ist: %d\n", value, get_binary(value, 1)); // Erwartet: 0
    printf("Bit 2 von %d ist: %d\n", value, get_binary(value, 2)); // Erwartet: 1
    printf("Bit 3 von %d ist: %d\n", value, get_binary(value, 3)); // Erwartet: 1
    return 0;
}