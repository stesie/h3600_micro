F=ipaq-h3600-at90s8535

all: $F.bin

clean:
	rm -f $F.bin

$F.bin: $F.hex
	avr-objcopy -I ihex -O binary $< $@

