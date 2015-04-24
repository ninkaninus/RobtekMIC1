
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

.ORG 0 ;RESET IRQ adresse
	JMP 	MAIN

.ORG 0x14 				;OFC0 IRQ adresse
	JMP 	OFC0_ISR 	;Opsæt ISR

.ORG 0x2A ;Skip vektor tabel

MAIN:
;Setup stak
	LDI 	R16, 	HIGH(RAMEND)
	OUT 	SPH, 	R16
	LDI 	R16, 	LOW(RAMEND)
	OUT 	SPL, 	R16


;Enable OFC interrupt på Timer0
	SEI
	LDI		R16,	(1<<OCIE0)
	OUT 	TIMSK, 	R16


;Setup Timer0 til CTC mode, 10 ticks
	LDI 	R16, 	0b00001001
	OUT 	OCR0, 	R16
	LDI 	R16, 	0x09 ;Ingen prescaler
	OUT 	TCCR0, 	R16
	LDI 	R20, 	0
 	OUT 	TCNT0, 	R20
	;LDI 	R20, 	25
 	;OUT		OCR0,	R20


;Opsæt PORTB til output
	LDI		R16, 	0xFF
	OUT 	DDRB, 	R16
	LDI		R16,	0x55
	OUT 	PORTB,	R16

; Initialize ... Whatever
	LDI 	R16, 	50 	;1-tal i LSB

LOOP:
	LDI		R16,	0x00
	OUT 	PORTB,	R16
	Call	DELAY_1MS
	LDI		R16,	0xFF
	OUT 	PORTB,	R16
	JMP 	LOOP


OFC0_ISR:
	LDI		R16,	0x00
	OUT 	PORTB,	R16
	Call	DELAY_1MS
	LDI		R16,	0xFF
	OUT 	PORTB,	R16
	JMP 	LOOP


DELAY_1MS:
		DELAY_1MS_C:										;									------------|
							LDI		R17, 120				;load 125 ind i R17			(1 Cycle)-------|	|
			DELAY_1MS_B:									;											|	|
							LDI		R18,10					;load 1 ind i R18			(1 Cycle)---|	|	|
				DELAY_1MS_A:								;										|	|	|
							NOP								;Do nothing for 1 cycle		(1 Cycle)	|A	|B	|C
							DEC		R18						;R18 - 1					(1 Cycle)	|	|	|
							BRNE	DELAY_1MS_A				;Jump to DELAY_1MS_0		(1 Cycle)---|	|	|
							DEC		R17						;R17 - 1					(1 Cycle)		|	|
							BRNE	DELAY_1MS_B				;Jump to DELAY_1MS_1		(1 Cycle)-------|	|
							DEC		R16						;R16 - 1					(1 Cycle)			|
							BRNE	DELAY_1MS_C				;Jump to DELAY_1MS_1		(1 Cycle)-----------|
	RET
