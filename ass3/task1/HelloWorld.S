@
@ Assembler program print out "Hello World"
@ using the Pico SDK.
@
@ R0 - first parameter to printf
@ R1 - second parameter to printer
@ R7 - index counter
@

.thumb_func              @ Necessary because sdk uses BLX
.global main             @ Provide program starting address to linker

main:
	BL	stdio_init_all   @ initialize uart or usb

loop:
	LDR	R0, =my_array  	 @ load address of my_array string
	MOV	R1, #8           @ 8 elements in the array
	BL	average          @ Call subroutine average,
						 @ with parameters R0 and R1
						 
	@ print string and average value
	MOV R1, R0			 @ move average value to printf (parameter R1)
	LDR R0 =message_str  @ load address of helloworld string
	BL printf			 @ call pico_printf
	B	loop             @ loop forever
	
@ subroutine average takes the parameters:
@ R0 - memory address to first element of int array
@ R1 - number of integers in array (len array)
@ R2 - return value (int average value)
average:
	@ TODO: complete this (task)
	
	B loop               @ go back to loop

.data
	       .align  4     @ necessary alignment
	       message_str: .asciz   "Average value %d\n"
	       .align  4     @ necessary alignment
	       my_array: .word 10, 20, 30, 40, 50, 60, 70, 80
