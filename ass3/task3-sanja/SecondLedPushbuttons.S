@
@ Assembler program to flash two LEDs by using push buttons
@ without using c funtions, connected to the
@ Raspberry Pi GPIO writing to the registers directly.
@
@

#include "hardware/regs/addressmap.h"
#include "hardware/regs/sio.h"
#include "hardware/regs/io_bank0.h"
#include "hardware/regs/pads_bank0.h"

	.EQU LED_PIN1, 0	@defining LED_PIN1 is connected to pin GPIO 0
	.EQU LED_PIN2, 1	@LED_PIN2 is connected to GPIO 1
	.EQU BTN1, 2		@BTN1 is connected to GPIO 2
	.EQU BTN2, 3		@BTN2 is connected to GPIO 3
	.EQU GPIO_OUT, 1
	.EQU GPIO_IN, 0

.thumb_func
.global main	        @ Provide program starting address
.align  4				@ necessary alignment
	
main:
	BL stdio_init_all
	MOV	R0, #LED_PIN1		
	BL	gpio_init
	MOV R0, #LED_PIN1
	MOV R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
@Initialize pushbutton 1 BTN1
	MOV	R0, #BTN1
	BL	gpio_init 		@ configures the pin for GPIO function
	MOV	R0, #BTN1
	MOV	R1, #GPIO_IN
	BL	link_gpio_set_dir @ sets 0 as input

@Initialize pushbutton 2 BTN2
	MOV	R0, #BTN2
	BL	gpio_init 		@ configures the pin for GPIO function
	MOV	R0, #BTN2
	MOV	R1, #GPIO_IN
	BL	link_gpio_set_dir @ sets 0 as input
	
loop:
@ Turn each pin on and off by the use of push buttons
	MOV	R0, #BTN1	
	BL	gpio_get
	CMP R0, #0		@ pressed = 0
	BEQ gpio_on
	
	MOV R0, #BTN2
	BL gpio_get
	CMP R0, #0		@ pressed = 0
	BEQ gpio_off
       
    B       loop	@ loop forever
    
@ Enable input and output for the buttons using pads
    LDR R2, padsbank0       @ load base of pads bank0
    MOV R3, #BTN1           @ button pin
    LSL R3, #2              @ each PAD register is 4 bytes
    ADD R2, R2, R3
    LDR R3, =0x100          @ enable pull-up (PUE bit)
    STR R3, [R2]
    
    LDR R2, padsbank0       @ load base of pads bank0
    MOV R3, #BTN2           @ button pin
    LSL R3, #2              @ each PAD register is 4 bytes
    ADD R2, R2, R3
    LDR R3, =0x100          @ enable pull-up (PUE bit)
    STR R3, [R2]

@ Turn on a GPIO pin.
gpio_on:
	MOV R0, #LED_PIN1
	MOV	R3, #1
	LSL	R3, R0	@ shift over to pin position
	LDR	R2, gpiobase	@ address we want
	STR	R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]

	MOV R0, #LED_PIN2
	MOV	R3, #1
	LSL	R3, R0	@ shift over to pin position
	LDR	R2, gpiobase	@ address we want
	STR	R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]
	BX	LR
	
@ Turn off a GPIO pin.
gpio_off:
	MOV R0, #LED_PIN1
	MOV	R3, #1
	LSL	R3, R0	@ shift over to pin position
	LDR	R2, gpiobase	@ address we want
	STR	R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]
	
	MOV R0, #LED_PIN2
	MOV	R3, #1
	LSL	R3, R0	@ shift over to pin position
	LDR	R2, gpiobase	@ address we want
	STR	R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]
	BX	LR
	
@ Get function:
gpio_get:
	MOV R3, #1
	LSL R3, R0	@ shift over to pin position
	LDR R2, gpiobase	@ address we want
	LDR R1, [R2, #SIO_GPIO_IN_OFFSET]
	AND R3, R3, R1	@ Do a bitwise AND to mask out the desired bitwise
	LSR R3, R3, R0	@ Shift the bit to the rightmost position
	MOV R0, R3		@ Move the result to register R0
	BX LR

	      	.align  4	@ necessary alignment
gpiobase:	.word	SIO_BASE     @ base of the GPIO registers
iobank0:	.word	IO_BANK0_BASE @ base of io config registers
padsbank0:	.word	PADS_BANK0_BASE
setoffset:	.word	REG_ALIAS_SET_BITS
