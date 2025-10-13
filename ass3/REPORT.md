# 1DT301 Lab Assignment 3
*Computer Technology 1* \
*October 8, 2025*

Author: Michelle Weber, Sanja Janevska\
Examiner: Mehdi Saman Azari\
Semester: HT25\
Discipline: NGDNS, NGDPV


# Tasks

# Task 1
// TODO

## Explanation Code
For this task, minicom was used to display the output.
// TODO

## Execution
// TODO
The program can be visible by using minicom. When the build file has been made and "cmake .." and "make" has been successfully executed inside the build file, you load the file onto the pico with "sudo picotool load HelloWorld.uf2" and then force-restart the pico with "sudo picotool reboot -f". It will then remove the pico as a data drive in your device and execute the program on the pico. Use the command "minicom -b 115200 -o -D /dev/ttyACM0" to open minicom and see the program's output.\
// TODO CHANGE IMAGE \
![hello_world_minicom](../ass2/images/hello_world_minicom.png)\
This whole program will loop forever, until you unplug the pico or press Ctrl A and then Z for help and choose X for "reset and exit".\
**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

## Sourcecode files
// TODO

To get to the whole Task 1 directory instead, click [here](../ass3/task1/).


# Task 2
// TODO

## Explanation Code
// TODO

## Hardware - Layout
// TODO

### Electric Circuit Plan
Note: The application didn't have Pico H, so I used the normal Pico instead. Pin connection should still be correct **where it was used**.\
// TODO

## Execution
// TODO

**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

## Sourcecode files
// TODO

To get to the whole Task 2 directory instead, click [here](../ass3/task2/).


# Task 3
// TODO

## Explanation Code
// TODO

### The new C function "get_binary" in sdklink.c
// TODO

## Hardware Layout
// TODO

### Electric Circuit Plan
Note: The application didn't have Pico H, so I used the normal Pico instead. Pin connection should still be correct **where it was used**.
// TODO

## Execution
// TODO

**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

## Sourcecode files
// TODO

To get to the whole Task 3 directory instead, click [here](../ass3/task3/).

---
# Sources
## Images that weren't taken by ourselves

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
