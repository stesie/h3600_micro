F=ipaq-h3600-at90s8535
DISAS=avrdisas

all: $F.bin $F.asm

clean:
	rm -f $F.bin $F.asm

$F.bin: $F.hex
	avr-objcopy -I ihex -O binary $< $@

$F.asm: $F.bin $F.tag
	${DISAS} -a1 -o0 -c1 -s1 -p0 -l1 -t$F.tag -m8535 $< > $@
