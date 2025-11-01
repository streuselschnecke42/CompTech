@
@ Assembler program print out "Average Value" of 8 numbers
@ using the Pico SDK.
@
@ R0 - first parameter to printf
@ R1 - second parameter to printer
@ R7 - index counter
@

.thumb_func		    @ Necessary because sdk uses BLX
.global main		@ Provide program starting address to linker

main:
	BL	stdio_init_all	@ initialize uart or usb
loop:
	LDR	R0, =my_array	@ load the address of the first array element
	MOV R1, #8			@ 8 elements in the array
	BL average			@ Call the subroutine average, with parameters R0 and R1
	
	@Print string and average value
	MOV R1, R0 			@ Move average value to printf parameter R1
	LDR R0, =message_str	@ load address of helloworld string
	BL printf		@ Call pico_printf
	B loop			@ loop forever

@Subroutine average takes the parameters:
@R0 - Memory address to first element of integer array
@R1 - Number of integers in the array
@R0 - Return value (integer average value)

average:
	   PUSH {R4-R7, LR}			@ using and re-using low registers L4-L7
	   LDR R4, [R0, #(4*0)]		@ index [0] in the array
	   LDR R5, [R0, #(4*1)]		@ index [1] in the array
	   LDR R6, [R0, #(4*2)]		@ index [2] in the array
	   LDR R7, [R0, #(4*3)]		@ index [3] in the array
	   
	   ADD R4, R4, R5
	   ADD R4, R4, R6
	   ADD R4, R4, R7
	   
	   @ Loading the next 3 while reusing the same registers
	   LDR R5, [R0, #(4*4)]		@ index [4] in the array
	   LDR R6, [R0, #(4*5)]		@ index [5] in the array
	   LDR R7, [R0, #(4*6)]		@ index [6] in the array

	   ADD R4, R4, R5
	   ADD R4, R4, R6
	   ADD R4, R4, R7
	   
	   @ Repeating it one more time for the last element in the array
	   LDR R5, [R0, #(4*7)]	@ index [7] in the array
	   ADD R4, R4, R5
	   
	   MOV R0, R4
	   LSR R0, R0, #3 @divide by 8 since 2³ = 8
	   
	   POP {R4-R7, PC}
	   BX LR
		
.data
	       .align  4	@ necessary alignment
	       message_str: .asciz "Average value %d\n"
	       .align  4	@ necessary alignment
	       my_array: .word 10, 20, 30, 40, 50, 60, 70, 80
