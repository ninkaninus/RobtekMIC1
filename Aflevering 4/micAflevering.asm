
; |*************************************|
; | William Bergmann Børresen - wiboe14	|
; |	Daniel Franzéen Haraldson - dahar14	|
; |	Joakim Grøn - 						|
; | AUR1 - Robtek						|
; | Afleveres: dato 					|
; |*************************************|
; | Written for MIC ATmega32A board		|
; | Afleverings opgave 4				|
; |*************************************|

.include "m32def.inc"

;Initialisér programmet

;Entry point
.org	0x0000
RJMP	INIT

INIT:
;Initialize the stack
						LDI		r16, low(RAMEND)
					    OUT		SPL, R16
						LDI		R16, high(RAMEND)
					    OUT		SPH, R16

; PORTB setup
						LDI		R16, 255
						OUT 	DDRB, R16 				;PORTB = OUTput
						LDI		R16, 255
						OUT		PORTB, R16				;Turn LEDS off

; PORTA setup
						LDI		R16, 0
						OUT		DDRA, R16
						LDI		R16, 0b00100000
						OUT     ADMUX, R16				;Change the ref to 5v ref
						LDI		R16, 0b11100011
						OUT     ADCSR, R16				;Set prescaler

						RJMP	LOOP

LOOP:
;Start programløkken

						SBI		ADCSR, ADSC				;start new coversion

WAIT:
;wait for adc to be ready
						SBIS	ADCSR, ADIF				;wait for ADC
						RJMP	WAIT
						SBI		ADCSR, ADIF
						IN		R16, ADCL
						IN		R16, ADCH
						OUT		PORTB, R16

						RJMP	LOOP
