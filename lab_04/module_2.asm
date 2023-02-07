PUBLIC output
EXTRN STR1: word

DSEG SEGMENT PARA PUBLIC 'DATA'
	msg db 'Numbers:$'
DSEG ENDS

CSEG SEGMENT PARA 'CODE'
ASSUME CS:CSEG, DS:DSEG
output proc near
	mov ax, DSEG ; Кладем адрес сегмента данных в ax
	mov ds, ax ; Кладем значение ах в ds
	
	mov dx, offset msg; Кладем начало строки в dx для вывода
	
	mov ah, 09 ; Функция вывода строки
	int 21h ; Вызов DOS
	
	mov dx, offset STR1 ; Кладем начало строки в dx для вывода
	
	int 21h ; Вызов DOS
	
	ret
output endp
CSEG ENDS
END