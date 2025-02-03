PRG := enchforest.prg
X64 := x64
PETCAT := petcat
SRCS := enchanted_forest.bas

all: $(PRG)

$(PRG): $(SRCS)
	cat $(SRCS) | $(PETCAT) -w2 -o $(PRG) --

run: $(PRG)
	$(X64) -basicload $<

word_splitter.prg: word_splitter.bas
	cat word_splitter.bas | $(PETCAT) -w2 -o word_splitter.prg --

run-splitter: word_splitter.prg
	$(X64) -basicload word_splitter.prg

clean:
	rm -f *.prg
