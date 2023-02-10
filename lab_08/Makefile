app.exe : main.o my_asm_copy.o my_string.o
	gcc $^ -o $@

main.o : main.c my_string.h
	gcc -c -ggdb $<

my_string.o : my_string.c my_string.h
	gcc -c -ggdb -masm=intel $<

my_asm_copy.o : my_asm_copy.asm
	nasm -f elf64 $<

clean:
	rm -rf *.o *.s