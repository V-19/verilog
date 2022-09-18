all:	correr sintesis clean


correr:	
	iverilog -o prueba tarea2testbench.v
	vvp prueba
	gtkwave resultados.vcd

sintesis:
	yosys -s 1.ys
	
clean:
	rm -f p
