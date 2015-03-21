
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
						LDI		R16, segA
						OUT		PORTB, R16				; Turn LEDS off

;Start programløkken
LOOP:
