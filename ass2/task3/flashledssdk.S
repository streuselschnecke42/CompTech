@
@ Assembler program to imitate binary counting using 
@ three LEDs connected to the Raspberry Pi Pico
@ GPIO port using the Pico SDK.
@

	.EQU	LED_PIN1, 0			@ equate which means define
	.EQU	LED_PIN2, 1			@ define var LED_PIN2 as GP2 (pico pin 2)
	.EQU	LED_PIN3, 2
	.EQU	GPIO_OUT, 1			@ define output as 1
	.EQU	sleep_time, 200		@ var sleep_time is now value 200

.thumb_func		@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
    @ --- configure LED 1 ---
	MOV	R0, #LED_PIN1			@ register 0 is now storing var LED_PIN1
	BL	gpio_init				@ initialize pin in other function
	MOV	R0, #LED_PIN1			@ reassign LED_PIN1 because init 
								@ function could have changed stored
								@ value in register 0
	MOV	R1, #GPIO_OUT			@ set register 1 as output variable
	BL	link_gpio_set_dir		@ go to function to configure output pin
	
	@ --- configure LED 2 ---
	MOV	R0, #LED_PIN2			@ store var LED_PIN2 on register 0
	BL	gpio_init				@ ... same as LED 1...
	MOV	R0, #LED_PIN2
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	@ --- configure LED 3 ---
	MOV	R0, #LED_PIN3
	BL	gpio_init
	MOV	R0, #LED_PIN3
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
loop:
	@ --- turn LED 1 on ---
    MOV	R0, #LED_PIN1			@ store var LED_PIN1 on register 0
	MOV	R1, #1					@ r1 = 1 -> to turn LED on
	BL	link_gpio_put			@ configure output in function
								@ (set pin to make LED turn on)
	LDR	R0, =sleep_time			@ store sleep_time value in register 0
	BL	sleep_ms				@ go to function that basically does
								@ this: leave LED on for amount 
								@ stored in sleep_time (200ms)
	@ --- turn LED 1 off ---
	MOV	R0, #LED_PIN1			@ store var LED_PIN1 on register 0
	MOV	R1, #0					@ r1 = 0 -> to turn LED off
	BL	link_gpio_put			@ configure output in function
	
	
	@ --- turn LED 2 on ---
	MOV	R0, #LED_PIN2
	MOV	R1, #1
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	
	@ --- turn LED 2 off ---
	MOV	R0, #LED_PIN2
	MOV	R1, #0
	BL	link_gpio_put
	
	@ --- turn LED 3 on ---
	MOV	R0, #LED_PIN3
	MOV	R1, #1
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	
	@ --- turn LED 3 off ---
	MOV	R0, #LED_PIN3
	MOV	R1, #0
	BL	link_gpio_put
	
	@ --- turn LED 2 on ---
	MOV	R0, #LED_PIN2
	MOV	R1, #1
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	
	@ --- turn LED 2 off ---
	MOV	R0, #LED_PIN2
	MOV	R1, #0
	BL	link_gpio_put

	B       loop				@ loop endless
