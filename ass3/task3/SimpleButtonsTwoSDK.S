@
@ Assembler program to read input of 2 buttons and set 2 LEDs
@ to either on or off depending on what button was pressed.
@ This time, WITHOUT C-functions.
@
@ GPIO 0 is LED1
@ GPIO 1 is LED2
@ GPIO 2 is BUTTON1 (BTN1)
@ GPIO 3 is BUTTON2 (BTN2)
@

.EQU SIO_BASE, 0xD0000000
.EQU GPIO_IN, 0x004         @ read all current GPIO IN values
.EQU GPIO_OUT, 0x010        @ write GPIO output
.EQU GPIO_OUT_SET, 0x014    @ set bits to HIGH; output
.EQU GPIO_OUT_CLR, 0x018    @ set bits to LOW (clear); output
.EQU GPIO_OE_SET, 0x024     @ activate pin as output; OE = Output Enable
.EQU GPIO_OE_CLR, 0x028     @ deactivate pin as output (revert GPIO_OE_SET)

.EQU LED1_PIN_MASK, (1 << 0)    @ LED1 at GP0
.EQU LED2_PIN_MASK, (1 << 1)    @ LED2 at GP1
.EQU BTN1_PIN_MASK, (1 << 2)    @ BUTTON1 at GP2
.EQU BTN2_PIN_MASK, (1 << 3)    @ BUTTON2 at GP3

.thumb_func              @ Necessary because sdk uses BLX
.global main             @ Provide program starting address to linker

main:
    LDR R1, =SIO_BASE

    @ --- configure LED1 as OUTPUT ---
    LDR R0, =LED1_PIN_MASK
    STR R0, [R1, #GPIO_OE_SET]    @ write in register that LED1
				  @ is output pin
	
    @ --- configure LED2 as OUTPUT ---
    LDR R0, =LED2_PIN_MASK
    STR R0, [R1, #GPIO_OE_SET]    @ ..same procedure as LED1
	
    @ --- configure BTN1 ---


    @ --- configure BTN2 ---


checkAllInputs:
    LDR R2, [R1, #GPIO_IN]        @ Load address of SIO_Base + 0x004
				  @ (all current input values) onto R2
    MOV R3, #BTN1_PIN_MASK	  @ FIX: unshifted register required
				  @ error line 52 (AND)
    MOV R4, R2			  @ Copy R2 onto R4
    AND R4, R4, R3                @ find bit that has common 1
				  @ bit address in R2 (example case):
				  @                00001010
				  @ bit mask btn1: 00001000
				  @ AND:           00001000
				  @ keep only matching bit value 1 at
				  @ position of btn1 mask
    LSR R4, R4, #2		  @ shift bit 2 (because 2²=4) to
				  @ position of LSB
				  @ (least significant bit; bit at
				  @ rightmost position = pos. 0)
    CMP R4, #0			  @ check if button was pressed (LOW)
    BEQ turnOn			  @ if button pressed -> turn LEDs on
    
    MOV R3, #BTN2_PIN_MASK	  @ FIX: unshifted register required
				  @ error line 71 (AND)
				  
				  @ no need for another R2 copy since
				  @ its end of function (where it was
				  @ needed)
    AND R2, R2, R3                @ get bit at position BTN2_PIN_MASK
    LSR R2, R2, #3		  @ 2³=8
    CMP R2, #0
    BEQ turnOff			  @ if button pressed -> turn LEDs off

turnOn:
    MOV R0, #LED1_PIN_MASK	  @ Move address of LED1 to R0
    STR R0, [R1, #GPIO_OUT_SET]   @ Set LED1 to HIGH (turn on)
    MOV R0, #LED2_PIN_MASK	  @ .. same procedure as LED1
    STR R0, [R1, #GPIO_OUT_SET]
    B checkAllInputs

turnOff:
    MOV R0, #LED1_PIN_MASK	  @ Move address of LED1 to R0
    STR R0, [R1, #GPIO_OUT_CLR]   @ Set LED1 to LOW (clear bits; off)
    MOV R0, #LED2_PIN_MASK	  @ .. same procedure as LED1
    STR R0, [R1, #GPIO_OUT_CLR]
    B checkAllInputs
