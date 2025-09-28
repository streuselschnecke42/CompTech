@
@ Assembler program to imitate binary counting using 
@ three LEDs connected to the Raspberry Pi Pico
@ GPIO port using the Pico SDK.
@

	.EQU	LED_PIN1, 0			@ equate which means define
	.EQU	LED_PIN2, 1			@ define var LED_PIN2 as GP2 (pico pin 2)
	.EQU	LED_PIN3, 2
	.EQU	GPIO_OUT, 1	    @ define GPIO_OUT address (reuse task2)
								        @ (datasheet 2.3.1.7 address doesnt work)
	.EQU	sleep_time, 400		@ var sleep_time is now value 300

.thumb_func		  @ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
  @ --- configure LED 1 ---
	MOV	R0, #LED_PIN1			@ register 0 is now storing var LED_PIN1
	BL	gpio_init				  @ initialize pin in other function
	MOV	R0, #LED_PIN1			@ reassign LED_PIN1 because init 
								        @ function could have changed stored
								        @ value in register 0
	MOV	R1, #GPIO_OUT			@ set register 1 as output variable
	BL	link_gpio_set_dir		@ go to function to configure output pin
	
	@ --- configure LED 2 ---
	MOV	R0, #LED_PIN2			@ store var LED_PIN2 on register 0
	BL	gpio_init				  @ ... same as LED 1...
	MOV	R0, #LED_PIN2
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	@ --- configure LED 3 ---
	MOV	R0, #LED_PIN3
	BL	gpio_init
	MOV	R0, #LED_PIN3
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir

	MOV R7, #0             @ initialize counter
	@BL	stdio_init_all	   @ initialize uart or usb
	
forwards:
  @MOV R9, #0            @ set loop flag

  BL checkbits
  LDR R0, =sleep_time
  BL sleep_ms

	ADD R7, R7, #0b001    @ count 0001 up
	CMP R7, #0b111        @ see if R7 has reached limit of 0111
	BEQ backwards         @ if so, count backwards now
	B forwards            @ otherwise continue current loop

backwards:
  @MOV R9, #1            @ set loop flag

  BL checkbits
  LDR R0, =sleep_time
  BL sleep_ms

	SUB R7, R7, #0b001    @ count 0001 down
	CMP R7, #0b000        @ see if R7 has reached limit of 0111
	BEQ forwards          @ if so, count forwards now
	B backwards           @ otherwise continue current loop

  @checkbits:
  @  MOV R0, R7            @ value = R7 (binary counter)
  @  MOV R1, R8            @ position = R8 (checkbits counter)
  @  BL get_binary         @ get bit value (return value on R0)
  @  CMP R8, #3            @ only 3 bits to check total
  @  BEQ sendback
  @  B checkbits

checkbits:
  MOV R0, R7            @ value = R7 (binary counter)
  MOV R1, #0            @ position = 0
  BL get_binary         @ get bit value (return value on R0)
  MOV R1, R0            @ returned bit will be value for LED output
  MOV R0, #LED_PIN1     @ LED1 represents bit at pos 0
  BL link_gpio_put      @ R0 = argument 1, R1 = argument 2
  @ B checksecondbit

  @ checksecondbit:
  MOV R0, R7
  MOV R1, #1
  BL get_binary
  MOV R1, R0
  MOV R0, #LED_PIN2
  BL link_gpio_put
  @ B checkthirdbit

  @ checkthirdbit
  MOV R0, R7
  MOV R1, #2
  BL get_binary
  MOV R1, R0
  MOV R0, #LED_PIN3
  BL link_gpio_put
  @ B sendback
  BX LR @versuch danach mal nur B oder BLX weil BXLR nicht im datenblatt ist

@ helperfunction to check where to send program to after checkbits
@ sendback:
@  CMP R9, #1
@  BEQ backwards
@  B forwards