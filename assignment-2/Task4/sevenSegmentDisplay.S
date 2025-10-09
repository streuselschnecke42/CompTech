@
@ Assembler program for a counter from 0-9-0 and repeat infinitely.
@ and displays on the 7-segment display
@ and connected to RaspberryPi Pico GPIO port using the Pico SDK
@

	.EQU	LED_A, 0	@ Segment A on GPIO 0
	.EQU	LED_B, 1	@ Segment B on GPIO 1
	.EQU	LED_C, 2	@ Segment C on GPIO 2
	.EQU	LED_D, 3	@ Segment D on GPIO 3
	.EQU	LED_E, 4	@ Segment E on GPIO 4
	.EQU	LED_F, 5	@ Segment F on GPIO 5
	.EQU	LED_G, 6	@ Segment G on GPIO 6
	.EQU	GPIO_OUT, 1	@ Constant for "output" direction
	.EQU	sleep_time, 1000 @delay time of 1 second

.thumb_func	@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	@ Configure all seven GPIO pins as outputs
	MOV	R0, #LED_A	@ R0 = 0, select GPIO 0
	BL	gpio_init	@ Call SDK, initialize GPIO 0
	MOV	R0, #LED_A	@ R0 = 0 again
	MOV	R1, #GPIO_OUT	@ R1 = 1 (output mode)
	BL	link_gpio_set_dir	@ Set GPIO 0 as output
	
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
	BL reset	@ Clear all segments before showing next digit
	@Display digit zero (Segments A, B, C, D, E, F ON)
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
	LDR R0, =sleep_time	@ Wait one second
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
	@ Subroutine reset which turns all segments off
	PUSH {LR}	@ Save return address on stack
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
	POP {PC}	@ Restore PC (turn to caller)
	BX LR		@ safety branch (never reached)
