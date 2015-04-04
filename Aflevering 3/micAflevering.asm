
; |*************************************|
; | William Bergmann Børresen			|
; | AUR1 - Robtek						|
; | Afleveres: dato 27-03-2015 kl 12:00	|
; |*************************************|
; | Written for MIC ATmega32A board		|
; | Afleverings opgave 2				|
; |*************************************|

.include "m32def.inc"

;Initialisér programmet

;Definitions
.def COUNTER = R20										;Use as a counter

;Constants
.equ NUMBER_OF_SEGMENTS = 5 							;Amout of segments

.org	0x60
segments: .db	0xBF, 0xF7, 0xFB, 0xFD, 0xFE, 0xEF		;List of values for the segments

;Entry point
.org	0x0000
rjmp	INIT

INIT:
;Initialize the stack
						LDI		R16, low(RAMEND)
					    OUT		SPL, R16
						LDI		R16, high(RAMEND)
					    OUT		SPH, R16

; PORTC setup
						LDI		R16, 0x00
						OUT		DDRC, R16				;Set PORTC as input
						LDI		R16, 255
						OUT		PORTC, R16 				;Enable pull-up on PORTC

; PORTB setup
						OUT 	DDRB, R16 				;PORTB = output
						LDI		R16, 0xBF
						OUT		PORTB, R16				;Turn LEDS off and A segment on

;Start programløkken
LOOP:
						RCALL	READ_SWITCH				;Jump to READ_SWITCH
						TST		R19						;Test if one of the switches are on
						BREQ	LOOP					;Jump to LOOP
						rcall 	INCREMENT_7SEG
						mov		R16, R19				;Move the value from R19 to R16
						rcall	DELAY_1MS				;Jumpt to DELAY_1MS

						rjmp	LOOP

READ_SWITCH:
						IN		R19, PINC				;Read the value of PINC (The switches)
						LDI		R16, 1					;Number of times to run the delay
						RCALL	DELAY_1MS				;Jump to DELAY_1MS
						IN		R16, PINC				;Read the value of PINC (The switches)
						CP		R16, R19				;Compare the 2 readings of the switches
						BRNE	READ_SWITCH				;Jump to READ_SWITCH
						com 	R19						;Take the operset of the orginal value
RET

DELAY_1MS:
	DELAY_1MS_C:										;									------------|
						LDI		R17, 125				;load 125 ind i R17			(1 Cycle)-------|	|
		DELAY_1MS_B:									;											|	|
						LDI		R18,1					;load 1 ind i R18			(1 Cycle)---|	|	|
			DELAY_1MS_A:								;										|	|	|
						NOP								;Do nothing for 1 cycle		(1 Cycle)	|A	|B	|C
						DEC		R18						;R18 - 1					(1 Cycle)	|	|	|
						BRNE	DELAY_1MS_A				;Jump to DELAY_1MS_0		(1 Cycle)---|	|	|
						DEC		R17						;R17 - 1					(1 Cycle)		|	|
						BRNE	DELAY_1MS_B				;Jump to DELAY_1MS_1		(1 Cycle)-------|	|
						DEC		R16						;R16 - 1					(1 Cycle)			|
						BRNE	DELAY_1MS_C				;Jump to DELAY_1MS_1		(1 Cycle)-----------|
RET

						;Loop A	=	R18*(1+1+1+2)-1	=	1*(5)-1			=	4 		(Cycles)
						;Loop B	=	R17*(A+1+1+2)-1	=	125*(8)-1		=	999		(Cycles)
						;Loop C	=	R16*(B+1+1+2)-1	=	R16*(1003)-1	=	HIGH(255764) , LOW(1002)




INCREMENT_7SEG:
						ldi 	ZH, high(segments<<1) 	;Load the high byte of the address
						ldi 	ZL, low(segments<<1)  	;Load the low byte of the address
						add 	ZL, COUNTER			  	;Add the ofset
						ldi 	R16, 0				  	;Load 0 into R16
						adc 	ZH, R16				  	;Add the carry to ZH

						lpm 	R16, Z				  	;Read the value z i pointing at into R16
						out 	PORTB, R16			 	;Output to PORTB (Display)

						ldi 	R16, NUMBER_OF_SEGMENTS	;Read the value of segments into R16
						cp 		COUNTER, R16			;Compare if the counter and the number of segments
						breq 	INCREMENT_7SEG_RESTART_COUNTER;if they are equal Jump to INCREMENT_7SEG_RESTART_COUNTER
						inc		COUNTER				  	;Add one to the counter
						rjmp 	INCREMENT_7SEG_END		;Jump to INCREMENT_7SEG_END
INCREMENT_7SEG_RESTART_COUNTER:
						ldi 	COUNTER, 0x00			;Reset the counter
INCREMENT_7SEG_END:
ret
