
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
;Turn on Serial comunnication
	LDI		R16,	(1<<RXEN)|(1<<TXEN)
	OUT		UCSRB,	R16

;Use UCSRC, set frame size = 8
	LDI		R16,	(1<<URSEL)|(1<<UCSZ1)|(1<<UCSZ0)
	OUT		UCSRC,	R16

;Set baud rate = 1200 (UBRR = 41510 = 0x19F)

	LDI		R16,	(1<<U2X)		;U2X = 1
	OUT		UCSRA,	R16
	LDI		R16,	12				;UBRR LSB
	OUT		UBRRL,	R16

LOOP:

RECIVE:
	SBIS	UCSRA,	RXC				;If RXC=1, Then UDR is ready to recive new data
	RJMP	RECIVE					;Jump to MODATG if no data recived
	IN		R17,	UDR				;Recive data
	mov 	R18,	R17				;Move the recived value into R18 from R17
	subi	R18,	'A'				;Substract the ASCII number for A (65) from the recived number
	brmi	SEND					;If the value is below 0 jump to SEND
	subi	R18,	26				;Substract 26 (number of caracteres in the english alphabet) from R18
	brmi	UPPER_TO_LOWER				;if below 0 jump to UPPER_TO_LOWER
	subi	R18,	6				;Substract 6 (the number of non letters between upper case and lower case letters) from R18 
	brmi	SEND					;If below 0 jump to LOWER_TO_UPPER
	subi	R18,	26				;Substract 26 (number of caracteres in the english alphabet) from R18
	brmi	LOWER_TO_UPPER				;If below 0 jump to LOWER_TO_UPPER
	RJMP	SEND					;If non of the other cases was true then jump to SEND

UPPER_TO_LOWER:
	LDI		R18,	32			;Load the value 32 (the difference between upper an lover case in ASCII) into R18
	ADD		R17,	R18			;Add R18 (32) to R17
	RJMP	SEND					;Jump to SEND

LOWER_TO_UPPER:
	SUBI	R17,	32				;Substract 32 (the difference between upper an lover case in ASCII) from R17
	RJMP	SEND					;Jump to SEND

SEND:
	SBIS	UCSRA,	UDRE			;IF UDRE=1, UDR is empty and ready to new data
	RJMP	SEND					;Jump to SEND if the data line is not bussy
	OUT		UDR,	R17				;SEND data
	RJMP	LOOP					;Loop forever
