@
@ Assembler program to read input of 2 buttons and set 2 LEDs
@ to either on or off depending on what button was pressed.
@ It reads or sets GPIO pins using Pico SDK in an endless loop.
@
@ GPIO 0 is LED1
@ GPIO 1 is LED2
@ GPIO 2 is BUTTON1 (BTN1)
@ GPIO 3 is BUTTON2 (BTN2)
@

.EQU LED1, 0
.EQU BTN1, 1
.EQU BTN2, 2
.EQU GPIO_IN, 0          @ gpio_set_dir(second value)
						 @ second value == 0 means input (output = false)
.EQU GPIO_OUT, 1         @ second value == 1 means output (output = true)

.thumb_func              @ Necessary because sdk uses BLX
.global main             @ Provide program starting address to linker

main:
	@ --- configure LED1 ---
	MOV R0, #LED1
	BL gpio_init
	MOV R0, #LED1
	MOV R1, #GPIO_OUT
	BL link_gpio_set_dir
	
	@ --- configure BTN1 ---
	MOV R0, #BTN1
	BL gpio_init
	MOV R0, #BTN1
	MOV R1, #GPIO_IN
	BL link_gpio_set_dir
	MOV R0, #BTN1
	BL link_gpio_pull_up		@ pull up sets internal pull-up-resistor
								@ without method, value would float
								@ around and return unstable or 
								@ arbitrary values
	
	@ --- configure BTN2 ---
	MOV R0, #BTN2
	BL gpio_init
	MOV R0, #BTN2
	MOV R1, #GPIO_IN
	BL link_gpio_set_dir
	MOV R0, #BTN2
	BL link_gpio_pull_up

checkBtnOne:
	MOV R0, #BTN1
	BL link_gpio_get
	CMP R0, #0					@ 0 means button is pressed
	BEQ turnOn
	B checkBtnTwo
	
checkBtnTwo:
	MOV R0, #BTN2
	BL link_gpio_get
	CMP R0, #0
	BEQ turnOff
	B checkBtnOne
	
turnOn:
	MOV R0, #LED1
	MOV R1, #1
	BL link_gpio_put
	B checkBtnTwo
	
turnOff:
	MOV R0, #LED1
	MOV R1, #0
	BL link_gpio_put
	B checkBtnOne
