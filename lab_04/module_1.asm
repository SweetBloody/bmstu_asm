PUBLIC STR1
EXTRN output: near

SSEG SEGMENT PARA STACK 'STACK'
	db 100h dup (0)
SSEG ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
	STR1 db 10 dup(' '), '$' ; Инициализируем 10 символов пробелом и в конце $
DSEG ENDS

CSEG SEGMENT PARA 'CODE'
ASSUME CS:CSEG, DS:DSEG
main:
	mov ax, DSEG ; Кладем адрес сегмента данных в ax
	mov ds, ax ; Кладем значение ах в ds
	mov cx, 11 ; Цикл до 11
	mov ah, 01 ; Функция считывания символа из консоли с эхом
	mov bx, 0 ; 
	loop1:
		int 21h ; Вызов DOS
		cmp al, 0dh ; Проверка на то, что ввели Enter
		je exit_loop ; Выход из цикла
		mov STR1[bx], al ; Кладем считанное значение в строку
		inc bx ; Увеличиваем смещение
		loop loop1
exit_loop:
	call output ; Вызов функции вывода
	
	mov ah, 4ch ; Функция завершения процесса
	int 21h ; Вызов DOS
CSEG ENDS
END main
		