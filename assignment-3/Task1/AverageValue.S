@
@ Assembler program print out "Hello World"
@ using the Pico SDK.
@
@ R0 - first parameter to printf
@ R1 - second parameter to printer
@ R7 - index counter
@

.thumb_func		    @ Necessary because sdk uses BLX
.global main	            @ Provide program starting address to linker

main:
	MOV	R7, #101		@ initialize counter to 101
	BL	stdio_init_all	@ initialize uart or usb
loop:
	LDR	R0, =helloworld	@ load address of helloworld string
	
	SUB R7, R7, #1	@ decrement counter by 1
	MOV	R1, R7		@ Move the counter to second parameter
	BL	printf		@ Call pico_printf
	CMP R7, #0		@ check if counter reached 0
	BNE loop		@ if not 0, continue to loop
	MOV R7, #101	@ reset counter to 101
	B	loop		@ loop forever
		
.data
	       .align  4	@ necessary alignment
helloworld: .asciz   "Hello World %d\n"
