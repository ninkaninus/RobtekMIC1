# Makefile for programming ATmega32 using assembler

PROJECT=micAflevering

PROGRAMMER=-c usbasp -P usb #For the small programmer from ebay
#PROGRAMMER=-c avrispmkII -P usb # For the large blue AVR MKII
#PROGRAMMER=-c stk500v1 -P /dev/ttyUSB0 # For the small green programmer

HFuse=-U hfuse:w:0xd9:m #HIGH Fuse bit
LFuse=-U lfuse:w:0xe4:m #LOW Fuse bit

MicType=-p m32 #Microcontroler type

default:
			avra $(PROJECT).asm
			sudo avrdude $(MicType) $(PROGRAMMER) -U flash:w:$(PROJECT).hex

fuse:
			sudo avrdude $(MicType) $(PROGRAMMER) $(HFuse) $(LFuse)

clean:
			rm -f $(PROJECT).obj $(PROJECT).hex $(PROJECT).cof $(PROJECT).eep.hex

erase:
			sudo avrdude $(MicType) $(PROGRAMMER) -e
