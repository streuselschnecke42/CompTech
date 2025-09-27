@
@ Assembler program to imitate binary counting using 
@ three LEDs connected to the Raspberry Pi Pico
@ GPIO port using the Pico SDK.
@

	@.EQU	LED_PIN1, 0			@ equate which means define
	@.EQU	LED_PIN2, 1			@ define var LED_PIN2 as GP2 (pico pin 2)
	@.EQU	LED_PIN3, 2
	.EQU	GPIO_OUT, 0xD0000010	@ define output as official GPIO_OUT
								@ address according to datasheet 2.3.1.7
	.EQU	sleep_time, 300		@ var sleep_time is now value 300

.thumb_func		@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	MOV R1, #0b00
	BL	stdio_init_all	@ initialize uart or usb
	
forwards:
	LDR R0, =GPIO_OUT
	STRB R1, [R0]
	
	LDR R0, =sleep_time
	STR R0, [R0]
	BL sleep_ms

	ADD R1, R1, #0b001
	BL	printf		@ Call pico_printf
	CMP R1, #0b111
	BEQ backwards
	B forwards

backwards:
	LDR R0, =GPIO_OUT
	STR R1, [R0]
	
	LDR R0, =sleep_time
	STR R0, [R0]
	BL sleep_ms

	SUB R1, R1, #0b001
	BL	printf		@ Call pico_printf
	CMP R1, #0b000
	BEQ forwards
	B backwards
