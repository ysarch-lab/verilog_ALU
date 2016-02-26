BINS=alu.test.run

all: $(BINS)

%.run: %.v
	iverilog -g 2009 -Wall $< -o $@

clean:
	rm -v *.run Makefile.deps


.INTERMEDIATE: $(BINS:.run=.v.dep)
%.v.dep: %.v
	$(eval TMPF=$(shell mktemp))
	iverilog -Minclude=$(TMPF) $< -o /dev/null
	sed -i -e "1i $@:" -e 's/\.v\.dep:/.run:/' $(TMPF)
	paste -sd ' ' $(TMPF) > $@
	paste -sd ' ' $(TMPF) | sed -e 's/\.v\.dep:/.run:/' >> $@
	rm -f $(TMPF)

Makefile.deps: $(BINS:.run=.v.dep)
	cat $^ > $@

include Makefile.deps
