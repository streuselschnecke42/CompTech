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

#include "hardware/regs/io_bank0.h"

.EQU SIO_BASE, 0xd0000000
.EQU SIO_GPIO_OE_SET_OFFSET, 0x00000024
.EQU SIO_GPIO_OUT_SET_OFFSET, 0x00000014
.EQU SIO_GPIO_OUT_CLR_OFFSET, 0x00000018

.EQU IO_BANK0_BASE, 0x40014000
.EQU IO_BANK0_BASE, 0x40014000
@ Wish there was more detailed documentation to find
@ those values, so i can fix my shit :)))
@.EQU IO_BANK0_GPIO3_CTRL_FUNCSEL_VALUE_SIO_3, 0x0000001f @ ??
@.EQU IO_BANK0_GPIO0_CTRL_OFFSET, 0x04 @ ??

.EQU PADS_BANK0_BASE, 0x4001c000
.EQU PADS_BANK0_GPIO0_IE_BITS, 0x00000040 @ Input Enable?
.EQU PADS_BANK0_GPIO0_OD_BITS, 0x00000080 @ Output Disable
.EQU PADS_BANK0_GPIO0_OFFSET, 0x00000000 @ No proper documentation found

.EQU REG_ALIAS_SET_BITS, (0x2 << 12)

.EQU GPIO_OUT_SET, 0x014    @ set bits to HIGH; output
.EQU GPIO_OUT_CLR, 0x018    @ set bits to LOW (clear); output
.EQU GPIO_OE_SET, 0x024     @ activate pin as output; OE = Output Enable
.EQU GPIO_OE_CLR, 0x028     @ deactivate pin as output (revert GPIO_OE_SET)

.EQU LED1_BITMASK, (1 << 0)    @ LED1 pin mask at GP0
.EQU LED2_BITMASK, (1 << 1)    @ LED2 pin mask at GP1
.EQU BTN1_BITMASK, (1 << 2)    @ BUTTON1 pin mask at GP2
.EQU BTN2_BITMASK, (1 << 3)    @ BUTTON2 pin mask at GP3

.EQU LED1, 0    @ LED1 at GP0
.EQU LED2, 1    @ LED2 at GP1
.EQU BTN1, 2    @ BUTTON1 at GP2
.EQU BTN2, 3    @ BUTTON2 at GP3

.thumb_func              @ Necessary because sdk uses BLX
.global main             @ Provide program starting address to linker

    .align 4             @ testing a theory

main:
    LDR R7, =SIO_BASE
    LDR R6, =PADS_BANK0_BASE

    @ --- configure LED1 as OUTPUT --- 
    MOV R0, #LED1_BITMASK
    MOV R1, #LED1
    BL gpioinit
    
    @ --- configure LED2 as OUTPUT ---
    MOV R0, #LED2_BITMASK
    MOV R1, #LED2
    BL gpioinit

    @ --- configure BTN1 ---
    @ TODO
    @ maybe set flag R2 and if 1 its in and 0 means out like c function
    @LDR R0, =BTN1
    @STR R0, [R1, #GPIO_OE_CLR]

    @ --- configure BTN2 ---
    @ TODO

checkAllInputs:
    @ TODO fix this garbage, cuz it sux rn
    LDR R2, [R1, #GPIO_IN]        @ Load address of SIO_Base + 0x004
				                          @ (all current input values) onto R2
    MOV R3, #BTN1                 @ FIX: unshifted register required
				                          @ error line 52 (AND)
    MOV R4, R2			              @ Copy R2 onto R4
    AND R4, R4, R3                @ find bit that has common 1
                                  @ bit address in R2 (example case):
                                  @                00001010
                                  @ bit mask btn1: 00001000
                                  @ AND:           00001000
                                  @ keep only matching bit value 1 at
                                  @ position of btn1 mask
    LSR R4, R4, #2		            @ shift bit 2 (because 2²=4) to
                                  @ position of LSB
                                  @ (least significant bit; bit at
                                  @ rightmost position = pos. 0)
    CMP R4, #1			              @ check if button was pressed (LOW)
    BEQ turnOn			              @ if button pressed -> turn LEDs on
    
    MOV R3, #BTN2	                @ FIX: unshifted register required
                                  @ error line 71 (AND)
                                  
                                  @ no need for another R2 copy since
                                  @ its end of function (where it was
                                  @ needed)
    AND R2, R2, R3                @ get bit at position BTN2_PIN_MASK
    LSR R2, R2, #3		            @ 2³=8
    CMP R2, #0
    BEQ turnOff			              @ if button pressed -> turn LEDs off

turnOn:
    MOV R3, #LED1_BITMASK
    LDR R2, R7                    @ SIO_BASE
    STR R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]

    MOV R3, #LED2_BITMASK
    LDR R2, R7                    @ SIO_BASE
    STR R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]

    BX LR

turnOff:
    MOV R3, #LED1_BITMASK
    LDR R2, R7              @ SIO_BASE
    STR R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]

    MOV R3, #LED2_BITMASK
    LDR R2, R7              @ SIO_BASE
    STR R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]

    BX LR

@ INPUT: R0 - PIN BITMASK
@ INPUT: R1 - PIN NUMBER (NORMAL)
@ PRE-SET INPUT: R6 - PADS_BANK0_BASE address
@ PRE-SET INPUT: R7 - SIO_BASE address
@ R2 - (temp) used for shifting 4 and 8 bits and adding
@ R4 - (temp) used for loading addresses onto
@ R5 - (temp) used for moving addresses onto + STR
gpioinit:
    STR R0, [R7, #SIO_GPIO_OE_SET_OFFSET]   @ set pin to output
    STR R0, [R7, #SIO_GPIO_OUT_CLR_OFFSET]  @ set output pin to 0

    MOV R2, R1
    LSL R2, R2, #2
    ADD R2, R6, R2
    MOV R5, #PADS_BANK0_GPIO0_IE_BITS
    LDR R4, =REG_ALIAS_SET_BITS
    ORR R6, R4
    STR R5, [R7, #PADS_BANK0_GPIO0_OFFSET]
    
    MOV R2, R1
    LSL R2, R2, #3
    LDR R4, =IO_BANK0_BASE
    ADD R2, R2, R4
    MOV R5, #IO_BANK0_GPIO3_CTRL_FUNCSEL_VALUE_SIO_3
    STR R5, [R2, #IO_BANK0_GPIO0_CTRL_OFFSET]
    BX LR
