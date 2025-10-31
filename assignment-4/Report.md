# 1DT301 Lab Assignment 4 - C-programming and interrupts
*Computer Technology 1* \
*October 22, 2025*

Author: Michelle Weber, Sanja Janevska\
Examiner: Mehdi Saman Azari\
Semester: HT25\
Discipline: NGDNS, NGDPV


# Tasks

# Task 1
Use the same setup as in Lab3 Tasks 4 and 5, that is, an LED connected to GP0 and buttons connected to GP1 and GP2. Use button on GP1 to turn on LED, button on GP2 to turn it off.


# Task 1a
Write a C program to implement the functions. To read buttons and
control LED, use the C function gpio_put(…) and gpio_get().

## Explanation Code
// TODO: Explanation of Code

## Execution
// TODO

**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

## Sourcecode files
[foo.S](../ass4/task1/a/foo.S)\
[CMakeLists.txt](../ass4/task1/a/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass4/task1/a/pico_sdk_import.cmake)\
[foo.uf2](../ass4/task1/build/a/foo.uf2)

To get to the whole Task 1a directory instead, click [here](../ass4/task1/a/).


# Task 1b
Re-write the C program so that is does not use the gpio functions, but instead hardware addresses of the SIO. However, you ARE allowed to use C functions to initialize the GPIO pins and set their directions!

## Explanation Code
// TODO: Explanation of Code

## Execution
// TODO

**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

## Sourcecode files
[foo.S](../ass4/task1/b/foo.S)\
[CMakeLists.txt](../ass4/task1/b/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass4/task1/b/pico_sdk_import.cmake)\
[foo.uf2](../ass4/task1/build/b/foo.uf2)

To get to the whole Task 1b directory instead, click [here](../ass4/task1/b/).

# Task 1c
Connect one more LED to GP6. Extend the program from b) so that it turns on or off both LEDs simultaneously.

## Explanation Code
// TODO: Explanation of Code

## Execution
// TODO

**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

## Sourcecode files
[foo.S](../ass4/task1/c/foo.S)\
[CMakeLists.txt](../ass4/task1/c/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass4/task1/c/pico_sdk_import.cmake)\
[foo.uf2](../ass4/task1/build/c/foo.uf2)

To get to the whole Task 1c directory instead, click [here](../ass4/task1/c/).


# Task 2
Connect four LEDs in a row to make a binary counter. The counter should count from 0000 to 1111.\
The LEDs should be connected to ports GP1, GP2, GP3 and GP4.\
Connect one button to GP5 and one button to GP6 with the following functions:
- Let the button on GP5 increment the counter (increase one step). If increase button is pressed when counter value is 15, nothing should happen!
- Let the button on GP6 decrement the counter (decrease one step). If decrease button is pressed when counter value is 0, nothing should happen!

Let the counter start at value 0. You must use interrupts to handle the inputs from the buttons! There will probably be problems with bouncing buttons (one button press counts as many) but you can ignore this problem.

## Explanation Code

The program implements a 4-bit binary counter on the Raspberry Pi Pico using interrupts to detect button presses for incrementing and decrementing the counter value. Four LEDs (connected to GP1–GP4) represent the binary output of the counter (values 0–15).

Each LED pin is configured as an output using gpio_init() and gpio_set_dir(), while the two buttons on GP5 and GP6 are configured as inputs with internal pull-up resistors enabled (gpio_pull_up()). This ensures the buttons are normally at a logic HIGH state and generate a falling edge when pressed.

Interrupts are set up using the function:
gpio_set_irq_enabled_with_callback(BTN_INC, GPIO_IRQ_EDGE_FALL, true, &button_irq_handler);
so that the increment button triggers the interrupt handler when pressed. Inside the same handler, the program checks which button caused the interrupt (BTN_INC or BTN_DEC) and modifies the counter value accordingly:

If the increment button is pressed and the counter is less than 15, it increases by 1.

If the decrement button is pressed and the counter is greater than 0, it decreases by 1.

The update_leds() function shifts each bit of the counter and writes it to the respective LED pin using gpio_put(). The counter value is stored as a global volatile variable since it is modified inside an interrupt service routine (ISR).

Michelle’s assembler version implements the same logic but entirely in ARM assembly, manually controlling bit extraction and LED output using the registers R0–R7. The counting direction is determined by a flag register (R6) and alternates between forward and backward counting after reaching the limits. The logic structure and LED update pattern are therefore functionally identical to the C version, though implemented at a lower abstraction level.

## Hardware - Layout
![Layout](../ass4/images)

### Electric Circuit Plan
Note: The application didn't have Pico H, so I used the normal Pico instead. Pin connection should still be correct **where it was used**.\
![0](../ass4/images)

## Execution

When the program starts, all four LEDs represent 0000.

Pressing the GP5 button increases the binary count (e.g., 0001 → 0010 → 0011 … up to 1111).

Pressing the GP6 button decreases the binary count (e.g., 1111 → 1110 → 1101 … down to 0000).
If the counter reaches 0 or 15, additional presses in the same direction have no effect.

Because no debouncing is implemented, rapid toggling or bouncing may cause multiple increments per press. However, this behavior is acceptable as noted in the task instructions.


**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

## Sourcecode files
[foo.S](../ass4/task2/foo.S)\
[CMakeLists.txt](../ass4/task2/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass4/task2/pico_sdk_import.cmake)\
[foo.uf2](../ass4/task2/build/foo.uf2)

To get to the whole Task 2 directory instead, click [here](../ass4/task2/).


# Task 3
Use the same counter setup as in the previos task, but this time, let the counter increase automatically using a timer interrupt. Also, connect a button to GP0 to reset the counter. You don’t need to use the buttons at GP5 and GP6 in this task.\
Requirements:
- There should be 1 second time interval between the counter values.
- Stop the count when the counter reaches its maximum value 1111.
- At any time, the Reset button should reset the counter to 0000 and after that, the counter shall resume its counting.
- The counting must be implemented with a timer interrupt and you must use GPIO interrupts to handle the signals from the buttons!

## Explanation Code

This task extends the binary counter from Task 2 by replacing manual button increments/decrements with automatic counting using a timer interrupt. The program still uses four LEDs (GP1–GP4) but adds a reset button on GP0 to restart the count.

The key feature here is the repeating hardware timer, initialized with:
add_repeating_timer_ms(1000, repeating_timer_callback, NULL, &timer);
This sets up a timer that triggers every 1000 milliseconds (1 second). Each time the timer interrupt fires, the callback function increments the counter by 1 until it reaches 15 (1111). When the counter reaches its maximum value, it stops increasing further.

A GPIO interrupt is also attached to the reset button (GP0), using the falling edge trigger. When pressed, the reset ISR sets the counter back to 0 and calls update_leds() to refresh the display. The counter then resumes counting automatically from zero.

All LED updates are handled by the update_leds() function, which shifts the counter bits and writes each bit to its corresponding LED pin. Both interrupts (timer and GPIO) operate independently, demonstrating how multiple interrupt sources can coexist in the Pico’s architecture.

The overall structure and logic are similar to Task 2, but instead of user-driven button interrupts for counting, the timer interrupt drives the counting.


## Hardware Layout
The hardware layout is the same as Task 2.\
![Layout](../ass4/images)

### Electric Circuit Plan
Note: The application didn't have Pico H, so I used the normal Pico instead. Pin connection should still be correct **where it was used**.\
(same as task 2)\
![0](../ass4/images)

## Execution

After uploading and running the program:

The counter begins at 0000 and increases by one every second (1 Hz rate).

Once the value 1111 is reached, the counter stops increasing automatically.

Pressing the reset button on GP0 resets the LEDs to 0000, and counting continues again from zero.

The counting and reset functionality are both interrupt-driven, meaning the main loop (while(1)) remains idle, executing only tight_loop_contents() while all real work happens asynchronously in interrupt handlers.

**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

## Sourcecode files
// TODO: edit file directory
[foo.S](../ass4/task3/foo.S)\
[CMakeLists.txt](../ass4/task3/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass4/task3/pico_sdk_import.cmake)\
[foo.uf2](../ass4/task3/build/foo.uf2)

To get to the whole Task 3 directory instead, click [here](../ass4/task3/).

---
# Sources
## Images that weren't taken by ourselves
foo

## Pico Pinout
https://pico2.pinout.xyz/ \
https://datasheets.raspberrypi.com/pico/Pico-R3-A4-Pinout.pdf

## Pico Instructions
https://developer.arm.com/documentation/dui0473/m/arm-and-thumb-instructions/arm-and-thumb-instruction-summary \
https://github.com/Apress/RP2040-Assembly-Language-Programming/tree/main \
https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf

## C coding
https://stackoverflow.com/questions/55330597/how-do-i-execute-a-c-file \
https://www.geeksforgeeks.org/c/c-switch-statement/ \
https://www.youtube.com/watch?v=ciio80nkjB8&list=WL&index=12&t=240s
https://www.geeksforgeeks.org/c-programming-language/
https://stackoverflow.com/questions/55330597/how-do-i-execute-a-c-file

## Interrupts examples:
https://github.com/raspberrypi/pico-examples/tree/master/gpio/interrupts
https://forums.raspberrypi.com/viewtopic.php?t=319091
https://github.com/raspberrypi/pico-examples/tree/master/timer
https://raspberrypi.github.io/pico-sdk-doxygen/group__hardware__timer.html

## For general studying / Other
https://www.raspberrypi.com/documentation/computers/getting-started.html \
https://www.raspberrypi.com/documentation/microcontrollers/c_sdk.html \
https://studio2.org.uk/jack/RP2040%20Assembly%20Language%20Programming%20%28Smith%29.pdf \
https://projects.raspberrypi.org/en/projects/getting-started-with-the-pico \
https://www.circuit-diagram.org/editor/

https://www.raspberrypi.com/documentation/microcontrollers/c_sdk.html
https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf
https://raspberrypi.github.io/pico-sdk-doxygen/group__hardware__gpio.html
https://raspberrypi.github.io/pico-sdk-doxygen/group__hardware__irq.html

