F		:= original
N		:= rfm12-mod
DOTOPTIONS 	:= -Grankdir=LR


all: reasm-check $N.diff $N.hex $N.bin $N.dot

clean:
	rm -f $F.{elf,bin,png,dot}
	rm -f $F.reasm.*
	rm -f $N.{elf,bin,png,dot}

$F.bin: $F.hex
	avr-objcopy -I ihex -O binary $< $@

#-------

$F.reasm.asm: $F.asm
	perl -pe 's/^\s*[0-9a-f]+:\s+/\t/; s/^; Referenced.*//; ' < $< > $@

#-------

$N.diff: $F.reasm.asm $N.asm
	-diff -u $^ > $@

%.elf: %.asm
	avr-gcc -x assembler -mmcu=at90s8535 $< -o $@ -nostdlib

$N.bin: $N.elf
	avr-objcopy -O binary -R .eeprom $< $@

$F.reasm.bin: $F.reasm.elf
	avr-objcopy -O binary -R .eeprom $< $@

$N.hex: $N.elf
	avr-objcopy -O ihex -R .eeprom $< $@

%.lss: %.elf
	avr-objdump -d $< > $@

%.dot: %.asm codeblocks.dot extract-flow-info
	rm -f $@
	echo "digraph flow {" >> $@
	./extract-flow-info < $< | uniq >> $@
	cat codeblocks.dot >> $@
	echo "}" >> $@

%.png: %.dot
	dot -Tpng ${DOTOPTIONS} -o $@ $<

#-------

reasm-check: $F.reasm.bin $F.bin
	diff $^

%-diff: $F.reasm.lss %.lss
	-diff -up $^

.PHONY: reasm-check
