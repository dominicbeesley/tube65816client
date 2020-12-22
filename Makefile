
HOSTFSDIR=~/hostfs/tools816
PITUBEDIR=/cygdrive/e/Users/dominic/GitHub/PiTubeDirect
BEMDIR=/cygdrive/e/Users/dominic/GitHub/b-em/roms/tube

all: dossy816_tubeos.bin

hostfs: all
	cp dossy816_tubeos.bin* $(HOSTFSDIR)

pitube: all
	cp dossy816_tubeos.bin tuberom_dominic65816.bin
	xxd -i -c 16 tuberom_dominic65816.bin > $(PITUBEDIR)/src/65816/tuberom_dominic65816.c
	rm tuberom_dominic65816.bin

bem: all
	cp dossy816_tubeos.bin Dossy_816.rom
	cp Dossy_816.rom $(BEMDIR)/
	rm Dossy_816.rom

symbols: dossy816_tubeos.bem

%.bem: %.sy2
	../../scripts/bemsymbols.pl < $< > $@


clean:
	rm -f *.o *.lst *.bin *.inc *~

%.o : %.asm
	ca65 -g -l $<.lst $<

%.bin %.sy2: %.o %.lkr
	ld65 -Ln $*.sy2 $< -o $@ -C $*.lkr

