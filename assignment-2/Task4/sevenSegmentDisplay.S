@
@ Assembler program for a counter from 0-9-0 and repeat infinitely.
@ and displays on the 7-segment display
@ and connected to RaspberryPi Pico GPIO port using the Pico SDK
@

	.EQU	LED_A, 0
	.EQU	LED_B, 1
	.EQU	LED_C, 2
	.EQU	LED_D, 3
	.EQU	LED_E, 4
	.EQU	LED_F, 5
	.EQU	LED_G, 6
	.EQU	GPIO_OUT, 1
	.EQU	sleep_time, 1000 @delay time of 1 second

.thumb_func	@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	MOV	R0, #LED_A
	BL	gpio_init
	MOV	R0, #LED_A
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	MOV	R0, #LED_B
	BL	gpio_init
	MOV	R0, #LED_B
	MOV R1, #GPIO_OUT
	BL link_gpio_set_dir
	
	MOV	R0, #LED_C
	BL	gpio_init
	MOV	R0, #LED_C
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	MOV	R0, #LED_D
	BL	gpio_init
	MOV	R0, #LED_D
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	MOV	R0, #LED_E
	BL	gpio_init
	MOV	R0, #LED_E
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	MOV	R0, #LED_F
	BL	gpio_init
	MOV	R0, #LED_F
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	MOV	R0, #LED_G
	BL	gpio_init
	MOV	R0, #LED_G
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	
loop:
	BL reset
	@Zero
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_E
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_F
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@One
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Two
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_E
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Three
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Four
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_F
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Five
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_F
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Six
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_E
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_F
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Seven
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Eight
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_E
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_F
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Nine
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_F
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Eight
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_E
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_F
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Seven
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Six
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_E
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_F
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Five
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_F
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Four
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_F
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Three
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@Two
	MOV R0, #LED_A
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_E
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset
	
	@One
	MOV R0, #LED_B
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #1
	BL link_gpio_put
	LDR R0, =sleep_time
	BL sleep_ms
	BL reset

	B loop
	
reset:
	PUSH {LR}
	MOV R0, #LED_A
	MOV R1, #0
	BL link_gpio_put
	MOV R0, #LED_B
	MOV R1, #0
	BL link_gpio_put
	MOV R0, #LED_C
	MOV R1, #0
	BL link_gpio_put
	MOV R0, #LED_D
	MOV R1, #0
	BL link_gpio_put
	MOV R0, #LED_E
	MOV R1, #0
	BL link_gpio_put
	MOV R0, #LED_F
	MOV R1, #0
	BL link_gpio_put
	MOV R0, #LED_G
	MOV R1, #0
	BL link_gpio_put
	POP {PC}
	BX LR
