PRG := enchforest.prg
X64 := x64
PETCAT := petcat
SRCS := enchanted_forest.bas

all: $(PRG)

$(PRG): $(SRCS)
	cat $(SRCS) | $(PETCAT) -w2 -o $(PRG) --

run: $(PRG)
	$(X64) -basicload $<

clean:
	rm -f *.prg
