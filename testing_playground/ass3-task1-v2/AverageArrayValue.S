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
	
	MOV R7, #0           @ reset R3 (temp calculation variable)
	@MOV R6, #0           @ initiate counter
	
	BL	average          @ Call subroutine average,
						 @ with parameters R0 and R1
						 
	@ print string and average value
	MOV R1, R0			 @ move average value to printf (parameter R1)
	LDR R0, =message_str  @ load address of helloworld string
	BL printf			 @ call pico_printf
	B	loop             @ loop forever
	
@ subroutine average takes the parameters:
@ R0 - memory address to first element of int array
@ R1 - number of integers in array (len array)
@ R0 - return value (int average value)
average:
	@ TODO: complete this (task)
	
	@CMP R6, #0
	@BEQ get_next
	
	LDR R2, [R0, #0]
	ADD R7, R7, R2
	
	LDR R2, [R0, #4]
	ADD R7, R7, R2
	
	LDR R2, [R0, #8]
	ADD R7, R7, R2
	
	LDR R2, [R0, #12]
	ADD R7, R7, R2
	
	LDR R2, [R0, #16]
	ADD R7, R7, R2
	
	LDR R2, [R0, #20]
	ADD R7, R7, R2
	
	LDR R2, [R0, #24]
	ADD R7, R7, R2
	
	LDR R2, [R0, #28]
	ADD R7, R7, R2
	
	LSR R7, R7, #3
	
	@ADD R0, R0, #4       @ word has 4 Bytes -> go to next value in array
	@SUB R1, R1, #1
	
	MOV R0, #0            @ nuke array address
	MOV R0, R7            @ store result R3 in R0
	BX LR                 @ go back to man loop (spot stored in LR)

	
@ this was initially to prevent the redundant code but the jump to here
@ causes minocom to not show shit, so it probably overwrites the LR
@ register but i dont know how or why....
get_next:
	LSL R5, R5, R6
	LDR R7, [R0, R2]
	ADD R2, R2, R7
	ADD R6, R6, #1
	
	CMP R6, R7
	BEQ average
	B get_next

.data
	       .align  4     @ necessary alignment
	       message_str: .asciz   "Average value %d\n"
	       .align  4     @ necessary alignment
	       my_array: .word 10, 20, 30, 40, 50, 60, 70, 80
