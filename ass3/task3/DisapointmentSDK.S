@
@ Assembler program to flash three LEDs connected to the
@ Raspberry Pi GPIO writing to the registers directly.
@

#include "hardware/regs/addressmap.h"
#include "hardware/regs/sio.h"
#include "hardware/regs/io_bank0.h"
#include "hardware/regs/pads_bank0.h"

.EQU LED_PIN1, 0
.EQU LED_PIN2, 1
.EQU BTN1, 2
.EQU BTN2, 3

.thumb_func
.global main                        @ Provide program starting address

    .align 4                        @ necessary alignment

main:
  @ initialize LED1
  MOV R0, #LED_PIN1
  BL gpioinit_out
  
  @ initialize LED2
  MOV R0, #LED_PIN2
  BL gpioinit_out
  
  @ initialize BUTTON1
  MOV R0, #BTN1
  BL gpioinit_in
  
  @ initialize BUTTON2
  MOV R0, #BTN2
  BL gpioinit_in

checkBtnOne:
	MOV R0, #BTN1
	BL gpioget            @ <-- prob this function's fault or button init
	CMP R0, #0            @ FIX SHIT
	BEQ turnOn            @ ERROR: CONSTANTLY EQUAL
	B checkBtnTwo
  
checkBtnTwo:
	MOV R0, #BTN2
	BL gpioget
	CMP R0, #0
	BEQ turnOff           @ ERROR: CONSTANTLY EQUAL
	B checkBtnOne

@ Initialize the GPIO to SIO. r0 = pin to init.
gpioinit_in:
  @ Initialize the GPIO
  MOV R3, #1
  LSL R3, R0                          @ shift over to pin position
  LDR R2, gpiobase                    @ address we want
  STR R3, [R2, #SIO_GPIO_OE_CLR_OFFSET] @ Output DISABLE = set pin as input
  
  @ Enable input and output for the pin
  LDR R2, padsbank0
  LSL R3, R0, #2                      @ pin * 4 for register address
  ADD R2, R3                          @ Actual set of registers for pin
  
  LDR R1, [R2]                        @ read current register (current PAD config)
  MOV R7, #PADS_BANK0_GPIO0_IE_BITS
  MOV R6, #PADS_BANK0_GPIO0_PUE_BITS
  ORR R1, R1, R7                      @ set bit 6 (IE) Input Enable
  ORR R1, R1, R6                      @ set bit 8 (PUE) Pull Up Enable
  STR R1, [R2]                        @ write new value back onto R2
  
  @ Set the function number to SIO.
  LSL R0, #3                          @ each GPIO has 8 bytes of registers
  LDR R2, iobank0                     @ address we want
  ADD R2, R0                          @ add the offset for the pin number
  MOV R1, #IO_BANK0_GPIO3_CTRL_FUNCSEL_VALUE_SIO_3 @ ??? dont know why 3
  STR R1, [R2, #IO_BANK0_GPIO0_CTRL_OFFSET] @ set function in IO_BANK_CTRL to SIO
  BX LR

gpioinit_out:
  @ Initialize the GPIO
  MOV R3, #1
  LSL R3, R0                          @ shift over to pin position
  LDR R2, gpiobase                    @ address we want
  STR R3, [R2, #SIO_GPIO_OE_SET_OFFSET] @ set pin as output
  STR R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET] @ set first value to LOW
  
  @ Enable input and output for the pin
  LDR R2, padsbank0
  LSL R3, R0, #2                      @ pin * 4 for register address
  ADD R2, R3                          @ Actual set of registers for pin
  MOV R1, #PADS_BANK0_GPIO0_IE_BITS   @ set Input Enable in PAD register
  LDR R4, setoffset
  ORR R2, R4
  STR R1, [R2, #PADS_BANK0_GPIO0_OFFSET]
  
  @ Set the function number to SIO.
  LSL R0, #3                          @ each GPIO has 8 bytes of registers
  LDR R2, iobank0                     @ address we want
  ADD R2, R0                          @ add the offset for the pin number
  MOV R1, #IO_BANK0_GPIO3_CTRL_FUNCSEL_VALUE_SIO_3
  STR R1, [R2, #IO_BANK0_GPIO0_CTRL_OFFSET] @ set function in IO_BANK_CTRL to SIO
  BX LR

gpioget:
  LDR R2, =SIO_BASE                   @ for reading you need actual address not word
  LDR R3, [R2, #SIO_GPIO_IN_OFFSET]
  MOV R1, #1
  LSL R1, R0                          @ shift over to pin position; get pin mask
  AND R0, R3, R1                      @ R0 will be 0 or 1 << pin
  BX LR

turnOn:
  MOV R0, #LED_PIN1
  MOV R3, #1
  LSL R3, R0                          @ shift over to pin position
  LDR R2, gpiobase                    @ address we want
  STR R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]
  
  MOV R0, #LED_PIN2
  MOV R3, #1
  LSL R3, R0                          @ shift over to pin position
  LDR R2, gpiobase                    @ address we want
  STR R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]
  
  BX LR

turnOff:
  MOV R0, #LED_PIN1
  MOV R3, #1
  LSL R3, R0                          @ shift over to pin position
  LDR R2, gpiobase                    @ address we want
  STR R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]
  
  MOV R0, #LED_PIN2
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
