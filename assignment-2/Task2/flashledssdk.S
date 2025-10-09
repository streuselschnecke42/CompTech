@
@ Assembler program to flash three LEDs connected to the
@ Raspberry Pi Pico GPIO port using the Pico SDK.
@

	.EQU	LED_PIN1, 0 @defining LED_PIN1 will be connected to pin GPIO 0
	.EQU	LED_PIN2, 1
	.EQU	LED_PIN3, 2
	.EQU	GPIO_OUT, 1 @the pan direction will be sent to output
	.EQU	sleep_time, 200 @sleep delay 

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
	
	@Initialize Pin3
	MOV	R0, #LED_PIN3
	BL	gpio_init @ configures the pin for GPIO function
	MOV	R0, #LED_PIN3
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir @ sets it as output
loop:   
	MOV	R0, #LED_PIN1
	MOV	R1, #1 		@ turn LED_PIN1 ON
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN1
	MOV	R1, #0		@ turn LED_PIN1 OFF
	BL	link_gpio_put
	
	MOV	R0, #LED_PIN2
	MOV	R1, #1		@ turn LED_PIN2 ON
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN2
	MOV	R1, #0		@ turn LED_PIN2 OFF
	BL	link_gpio_put
	
	MOV	R0, #LED_PIN3
	MOV	R1, #1		@ turn LED_PIN3 ON
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN3
	MOV	R1, #0		@ turn LED_PIN3 ON
	BL	link_gpio_put
	
	MOV	R0, #LED_PIN2
	MOV	R1, #1		@ turn LED_PIN2 ON
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN2
	MOV	R1, #0		@ turn LED_PIN2 ON
	BL	link_gpio_put
	
	B       loop 	@loop infinitely
