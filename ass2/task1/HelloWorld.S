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
	MOV	R7, #101         @ initialize counter to 101
	BL	stdio_init_all   @ initialize uart or usb
loop:
	LDR	R0, =helloworld  @ load address of helloworld string
	SUB	R7, #1           @ Decrement counter
	MOV	R1, R7           @ Move the counter to second parameter
	BL	printf           @ Call pico_printf
	CMP R7, #0           @ Compare value of register 7 with dec 0
	BEQ reset            @ If counter equals 0 go to reset function
	B	loop             @ (otherwise) loop forever
		
reset:
	MOV R7, #101         @ reset value to start value 101
	B loop               @ go back to loop

.data
	       .align  4     @ necessary alignment
helloworld: .asciz   "Hello World %d\n"
