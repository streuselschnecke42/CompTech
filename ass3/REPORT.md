# 1DT301 Lab Assignment 3
*Computer Technology 1* \
*October 21, 2025*

Author: Michelle Weber, Sanja Janevska\
Examiner: Mehdi Saman Azari\
Semester: HT25\
Discipline: NGDNS, NGDPV


# Tasks

# Task 1
Write a program to calculate the average value of 8 numbers defined in the .data section. Then, show the result in the terminal (i.e. Minicom). You can use the code as a template (see [Tasksheet](../ass3/Lab%203%20-%20Subroutines%20and%20inputs.pdf)).\
To show the result, the easiest way is probably to write the result continuously in an infinte loop, as in the Hello World program.

## Explanation(s) Code
For this task, minicom was used to display the output.\
In this program, the Pico continuously calculates the average of an array of eight integers and prints the result over the serial connection. It first initializes the standard I/O system for UART or USB communication using the stdio_init_all function provided by the Pico SDK.\
Inside the main loop, the program loads the address of the integer array my_array into register R0 and stores the number of elements (8) in register R1. It then calls the subroutine average, which computes the average value of the numbers in the array.\
The average subroutine loads each integer from memory, adds them together using register R7 as an accumulator, and finally divides the total by 8 using a logical shift right instruction (LSR R7, R7, #3). The result (the average value) is returned in register R0.\
After returning from the subroutine, the main loop moves the computed average into R1 (the second parameter for printf) and loads the address of the format string "Average value %d\n" into R0. It then calls printf to display the result over the serial output.\
The program runs continuously in an infinite loop, repeatedly calculating and printing the same average value of the array.

In the second solution (Sanja's), our program begins by initializing the standard stdio_init_all to enable the printing and then enters a loop where it loads the array address into R0 and the number of elements into R1 before calling the average subroutine.\
In the average subroutine registers R4-R7 were used to temporarily hold and sum the array elements, adding four elements at a time and then one more time just one element (re-using the registers) and then it stored the total sum in R0 and divided by 8 by using logical shift right (LSR).\
After that the program moves the average value into R1, loads the address of the format string into R0 and calls printf to display the message. The program then loops forever.

## Execution
The program can be visible by using minicom.\
When the build file has been made and "cmake .." and "make" has been successfully executed inside the build file, you load the file onto the pico with "sudo picotool load AverageArrayValue.uf2" and then force-restart the pico with "sudo picotool reboot -f". It will then remove the pico as a data drive in your device and execute the program on the pico. Use the command "minicom -b 115200 -o -D /dev/ttyACM0" to open minicom and see the program's output.\
![average_value_minicom](../ass3/images/minicom_output_task1.png)\
This whole program will loop forever, until you unplug the pico or press Ctrl A and then Z for help and choose X for "reset and exit".

**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

## Sourcecode files - Michelle
[AverageArrayValue.S](../ass3/task1-michelle/AverageArrayValue.S)\
[CMakeLists.txt](../ass3/task1-michelle/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass3/task1-michelle/pico_sdk_import.cmake)\
[AverageValue.uf2](../ass3/task1-michelle/build/AverageArrayValue.uf2)

To get to the whole Task 1 directory instead, click [here](../ass3/task1-michelle/).

## Sourcecode files - Sanja
[AverageArrayValue.S](../ass3/task1-sanja/AverageValue.S)\
[CMakeLists.txt](../ass3/task1-sanja/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass3/task1-sanja/pico_sdk_import.cmake)\
[AverageValue.uf2](../ass3/task1-sanja/build/AverageValue.uf2)

To get to the whole Task 1 directory instead, click [here](../ass3/task1-sanja/).


# Task 2
Connect two LEDs to GP0+GP1 and two pushbuttons: One connected to GP2 and one to GP3. First, you must find out how to connect the push button and how to set up the pin to read if it is pushed down or not!\
Then, write a program with the following functionality:\
If push button on GP1 is pushed down, turn on both LEDs. If push button on GP2 is pushed down, turn off both LEDs. Ignore the case when both buttons are down!\
In this task, you must use a C function to read the pin!

## Explanation Code
To get both LEDs working for this task, they need to get initialized. This can be done by using C functions. To initialize the LED pins, gpio_init was used. To set the direction of those pins, that the LEDs are connected to, gpio_set_dir was used. This function takes 2 values. The first one is the LED pin number on the pico and the other is the direction value. If the value is 1, the direction will be set to output (meaning GPIO_OUT), so for the LEDs, value 1 was used.\
Now, to get both Buttons working, they need to get not only initialized but also need extra configuration to properly read their input. This can be done by using C functions. To initialize the Button pins, gpio_init was used. To set the direction of those pins, that the Buttons are connected to, gpio_set_dir was used. The first one is the Button pin number on the pico and the other is the direction value. If the value is 0, the direction will be set to input (meaning GPIO_IN), so for the Buttons, value 0 was used. The next step is to make the input values readable. This can be done by using the C function gpio_pull_up for each button. Pull up sets internal pull-up-resistor.Without this method, value would float around and return unstable or arbitrary values.

Now, the input can be proplerly red and the hardware components are initialized. So the program can now go to the main loop functions checkBtnOne and checkBtnTwo. These two functions will loop endlessly.\
The function checkBtnOne reads the input from button 1 and compares the return value from gpio_get. gpio_get will return 0 for this pin, if the button is pressed. If the button is pressed, the function will move to the turnOn function, that turns both LEDs on, by using link_gpio_put_all. This function minimizes code length as it has 2 cases:
- Case 1: do gpio_put_all for both of the LEDs bit positions setting both LED pins to 1
- Case 0: go gpio_put_all for both of the LEDs bit positions setting both LED pins to 0

So, case 1 is called when button 1 is pressed to turn both LEDs on. If button 1 is not pressed, the function checkBtnOne will go to checkBtnTwo instead.\
The function checkBtnTwo checks the input of button 2 and if button 2 is pressed (return value is 0), checkBtnTwo moves to the turnOff function which calls the link_gpio_put_all function, but this time with value 0 for both LEDs. So, it turns both LEDs off.

## Hardware - Layout
![Layout](../ass3/images/task_2+3_hardware_layout.jpg)

### Electric Circuit Plan
Note: The application didn't have Pico H, so I used the normal Pico instead. Pin connection should still be correct **where it was used**.\
![0](../ass3/images/circuit_plan_task2_3.png)

## Execution
When the build file has been made and "cmake .." and "make" has been successfully executed inside the build file, you hold down the BOOTSEL button while plugging the pico into your device.Then, load the file onto the pico with "sudo picotool load SimpleButtonsOneSDK.uf2" and then force-restart the pico with "sudo picotool reboot -f". It will then remove the pico as a data drive in your device and execute the program on the pico.\
If you now press the first button, both LEDs should light up (see image below).\
![button_1_pressed](../ass3/images/task_2+3_button_on.jpg)\
If you then press the second button, both LEDs should turn off (see image below).\
![button_2_pressed](../ass3/images/task_2+3_button_off.jpg)

The buttons can be pressed as many times as the user wants, since the code runs in an endless loop. Just like the task required, the case where both buttons are pressed, will be ignored.

**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

## Sourcecode files
[SimpleButtonsOneSDK.S](../ass3/task2/SimpleButtonsOneSDK.S)\
[CMakeLists.txt](../ass3/task2/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass3/task2/pico_sdk_import.cmake)\
[SimpleButtonsOneSDK.uf2](../ass3/task2/build/SimpleButtonsOneSDK.uf2)

To get to the whole Task 2 directory instead, click [here](../ass3/task2/).


# Task 3
Use the same hardware setup as in Task 2.\
This time, you are not allowed to use C functions to read from the input pin or to turn the LEDs on/off! You must use read and write instructions to and from hardware registers. You can use the example from the book, chapter 9.\
You are allowed to use C functions to initialize and set direction, like in the program listing 8-1 in the book. Alternatively, you can use the gpioinit function in Listing 9-5 to initialize the pins.

## Explanation Code - Sanja's version without ANY C functions
Sanja's solution starts by initializing the system using sdtio_init_all and configuring the GPIO pins. The LED pins are set as outputs while the buttons are set as inputs.\
Then to ensure stable reading of the pushbuttons, the internal pull-up resistors are enabled by writing to the PAD control registers. The program then goes through an infinite loop where it continuously reads the state of each pushbutton by using the gpio_get subroutine.\
This function shifts a mask over the relevant GPIO input bit, ANDs it with the GPIO input register and returns a 0 or a 1, depending on whether the button is being pressed.\
If BUTTON1 (BTN1) is pressed the gpio_on subroutine is being called which sets the output bits to the corresponding LEDs by writing to the SIO_GPIO_OUT_SET_OFFSET register. If BUTTON2 (BTN2) is pressed, the gpio_off subroutine calls the output bits using SIO_GPIO_OUT_CLR_OFFSET register.\
The gpio_on and gpio_off subroutines work by constructing a bitmask for the target pin shifting the 1 into the correct position and writing it to the appropriate SIO register, and by that it directly controls the voltage on the GPIO pins. 

## Explanation Code - Michelle's version with C functions to initialize and set direction
The code for initializing pins for LEDs and Buttons and setting the direction is the same as task 2.\
This time, there will be no C function for reading or writing instructions. Instead, the program uses the hardware registers.\
The loop for checking button 1 and 2 and the conditions for button 1 or 2 being pressed, are the same as task 2.\
To read input from the buttons, the progam has a gpioget function that manually reads the hardware registers for specific pins. The function takes the pin value as input and shifts value 1 to this pin position. It then loads the gpiobase address onto register R2. 'gpiobase' is the Single Input-Output base address. The program then adds the input offset (SIO_GPIO_IN_OFFSET) onto the gpiobase. This is to read the input of the pico pin. The next line uses the AND command to compare the bit addresses and find the ones that match. Then, it shifts to the address it needs, which is the pin position. Everything else will be discarded ('shifted off'). The result will be moved to R0 as return value. That value will then be used in the functions checkBtnOne and checkBtnTwo.\
Those functions compare the return value and if it matches 0, that means the button that was put into the gpioget function, was pressed.

If button 1 is pressed, the program moves to the turnOn function, to turn on the LEDs.\
This function turns on both LEDs one by one. First by moving the pin value of LED1 to register R0, moving 1 onto another Register R3 and then shifting that value 1 to the LED pin value to get the LEDs bitmask. Next, the address of gpiobase from memory is loaded onto a register. The address will be loaded onto register R2 this time. This gpiobase address will be combined with the offset for setting gpio outputs (SIO_GPIO_OUT_SET_OFFSET). This way, we get the complete address for setting output of gpios. The bitmask that is stored in register R3 will now be stored/written onto the gpio output set register. This turns the LED in this bitmask on.\
This process will be repeated for LED2.\
After all LEDs are turned on, the program will resume to the main loops.

If button 2 is pressed, the program moves to the turnOff function, to turn the LEDs off.\
The function is almost like the turnOn function, but this time, the LEDs will be turned off instead of on. They will be turned off one by one, and the process is the same as in the function turnOn, only that this time, the gpiobase address will be combined with the offset for clearing gpio outputs (SIO_GPIO_OUT_CLR_OFFSET). This way, we get the complete address for clearing output of gpios. The bitmask that is stored in register R3 will now be stored/written onto the gpio output clear register. This turns the LED in this bitmask off.\
After all LEDs are turned off, the program will resume to the main loops.

## Hardware Layout
The hardware layout is the same as Task 2.\
![Layout](../ass3/images/task_2+3_hardware_layout.jpg)

### Electric Circuit Plan
Note: The application didn't have Pico H, so I used the normal Pico instead. Pin connection should still be correct **where it was used**.\
(same as task 2)\
![0](../ass3/images/circuit_plan_task2_3.png)

## Execution
The execution is the same as Task 2.\
When the build file has been made and "cmake .." and "make" has been successfully executed inside the build file, you hold down the BOOTSEL button while plugging the pico into your device.Then, load the file onto the pico with "sudo picotool load SimpleButtonsOneSDK.uf2" and then force-restart the pico with "sudo picotool reboot -f". It will then remove the pico as a data drive in your device and execute the program on the pico.\
If you now press the first button, both LEDs should light up (see image below).\
![button_1_pressed](../ass3/images/task_2+3_button_on.jpg)\
If you then press the second button, both LEDs should turn off (see image below).\
![button_2_pressed](../ass3/images/task_2+3_button_off.jpg)

The buttons can be pressed as many times as the user wants, since the code runs in an endless loop. Just like the task required, the case where both buttons are pressed, will be ignored.

**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

## Sourcecode files - Sanja's version
[SimpleButtonsTwoSDK.S](../ass3/task3-sanja/SecondLedPushbuttons.S)\
[CMakeLists.txt](../ass3/task3-sanja/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass3/task3-sanja/pico_sdk_import.cmake)\
[SimpleButtonsTwoSDK.uf2](../ass3/task3-sanja/build/SecondLedPushbuttons.uf2)

To get to the whole Task 3 directory instead, click [here](../ass3/task3-sanja/).

## Sourcecode files - Michelle's version
[SimpleButtonsTwoSDK.S](../ass3/task3-michelle/SimpleButtonsTwoSDK.S)\
[CMakeLists.txt](../ass3/task3-michelle/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass3/task3-michelle/pico_sdk_import.cmake)\
[SimpleButtonsTwoSDK.uf2](../ass3/task3-michelle/build/SimpleButtonsTwoSDK.uf2)

To get to the whole Task 3 directory instead, click [here](../ass3/task3-michelle/).

---
# Sources

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
