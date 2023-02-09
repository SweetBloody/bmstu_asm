public convert_to_bin
EXTRN number: word

DSEG SEGMENT PARA PUBLIC 'DATA'
	msg_out db 'Number in bin: $'
DSEG ENDS

CSEG SEGMENT PARA PUBLiC 'CODE'
ASSUME CS:CSEG, DS:DSEG
convert_to_bin proc near
	mov ax, DSEG
	mov ds, ax
	
	mov dx, offset msg_out; Кладем начало строки в dx для вывода
	mov ah, 09 ; Функция вывода строки
	int 21h ; Вызов DOS
	
	mov bx, number
	rol bx, 1
	mov bx, number
	jnc no_sign
	
	sub bx, 1 ; Если первый бит единица, тогда отнимаем единицу и инвертируем
	not bx
	
no_sign:	
    mov cx, 16 ; Счётчик цикла
	mov ah, 02
 
	loop2:
		rol bx, 1 ; Циклический сдвиг AL влево на 1 бит
		jc print_1 ; Если выдвинутый бит = 1, то переход на написание единицы
		mov dl, '0' ; Пишем ноль
		int 21h
		jmp loop2_end
	print_1:
		mov dl, '1' ; Пишем единицу
		int 21h
	loop2_end:
		loop loop2
	ret
	
convert_to_bin endp
CSEG ENDS
END