@
@ Assembler program to imitate binary counting using 
@ three LEDs connected to the Raspberry Pi Pico
@ GPIO port using the Pico SDK.
@

.EQU	LED_A, 0		    @ equate which means define
.EQU	LED_B, 1		    @ define var LED_A as GP1 (pico pin 2)
.EQU	LED_C, 2
.EQU	LED_D, 3
.EQU	LED_E, 4
.EQU	LED_F, 5
.EQU	LED_G, 6

.EQU	GPIO_OUT, 1		    @ define GPIO_OUT address (reuse task3)
.EQU	sleep_time, 1000	@ var sleep_time is value 1000

.thumb_func		  	        @ Necessary because sdk uses BLX
.global main    		    @ Provide program starting address

main:
    @ --- configure LED A ---
    MOV	R0, #LED_A		    @ register 0 is now storing var LED_A
    BL	gpio_init		    @ initialize pin in other function
    MOV	R0, #LED_A  		@ reassign LED_A because init 
                            @ function could have changed stored
                            @ value in register 0
    MOV	R1, #GPIO_OUT		@ set register 1 as output variable
    BL	link_gpio_set_dir	@ go to function to configure output pin
	
    @ --- configure LED B ---
    MOV	R0, #LED_B		    @ store var LED_B on register 0
    BL	gpio_init		    @ ... same as LED A...
    MOV	R0, #LED_B
    MOV	R1, #GPIO_OUT
    BL	link_gpio_set_dir
	
    @ --- configure LED C ---
    MOV	R0, #LED_C
    BL	gpio_init
    MOV	R0, #LED_C
    MOV	R1, #GPIO_OUT
    BL	link_gpio_set_dir
    
    @ --- configure LED D ---
    MOV	R0, #LED_D
    BL	gpio_init
    MOV	R0, #LED_D
    MOV	R1, #GPIO_OUT
    BL	link_gpio_set_dir
    
    @ --- configure LED E ---
    MOV	R0, #LED_E
    BL	gpio_init
    MOV	R0, #LED_E
    MOV	R1, #GPIO_OUT
    BL	link_gpio_set_dir
    
    @ --- configure LED F ---
    MOV	R0, #LED_F
    BL	gpio_init
    MOV	R0, #LED_F
    MOV	R1, #GPIO_OUT
    BL	link_gpio_set_dir
    
    @ --- configure LED G ---
    MOV	R0, #LED_G
    BL	gpio_init
    MOV	R0, #LED_G
    MOV	R1, #GPIO_OUT
    BL	link_gpio_set_dir

    MOV R7, #0             	@ initialize counter
    MOV R6, #0			    @ initialize loop flag

start:

    MOV R0, #10
    BL link_gpio_put_all

    MOV R0, R7
    BL link_gpio_put_all
    
    @ pause for 1 second
    LDR R0, =sleep_time
    BL sleep_ms
    
    CMP R6, #0
    BEQ forwards
    B backwards

forwards:
    ADD R7, R7, #1    	    @ count 1 up
    CMP R7, #9          	@ see if R7 has reached limit of 9
    BEQ changeflagtoone
    B start

backwards:
    SUB R7, R7, #1      	@ count 1 down
    CMP R7, #0          	@ see if R7 has reached limit of 0
    BEQ changeflagtozero    @ if so, count forwards now
    B start                	@ otherwise continue main loop

changeflagtozero:
    MOV R6, #0
    B start
    
changeflagtoone:
    MOV R6, #1
    B start
