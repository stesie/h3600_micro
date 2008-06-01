F=ipaq-h3600-at90s8535
O=h3600_micro-hax0rd
DISAS=avrdisas

all: $F.asm $O.bin $O.hex

clean:
	rm -f $F.bin $F.asm
	rm -f $O.{asm,elf,bin,hex}

$F.bin: $F.hex
	avr-objcopy -I ihex -O binary $< $@

$F.asm: $F.bin $F.tag
	${DISAS} -a1 -o0 -c1 -s1 -p0 -l1 -t$F.tag -m8535 $< > $@

$O.asm: $F.asm
	perl -pe 's/^\s*[0-9a-f]+://' < $< > $@

$O.elf: $O.asm
	avr-gcc -x assembler -mmcu=at90s8535 $< -o $@ -nostdlib

$O.bin: $O.elf
	avr-objcopy -O binary -R .eeprom $< $@

$O.hex: $O.elf
	avr-objcopy -O ihex -R .eeprom $< $@
