
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
; PORTB setup
						SBI 	DDRB, 3				;PORTB(3)


; Timer0 setup
						LDI		R16, 0b01110001
						OUT		TCCR0, R16

; PORTA setup
						LDI		R16, 0
						OUT		DDRA, R16
						LDI		R16, 0b00100000
						OUT     ADMUX, R16				;Change the ref to 5v ref
						LDI		R16, 0b11100011
						OUT     ADCSRA, R16				;Set prescaler

						RJMP	LOOP

LOOP:
;Start programløkken

						SBI		ADCSRA, ADSC				;start new coversion

WAIT:
;wait for adc to be ready
						SBIS	ADCSRA, ADIF				;wait for ADC
						RJMP	WAIT
						SBI		ADCSRA, ADIF

;continue loop
						IN		R16, ADCL
						IN		R16, ADCH
						OUT		OCR0, R16

						RJMP	LOOP
