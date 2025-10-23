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

.thumb_func
.global main	        @ Provide program starting address

	.align  4	@ necessary alignment
main:
@ Init each of the two pins and set them to output
	MOV	R0, #LED_PIN1		
	BL	gpioinit
	MOV	R0, #LED_PIN2
	BL	gpioinit
	
@Initialize pushbutton 1 BTN1
	MOV	R0, #BTN1
	BL	gpio_init 		@ configures the pin for GPIO function
	MOV	R0, #BTN1
	MOV	R1, #0
	BL	link_gpio_set_dir @ sets 0 as input

@Initialize pushbutton 2 BTN2
	MOV	R0, #BTN2
	BL	gpio_init 		@ configures the pin for GPIO function
	MOV	R0, #BTN2
	MOV	R1, #0
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

@ Initialize the GPIO to SIO. r0 = pin to init.

gpioinit:
@ Initialize the GPIO	
	MOV	R3, #1
	LSL	R3, R0	@ shift over to pin position
	LDR	R2, gpiobase	@ address we want	
	STR	R3, [R2, #SIO_GPIO_OE_SET_OFFSET]
	STR	R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]

@ Enable input and output for the pin
	LDR	R2, padsbank0
	LSL	R3, R0, #2	@ pin * 4 for register address
	ADD	R2, R3		@ Actual set of registers for pin
	MOV	R1, #PADS_BANK0_GPIO0_IE_BITS
	LDR	R4, setoffset
	ORR	R2, R4
	STR	R1, [R2, #PADS_BANK0_GPIO0_OFFSET]

@ Set the function number to SIO.
	LSL	R0, #3		@ each GPIO has 8 bytes of registers
	LDR	R2, iobank0	@ address we want
	ADD	R2, R0		@ add the offset for the pin number
	MOV	R1, #IO_BANK0_GPIO3_CTRL_FUNCSEL_VALUE_SIO_3
	STR	R1, [R2, #IO_BANK0_GPIO0_CTRL_OFFSET]
	BX	LR

@ Turn on a GPIO pin.
gpio_on:
	MOV R0, #LED_PIN1
	MOV	R3, #1
	LSL	R3, R0	@ shift over to pin position
	LDR	R2, gpiobase	@ address we want
	STR	R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]
	BX	LR

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
	BX	LR
	
	MOV R0, #LED_PIN2
	MOV	R3, #1
	LSL	R3, R0	@ shift over to pin position
	LDR	R2, gpiobase	@ address we want
	STR	R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]
	BX	LR
	
@ Get function:
gpio_get:
	MOV R3, #1
	LSR R3, R0	@ shift over to pin position
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
