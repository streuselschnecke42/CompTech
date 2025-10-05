# 1DT301 Lab Assignment 2 - Introduction to RPi Pico
*Computer Technology 1* \
*October 5, 2025*

Author: Michelle Weber, Sanja Janevska\
Examiner: Mehdi Saman Azari\
Semester: HT25\
Discipline: NGDNS, NGDPV

# Tasks
## Task 1
- Download the source code for the Hello World program presented on page
24 in Stephen Smith’s book.
- Modify the program so that the counter starts at 100, decreases by one each
time the loop is repeated. Print the text Hello World followed by the counter
number. When the counter reaches 0, it shall be reset to 100 and start
decreasing again, in an infinite loop
- Compile and upload the program to the Pico. Open minicom, putty or a
similar terminal to show the result

### Explanation Code
For this task, minicom was used to display the output. The task was pretty straightforward.

The pre-written program already had needed variables assigned and a working code. So, all that was needed to do was to change it, so it counts from 100 to 0 with endless repetitions.\
The main program set the counter (Register 7) to 101. This way, the counter would be decremented to 100 before the print statement but it would then print from 100 downwards. Thats why 101 was stored in R7, instead of 100.\
The loop starts by storing the address "helloworld" of the string "Hello World %d\n" onto Register 0. It then decreases the counter (Register 7) by 1, moves that new value in Register 7 onto Register 1, and calls the print function. This function then prints the String "Hello World " combined with the value in Register 1 "%d" and a new line at the end "\n".\
Afterwards the value of Register 7 will be compared to 0 to see if the value is already at 0 and needs to be reset or not. If the value in Register 7 is not 0 yet, the loop will continue (start over) until it reaches 0. If the value is indeed 0, the "pointer" will be moved to the reset function, which then resets the value of Register 7 to 101, and sends you back to the top of the loop function.

### Execution
The program can be visible by using minicom. When the build file has been made and "cmake .." and "make" has been successfully executed inside the build file, you load the file onto the pico with "sudo picotool load HelloWorld.uf2" and then force-restart the pico with "sudo picotool reboot -f". It will then remove the pico as a data drive in your device and execute the program on the pico. Use the command "minicom -b 115200 -o -D /dev/ttyACM0" to open minicom and see the program's output.\
![hello_world_minicom](../ass2/images/hello_world_minicom.png)\
This whole program will loop forever, until you unplug the pico or press Ctrl A and then Z for help and choose X for "reset and exit".\
**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

### Sourcecode files
[HelloWorld.S](../ass2/task1/HelloWorld.S)\
[CMakeLists.txt](../ass2/task1/HelloWorld.S)\
[pico_sdk_import.cmake](../ass2/task1/pico_sdk_import.cmake)\
[HelloWorld.uf2](../ass2/task1/build/HelloWorld.uf2)

To get to the whole Task 1 directory instead, click [here](../ass2/task1/).

## Task 2
Connect one green, one yellow and one red light to three of the pins, in the same
order as a traffic light. Then, write a program to make them flash like a traffic light.\
Use pins GP0 for green, GP1 for yellow and GP2 for green LED! Also, make sure
you understand how to connect an LED and remember to ALWAYS connect it in
series to a resistor

You can use the code in Listing 8-1 (page 150). Copy everything from folder
Chapter 8/1/ and edit the .S file to write your own code!
Note: The functions link_gpio_put and link_gpio_set_dir are C functions, not
assembly, but you don’t need to care much about this, just remember to copy the
file sdklink.c!

### Explanation Code
//TODO: enter explanation of code here

### Hardware Layout
![picoLEDImage](../ass2/images/instert_image_here)

// TODO: Explain wiring or make electric circuit plan

### Execution
The program can be visible by using minicom. When the build file has been made and "cmake .." and "make" has been successfully executed inside the build file, you load the file onto the pico with "sudo picotool load HelloWorld.uf2" and then force-restart the pico with "sudo picotool reboot -f". It will then remove the pico as a data drive in your device and execute the program on the pico.

//TODO: enter further explanation here

**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

### Sourcecode files
[flashledssdk.S](../ass2/task2/flashledssdk.S)\
[CMakeLists.txt](../ass2/task2/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass2/task2/pico_sdk_import.cmake)\
[FlashLEDsSDK.uf2](../ass2/task2/build/FlashLEDsSDK.uf2)

To get to the whole Task 2 directory instead, click [here](../ass2/task2/).

## Task 3
Use the same setup as in Task 2 and create a binary conter that counts from 000 up
to 111. The picture below shows the first 4 steps. When the counter reaches its final
value 111, count back to 000 one step at a time, repeate infinitely. Make one second
delay between the counter values.

### Explanation Code
//TODO: enter explanation of code here

// TODO: Maybe enter explanation for c function??

#### Explanation of the C function "get_binary" in sdklink.c
Here is an example from the [testing_playground](../testing_playground/binary_values.c) to show how the function "get_binary" in [sdklink.c](../ass2/task3/sdklink.c) works:
![binary_shift_function_in_C](../ass2/images/getting_bits_explained.PNG)

### Hardware Layout
![picoLEDImage](../ass2/images/instert_image_here)

// TODO: Explain wiring or make electric circuit plan\
~ same as task 2 ~

### Execution
The program can be visible by using minicom. When the build file has been made and "cmake .." and "make" has been successfully executed inside the build file, you load the file onto the pico with "sudo picotool load HelloWorld.uf2" and then force-restart the pico with "sudo picotool reboot -f". It will then remove the pico as a data drive in your device and execute the program on the pico.

//TODO: enter further explanation here

**Note:** This explanation of the commands was based on the Raspberry Pi 3 Model B V1.2 and *NOT* the virtual machine. However, the Raspberry had a similar OS than the VM. The Raspberry uses Bullseye 32-bit, so the commands *should* be the same (not tested).

### Sourcecode files
[ledcountersdk.S](../ass2/task3/ledcountersdk.S)\
[CMakeLists.txt](../ass2/task3/CMakeLists.txt)\
[pico_sdk_import.cmake](../ass2/task3/pico_sdk_import.cmake)\
[LEDCounterSDK.uf2](../ass2/task3/build/LEDCounterSDK.uf2)

To get to the whole Task 3 directory instead, click [here](../ass2/task3/).