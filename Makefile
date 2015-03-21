# Makefile for programming ATmega32 using assembler

PROJECT=micAflevering

PROGRAMMER=-c usbasp -P usb #For the small programmer from ebay
#PROGRAMMER=-c avrispmkII -P usb # For the large blue AVR MKII
#PROGRAMMER=-c stk500v1 -P /dev/ttyUSB0 # For the small green programmer

default:
			avra $(PROJECT).asm
			sudo avrdude -p m32 $(PROGRAMMER) -U flash:w:$(PROJECT).hex

fuse:
			sudo avrdude -p m32 $(PROGRAMMER) -U hfuse:w:0xd9:m -U lfuse:w:0xe4:m

clean:
			rm -f $(PROJECT).obj $(PROJECT).hex $(PROJECT).cof $(PROJECT).eep.hex

erase:
			sudo avrdude -p m32 $(PROGRAMMER) -e
