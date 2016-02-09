all: alu.test.run

%.run: %.v sim.v
	iverilog -g 2005 -Wall $^ -o $@

clean:
	rm -v *.run
