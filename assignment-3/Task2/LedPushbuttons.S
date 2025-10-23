@
@ Assembler program to turn on and off two LEDs by using push buttons
@ connected to the Raspberry Pi Pico GPIO port using the Pico SDK.
@

	.EQU	LED_PIN1, 0 @defining LED_PIN1 is connected to pin GPIO 0
	.EQU	LED_PIN2, 1 @LED_PIN2 is connected to GPIO 1
	.EQU	BTN1, 2		@BTN1 is connected to GPIO 2
	.EQU	BTN2, 3		@BTN2 is connected to GPIO 3
	.EQU	GPIO_OUT, 1 @the pan direction will be sent to output

.thumb_func	@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	@Initialize Pin1
	MOV	R0, #LED_PIN1	@ put the value 0 into the register R0	
	BL	gpio_init 		@ configures the pin for GPIO function
	MOV	R0, #LED_PIN1
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir @ sets it as output
	
	@Initialize Pin2
	MOV	R0, #LED_PIN2
	BL	gpio_init 		@ configures the pin for GPIO function
	MOV	R0, #LED_PIN2
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir @ sets it as output
	
	@Initialize pushbutton 1 BTN1
	MOV	R0, #BTN1
	BL	gpio_init 		@ configures the pin for GPIO function
	MOV	R0, #BTN1
	MOV	R1, #0
	BL	link_gpio_set_dir @ sets 0 as input
	
	MOV R0, #BTN1
	BL link_gpio_pull_up @ enable internal pull up
	
	@Initialize pushbutton 2 BTN2
	MOV	R0, #BTN2
	BL	gpio_init 		@ configures the pin for GPIO function
	MOV	R0, #BTN2
	MOV	R1, #0
	BL	link_gpio_set_dir @ sets 0 as input
	
	MOV R0, #BTN2
	BL link_gpio_pull_up
	
loop:
	@Turn both LEDs on
	MOV	R0, #BTN1
	BL link_gpio_get
	CMP R0, #0		@ pressed = 0
	BEQ both_on
	
	@Turn both LEDs off
	MOV R0, #BTN2
	BL link_gpio_get
	CMP R0, #0		@ pressed = 0
	BEQ both_off
	
	B 		loop 	@ loop forever
	
both_on:
	MOV R0, #LED_PIN1
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #1
	BL link_gpio_put
	
	B 		loop	@ loop forever

both_off:
	MOV R0, #LED_PIN1
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #0
	BL link_gpio_put
	
	B       loop 	@loop infinitely
