
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
; | Afleveres: dato: 24/04/2015				|
; |											|
; |*****************************************|
; |											|
; | Written for MIC ATmega32A board			|
; | Afleverings opgave 6					|
; |											|
; |*****************************************|

.include "m32def.inc"

SETUP:
;Slå seriel kommunikation til
	LDI		R16,	(1<<RXEN)|(1<<TXEN)
	OUT		UCSRB,	R16

;Brug UCSRC, sæt frame size = 8
	LDI		R16,	(1<<URSEL)|(1<<UCSZ1)|(1<<UCSZ0)
	OUT		UCSRC,	R16

;Sæt baud rate = 1200 (UBRR = 41510 = 0x19F)

	LDI		R16,	(1<<U2X)		;U2X = 1
	OUT		UCSRA,	R16
	LDI		R16,	12				;UBRR LSB
	OUT		UBRRL,	R16
	;LDI		R16,	1				;UBRR MSB (URSEL = 0)
	;OUT		UBRRH,	R16

LOOP:

SEND:
	SBIS	UCSRA,	UDRE			;Hvis UDRE=1, så er UDR tom og klar til ny uddata
	RJMP	SEND
	LDI		R17,	66
	OUT		UDR,	R17				;Send data
	RJMP	SEND					;Fortsæt uendeligt
