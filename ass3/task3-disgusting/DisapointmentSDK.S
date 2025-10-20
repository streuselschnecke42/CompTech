@
@ Assembler program to read input of 2 buttons and set 2 LEDs
@ to either on or off depending on what button was pressed.
@ It reads or sets GPIO pins, without C functions, in an endless loop.
@ This is the disgusting and sad version.
@

#include "hardware/regs/addressmap.h"
#include "hardware/regs/sio.h"
#include "hardware/regs/io_bank0.h"
#include "hardware/regs/pads_bank0.h"

.EQU LED1, 0
.EQU LED2, 1
.EQU BTN1, 2
.EQU BTN2, 3

.EQU GPIO_OUT, 1
.EQU GPIO_IN, 0

.thumb_func
.global main                        @ Provide program starting address

    .align 4                        @ necessary alignment

main:
  @ --- configure LED1 ---
  MOV R0, #LED1
  BL gpio_init
  MOV R0, #LED1
  MOV R1, #GPIO_OUT
  BL link_gpio_set_dir
	
  @ --- configure LED2 ---
  MOV R0, #LED2
  BL gpio_init
  MOV R0, #LED2
  MOV R1, #GPIO_OUT
  BL link_gpio_set_dir
	
  @ --- configure BTN1 ---
  MOV R0, #BTN1
  BL gpio_init
  MOV R0, #BTN1
  MOV R1, #GPIO_IN
  BL link_gpio_set_dir
  MOV R0, #BTN1
  BL link_gpio_pull_up
	
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
  BL gpioget
  CMP R1, #0
  BEQ turnOn
  B checkBtnTwo
  
checkBtnTwo:
  MOV R0, #BTN2
  BL gpioget
  CMP R1, #0	      	@ ERROR: NEVER REACHES THIS EQUALITY
  BEQ turnOff
  B checkBtnOne

gpioget:
  LDR R2, =SIO_BASE                   @ for reading you need actual address not word
  LDR R3, [R2, #SIO_GPIO_IN_OFFSET]
  MOV R1, #1
  LSL R1, R0                          @ shift over to pin position; get pin mask
  AND R1, R3, R1                      @ R1 will be 0 or 1 << pin
  BX LR

turnOn:
  MOV R0, #LED1
  MOV R3, #1
  LSL R3, R0                          @ shift over to pin position
  LDR R2, gpiobase                    @ address we want
  STR R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]
  
  MOV R0, #LED2
  MOV R3, #1
  LSL R3, R0                          @ shift over to pin position
  LDR R2, gpiobase                    @ address we want
  STR R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]
  
  BX LR

turnOff:
  MOV R0, #LED1
  MOV R3, #1
  LSL R3, R0                          @ shift over to pin position
  LDR R2, gpiobase                    @ address we want
  STR R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]
  
  MOV R0, #LED2
  MOV R3, #1
  LSL R3, R0                          @ shift over to pin position
  LDR R2, gpiobase                    @ address we want
  STR R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]
  
  BX LR

    .align 4                          @ necessary alignment

gpiobase: .word SIO_BASE @ base of the GPIO registers
@gpioinput: .word SIO_GPIO_IN_OFFSET
iobank0: .word IO_BANK0_BASE @ base of io config registers
padsbank0: .word PADS_BANK0_BASE
setoffset: .word REG_ALIAS_SET_BITS
