@
@ Assembler program to create a 3-bit binary counter
@ that counts from 0 to 7 to 0 infinitely and flashes accordingly
@ three LEDs connected to the
@ Raspberry Pi Pico GPIO port using the Pico SDK.
@

	.EQU	LED_PIN1, 0
	.EQU	LED_PIN2, 1
	.EQU	LED_PIN3, 2
	.EQU	GPIO_OUT, 1
	.EQU	sleep_time,	1000 @Delay time of 1 second

.thumb_func	@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	MOV	R0, #LED_PIN1
	BL	gpio_init
	MOV	R0, #LED_PIN1
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	MOV	R0, #LED_PIN2
	BL	gpio_init
	MOV	R0, #LED_PIN2
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	MOV	R0, #LED_PIN3
	BL	gpio_init
	MOV	R0, #LED_PIN3
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir	
	MOV R7, #0 @counter=0
	MOV R6, #1 @direction =+1 (count up)
loop:
	@ Counter 0 (000) 
	MOV R0, #LED_PIN1
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #0
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 1 (001)
	MOV R0, #LED_PIN1
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 2 (010)
	MOV R0, #LED_PIN1
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #0
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 3 (011)
	MOV R0, #LED_PIN1
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 4 (100)
	MOV R0, #LED_PIN1
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #0
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 5 (101)
	MOV R0, #LED_PIN1
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 6 (110)
	MOV R0, #LED_PIN1
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #0
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 7 (111)
	MOV R0, #LED_PIN1
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 6 (110)
	MOV R0, #LED_PIN1
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #0
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 5 (101)
	MOV R0, #LED_PIN1
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 4 (100)
	MOV R0, #LED_PIN1
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #0
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 3 (011)
	MOV R0, #LED_PIN1
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 2 (010)
	MOV R0, #LED_PIN1
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #1
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #0
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ Counter 1 (001)
	MOV R0, #LED_PIN1
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN2
	MOV R1, #0
	BL link_gpio_put
	
	MOV R0, #LED_PIN3
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	
	B loop
