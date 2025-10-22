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
// TODO: explain code

## Hardware - Layout
![Layout](../ass4/images)

### Electric Circuit Plan
Note: The application didn't have Pico H, so I used the normal Pico instead. Pin connection should still be correct **where it was used**.\
![0](../ass4/images)

## Execution
// TODO

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
// TODO: explain code

## Hardware Layout
The hardware layout is the same as Task 2.\
![Layout](../ass4/images)

### Electric Circuit Plan
Note: The application didn't have Pico H, so I used the normal Pico instead. Pin connection should still be correct **where it was used**.\
(same as task 2)\
![0](../ass4/images)

## Execution
// TODO

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

## For general studying / Other
https://www.raspberrypi.com/documentation/computers/getting-started.html \
https://www.raspberrypi.com/documentation/microcontrollers/c_sdk.html \
https://studio2.org.uk/jack/RP2040%20Assembly%20Language%20Programming%20%28Smith%29.pdf \
https://projects.raspberrypi.org/en/projects/getting-started-with-the-pico \
https://www.circuit-diagram.org/editor/
