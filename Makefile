F=ipaq-h3600-at90s8535
O=h3600_micro-hax0rd

all: $O.bin $O.hex $O.dot

clean:
	rm -f $F.bin
	rm -f $O.{elf,bin,hex,png,dot}

$F.bin: $F.hex
	avr-objcopy -I ihex -O binary $< $@

$O.asm: $F.asm
	perl -pe 's/^\s*[0-9a-f]+://' < $< > $@

$O.elf: $O.asm
	avr-gcc -x assembler -mmcu=at90s8535 $< -o $@ -nostdlib

$O.bin: $O.elf
	avr-objcopy -O binary -R .eeprom $< $@

$O.hex: $O.elf
	avr-objcopy -O ihex -R .eeprom $< $@

%.dot: %.asm codeblocks.dot extract-flow-info
	rm -f $@
	echo "digraph flow {" >> $@
	./extract-flow-info < $< | uniq >> $@
	cat codeblocks.dot >> $@
	echo "}" >> $@

%.png: %.dot
	dot -Tpng -o $@ $<
