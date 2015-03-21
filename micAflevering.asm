
; |*************************************|
; | William Bergmann Børresen			|
; | AUR1 - Robtek						|
; | Afleveres: dato 27-03-2015 kl 12:00	|
; |*************************************|
; | Written for MIC ATmega32A board		|
; | Afleverings opgave 2				|
; |*************************************|

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
							LDI		R16, 0x00				;
							OUT		DDRC, R16				; Set PORTC as input
							LDI		R16, 255				;
							OUT		PORTC,R16 				; Enable pull-up on PORTC

; PORTB setup
							OUT 	DDRB,R16 				; PORTB = output
							LDI		R16, 0xFF
							OUT		PORTB, R16				; Turn LEDS off

;Start programløkken
LOOP:

Aseg:
							LDI		R18, segA				;læs værdien af segA ind i R18
							OUT		PORTB, R18				;skriv værdien af R18 til PORTB (dispalyet)
							IN 		R17, PINC				;læs værdien af port c ind i R17
							LDI		R20, 0x97				;læs værdien 0x97 ind 9 R20
Loopa0:						LDI		R21, 0x06				;læs værdien 0x06 ind 9 R21
Loopa1:						LDI		R22, 0x92				;læs værdien 0x92 ind 9 R22
Loopa2:						DEC		R22						;træk en fra værdien i R22
							BRNE	Loopa2					;hvis der kunne trækkes en fra R22 så gå til Loopa2
							DEC		R21						;træk en fra værdien i R21
							BRNE	Loopa1					;hvis der kunne trækkes en fra R21 så gå til Loopa1
							DEC		R20						;træk en fra værdien i R20
							BRNE	Loopa0					;hvis der kunne trækkes en fra R20 så gå til Loopa0
							IN		R18, PINC				;læs værdien af port c ind i R18
							CP		R17, R18				;Sammenlign R17 og R18
							BREQ	Aseg					;Hvis CP gav true gå til Aseg
