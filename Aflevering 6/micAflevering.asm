
; |*****************************************|
; |											|
; | AUR1 - Robtek							|
; |											|
; | William Bergmann Børresen 		wiboe14	|
; |	Daniel Franzéen Haraldson 		dahar14	|
; |	Joakim Grøn 					jokor11	|
; |											|
; |*****************************************|
; |											|
; | Afleveres: dato: 17/04/2015				|
; |											|
; |*****************************************|
; |											|
; | Written for MIC ATmega32A board			|
; | Afleverings opgave 4					|
; |											|
; |*****************************************|

.include "m32def.inc"

;Initialize programmet

;Entry point
.org	0x0000
RJMP	INIT

INIT:
; PORTB setup
						SBI 	DDRB, 3					;PORTB(3)


; Timer0 setup
						LDI		R16, 0b01111001
						OUT		TCCR0, R16				;Timer0 setup

; PORTA setup
						LDI		R16, 0
						OUT		DDRA, R16
						LDI		R16, 0b00100000
						OUT     ADMUX, R16				;Change the ref to 5v ref
						LDI		R16, 0b10100011
						OUT     ADCSRA, R16				;Set prescaler

						RJMP	LOOP					;Jump to LOOP

LOOP:
;Start the loop

						SBI		ADCSRA, ADSC			;start new coversion

WAIT:
;wait for ADC to be ready
						SBIS	ADCSRA, ADIF			;Check if the ADC has set the flag
						RJMP	WAIT					;If not jump  to WAIT
						SBI		ADCSRA, ADIF			;Clear ADC flag

;continue loop
						IN		R16, ADCL				;Read ADC low byte into R16
						IN		R16, ADCH				;Read ADC high byte into R16 to overrite low byte
						OUT		OCR0, R16				;Output the value from R16 (ADC HIGH) into the value for the timer to compare with

						RJMP	LOOP					;Jump to LOOP
