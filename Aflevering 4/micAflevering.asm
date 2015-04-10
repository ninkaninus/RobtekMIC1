
; |*************************************|
; | William Bergmann Børresen			|
; | AUR1 - Robtek						|
; | Afleveres: dato 					|
; |*************************************|
; | Written for MIC ATmega32A board		|
; | Afleverings opgave 3				|
; |*************************************|

.include "m32def.inc"

;Initialisér programmet

;Entry point
.org	0x0000
rjmp	INIT

INIT:
;Initialize the stack
						LDI		R16, low(RAMEND)
					    OUT		SPL, R16
						LDI		R16, high(RAMEND)
					    OUT		SPH, R16

; PORTD setup
						;LDI	R16, ~((1<<PD2)|(1<<PD6))
						;OUT	DDRD, R16				;Set PORTD as input with no pullup's because the buttons has it already

; PORTB setup
						LDI		R16, 255
						OUT 	DDRB, R16 				;PORTB = output
						LDI		R16, 255
						OUT		PORTB, R16				;Turn LEDS off

						RJMP	LOOP					;Go to loop

;Start programløkken
LOOP:
						LDI		R17, HIGH(2655)			;Load the high end of the value 2655 in to R17
						LDI		R16, LOW(2655)			;Load the low end of the value 2655 in to R16
						LDI		R19, HIGH(74)			;Load the high end of the value 74 in to R19
						LDI		R18, LOW(74)			;Load the low end of the value 74 in to R18

						CALL SUM16						;Run SUM16

						LDI		R19, HIGH(592)			;Load the high end of the value 592 in to R19
						LDI		R18, LOW(592)			;Load the low end of the value 592 in to R18

						CALL SUM16						;Run SUM16

						LDI		R19, HIGH(1380)			;Load the high end of the value 1380 in to R19
						LDI		R18, LOW(1380)			;Load the low end of the value 1380 in to R18

						CALL SUM16						;Run SUM16

						LDI		R19, HIGH(17352)		;Load the high end of the value 17352 in to R19
						LDI		R18, LOW(17352)			;Load the low end of the value 17352 in to R18

						CALL SUM16						;Run SUM16

						LDI		R18, 5					;Load the value 5 in to R18

						CALL	DIV16_8					;Run DIV16_8

						MOV		R19, R18				;Shift the values up on registre
						MOV		R18, R17
						MOV		R17, R16

						COM		R19						;Compliment them so they can just be displayed on the display
						COM		R18
						COM		R17

						RJMP	PRINT_DIODE				;Run PRINT_DIODE

						RJMP	LOOP					;Run LOOP again

PRINT_DIODE:
						IN 		R16, PIND				;This function will print the values to the display
						ORI		R16, 0xBB
						COM		R16
						TST		R16
						BREQ	PRINT_DIODE_CLEAR
						CPI		R16, (1<<PD6)|(1<<PD2)
						BREQ	PRINT_DIODE_PD2_PD6
						SBRS	R16, PD6
						RJMP	PRINT_DIODE_PD2
PRINT_DIODE_PD6:
						OUT		PORTB, R17
						RJMP	PRINT_DIODE_END
PRINT_DIODE_PD2:
						OUT		PORTB, R18
						RJMP	PRINT_DIODE_END
PRINT_DIODE_PD2_PD6:
						OUT		PORTB, R19
						RJMP	PRINT_DIODE_END
PRINT_DIODE_CLEAR:
						LDI		R16, 255
						OUT		PORTB, R16
PRINT_DIODE_END:
						RJMP 	PRINT_DIODE
RET
SUM16:
						ADD		R16, R18				;Add the 2 low bytes together
						ADC		R17, R19				;Add the 2 high bytes together

RET

DIV16_8:
						CLR		ZH						;Clear ZH and ZL
						CLR		ZL

DIV16_8_LOOP:
						ADIW	ZH:ZL,	1				;Add one
						SUB		R16, R18				;Substract R16 with R18
						SBCI	R17, 0
						BRCC 	DIV16_8_LOOP			;If not under zero then loop

						SBIW	ZH:ZL, 1				;Substract one
						ADD		R16, R18				;Add R16 and R18 together
						MOV		R18, R16				;Move R16 into R18
						MOVW	R17:R16,ZH:ZL			;Move ZH and ZL into R17 and R16

RET
