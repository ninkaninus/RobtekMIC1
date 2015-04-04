; ***********************************
; *
; * William Bergmann Børresen
; ***********************************
; * Written for MIC ATmega32A board
; *
; *
; ***********************************
.include "m32def.inc"

;værdier til dispaly

.equ segA=0b10111111
.equ segB=0b11110111
.equ segC=0b11111011
.equ segD=0b11111101
.equ segE=0b11111110
.equ segF=0b11101111

;Initialisér programmet
RESET:
; PORTC setup
			LDI		R16, 0x00
			OUT		DDRC, R16				; Set PORTC as input
			LDI		R16, 255
			OUT		PORTC,R16 				; Enable pull-up on PORTC

; PORTB setup
			OUT 	DDRB,R16 				; PORTB = output
			LDI		R16, 0xFF
			OUT		PORTB, R16				; Turn LEDS off

;Start programløkken
LOOP:

Aseg:
			LDI		R18, segA
			OUT		PORTB, R18
			IN 		R17, PINC			;læs værdien af port c ind i R17
			LDI		R20, 0x97			;læs værdien 0x97 ind 9 R20
Loopa0:		LDI		R21, 0x06			;læs værdien 0x06 ind 9 R21
Loopa1:		LDI		R22, 0x92			;læs værdien 0x92 ind 9 R22
Loopa2:		DEC		R22					;træk en fra værdien i R22
			BRNE	Loopa2				;hvis der kunne trækkes en fra R22 så gå til Loopa2
			DEC		R21					;træk en fra værdien i R21
			BRNE	Loopa1				;hvis der kunne trækkes en fra R21 så gå til Loopa1
			DEC		R20					;træk en fra værdien i R20
			BRNE	Loopa0				;hvis der kunne trækkes en fra R20 så gå til Loopa0
			IN		R18, PINC			;læs værdien af port c ind i R18
			CP		R17, R18			;Sammenlign R17 og R18
			BREQ	Aseg				;Hvis CP gav true gå til Aseg

Bseg:
			LDI		R18, segB
			OUT		PORTB, R18
			IN 		R17, PINC			;læs værdien af port c ind i R17
			LDI		R20, 0x97			;læs værdien 0x97 ind 9 R20
Loopb0:		LDI		R21, 0x06			;læs værdien 0x06 ind 9 R21
Loopb1:		LDI		R22, 0x92			;læs værdien 0x92 ind 9 R22
Loopb2:		DEC		R22					;træk en fra værdien i R22
			BRNE	Loopb2				;hvis der kunne trækkes en fra R22 så gå til Loopb2
			DEC		R21					;træk en fra værdien i R21
			BRNE	Loopb1				;hvis der kunne trækkes en fra R21 så gå til Loopb1
			DEC		R20					;træk en fra værdien i R20
			BRNE	Loopb0				;hvis der kunne trækkes en fra R20 så gå til Loopb0
			IN		R18, PINC			;læs værdien af port c ind i R18
			CP		R17, R18			;Sammenlign R17 og R18
			BREQ	Bseg				;Hvis CP gav true gå til Bseg

Cseg:
			LDI		R18, segC
			OUT		PORTB, R18
			IN 		R17, PINC			;læs værdien af port c ind i R17
			LDI		R20, 0x97			;læs værdien 0x97 ind 9 R20
Loopc0:		LDI		R21, 0x06			;læs værdien 0x06 ind 9 R21
Loopc1:		LDI		R22, 0x92			;læs værdien 0x92 ind 9 R22
Loopc2:		DEC		R22					;træk en fra værdien i R22
			BRNE	Loopc2				;hvis der kunne trækkes en fra R22 så gå til Loopc2
			DEC		R21					;træk en fra værdien i R21
			BRNE	Loopc1				;hvis der kunne trækkes en fra R21 så gå til Loopc1
			DEC		R20					;træk en fra værdien i R20
			BRNE	Loopc0				;hvis der kunne trækkes en fra R20 så gå til Loopc0
			IN		R18, PINC			;læs værdien af port c ind i R18
			CP		R17, R18			;Sammenlign R17 og R18
			BREQ	Cseg				;Hvis CP gav true gå til Cseg

Dseg:
			LDI		R18, segD
			OUT		PORTB, R18
			IN 		R17, PINC			;læs værdien af port c ind i R17
			LDI		R20, 0x97			;læs værdien 0x97 ind 9 R20
Loopd0:		LDI		R21, 0x06			;læs værdien 0x06 ind 9 R21
Loopd1:		LDI		R22, 0x92			;læs værdien 0x92 ind 9 R22
Loopd2:		DEC		R22					;træk en fra værdien i R22
			BRNE	Loopd2				;hvis der kunne trækkes en fra R22 så gå til Loopd2
			DEC		R21					;træk en fra værdien i R21
			BRNE	Loopd1				;hvis der kunne trækkes en fra R21 så gå til Loopd1
			DEC		R20					;træk en fra værdien i R20
			BRNE	Loopd0				;hvis der kunne trækkes en fra R20 så gå til Loopd0
			IN		R18, PINC			;læs værdien af port c ind i R18
			CP		R17, R18			;Sammenlign R17 og R18
			BREQ	Dseg				;Hvis CP gav true gå til Dseg

Eseg:
			LDI		R18, segE
			OUT		PORTB, R18
			IN 		R17, PINC			;læs værdien af port c ind i R17
			LDI		R20, 0x97			;læs værdien 0x97 ind 9 R20
Loope0:		LDI		R21, 0x06			;læs værdien 0x06 ind 9 R21
Loope1:		LDI		R22, 0x92			;læs værdien 0x92 ind 9 R22
Loope2:		DEC		R22					;træk en fra værdien i R22
			BRNE	Loope2				;hvis der kunne trækkes en fra R22 så gå til Loope2
			DEC		R21					;træk en fra værdien i R21
			BRNE	Loope1				;hvis der kunne trækkes en fra R21 så gå til Loope1
			DEC		R20					;træk en fra værdien i R20
			BRNE	Loope0				;hvis der kunne trækkes en fra R20 så gå til Loope0
			IN		R18, PINC			;læs værdien af port c ind i R18
			CP		R17, R18			;Sammenlign R17 og R18
			BREQ	Eseg				;Hvis CP gav true gå til Eseg

Fseg:
			LDI		R18, segF
			OUT		PORTB, R18
			IN 		R17, PINC			;læs værdien af port c ind i R17
			LDI		R20, 0x97			;læs værdien 0x97 ind 9 R20
Loopf0:		LDI		R21, 0x06			;læs værdien 0x06 ind 9 R21
Loopf1:		LDI		R22, 0x92			;læs værdien 0x92 ind 9 R22
Loopf2:		DEC		R22					;træk en fra værdien i R22
			BRNE	Loopf2				;hvis der kunne trækkes en fra R22 så gå til Loopf2
			DEC		R21					;træk en fra værdien i R21
			BRNE	Loopf1				;hvis der kunne trækkes en fra R21 så gå til Loopf1
			DEC		R20					;træk en fra værdien i R20
			BRNE	Loopf0				;hvis der kunne trækkes en fra R20 så gå til Loopf0
			IN		R18, PINC			;læs værdien af port c ind i R18
			CP		R17, R18			;Sammenlign R17 og R18
			BREQ	Fseg				;Hvis CP gav true gå til Fseg

			rjmp	LOOP
