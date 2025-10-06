@
@ Assembler program to create a binary counter
@ that counts from 000 to 111 and flashes accordingly
@ three LEDs connected to the
@ Raspberry Pi Pico GPIO port using the Pico SDK.
@

	.EQU	LED_PIN1, 0
	.EQU	LED_PIN2, 1
	.EQU	LED_PIN3, 2
	.EQU	GPIO_OUT, 1
	.EQU	sleep_time,	1000 @sleep time of 1 second

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
	MOV R7, #0  @counter = 0
	MOV R6, #1  @direction = +1 (count up)
	
loop:
	@ --- Set LEDs according to counter value ---
	@ LED_PIN1 (bit0)
	MOV	R0, #LED_PIN1
	AND R1, R7, #1
	BL	link_gpio_put
	
	@ LED_PIN2 (bit1)
	MOV R0, #LED_PIN2
	LSR R1, R7, #1
	AND R1, R1, #1
	BL link_gpio_put
	
	@LED_PIN3 (bit2)
	MOV R0, #LED_PIN3
	LSR R1, R7, #2
	AND R1, R1, #1
	BL	link_gpio_put
	
	@ --- Delay ---
	LDR R0, =sleep_time
	BL sleep_ms
	
	@ --- Update Counter ---
	ADD R7, R7, R6
	
	@ If counter == 7 -> reverse direction
	CMP R7, #7
	BNE check_zero
	MOV R6, #-1
	B       loop
	
	check_zero:
	@ --- If counter == 0 -> reverse direction
	CMP R7, #0
	BNE loop
	MOV R6, #1
	B loop
